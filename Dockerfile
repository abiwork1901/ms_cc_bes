# Stage 1: Build Frontend
FROM node:18-alpine as frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ .
RUN npm run build

# Stage 2: Build Backend
FROM maven:3.9-amazoncorretto-17 AS backend-build
WORKDIR /app/backend
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 3: Final Runtime
FROM amazoncorretto:17-alpine

# Install nginx
RUN apk add --no-cache nginx

# Create necessary directories
WORKDIR /app
RUN mkdir -p /run/nginx

# Copy frontend build from frontend stage
COPY --from=frontend-build /app/frontend/build /usr/share/nginx/html

# Copy backend jar from backend stage
COPY --from=backend-build /app/backend/target/*.jar app.jar

# Create startup script with proper line endings
RUN printf '#!/bin/sh\necho "Starting nginx..."\nnginx\necho "Starting Spring Boot application..."\nexec java -jar /app/app.jar\n' > /app/start.sh && \
    chmod +x /app/start.sh && \
    cat /app/start.sh

# Create nginx config
RUN printf 'server {\n\
    listen 80;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
    \n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
    \n\
    location /api/ {\n\
        proxy_pass http://localhost:8080/;\n\
        proxy_http_version 1.1;\n\
        proxy_set_header Upgrade $http_upgrade;\n\
        proxy_set_header Connection "upgrade";\n\
        proxy_set_header Host $host;\n\
        proxy_set_header X-Real-IP $remote_addr;\n\
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n\
        proxy_set_header X-Forwarded-Proto $scheme;\n\
    }\n\
}\n' > /etc/nginx/http.d/default.conf

# Create volume for logs
VOLUME /logs

# Expose ports
EXPOSE 80 8080

# Set environment variables
ENV SPRING_PROFILES_ACTIVE=prod \
    JAVA_OPTS="-Xmx512m -Xms256m"

# Start both nginx and Spring Boot application
CMD ["/bin/sh", "/app/start.sh"] 