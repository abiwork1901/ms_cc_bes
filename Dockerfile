# Stage 1: Build Backend
FROM maven:3.9-amazoncorretto-17 AS backend-build
WORKDIR /app/backend
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Final Runtime
FROM amazoncorretto:17-alpine

# Create volume for logs
VOLUME /logs

# Expose ports
EXPOSE 8080

# Set environment variables
ENV SPRING_PROFILES_ACTIVE=prod \
    JAVA_OPTS="-Xmx512m -Xms256m"

# Start both nginx and Spring Boot application
CMD ["/bin/sh", "/app/start.sh"] 