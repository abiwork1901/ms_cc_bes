# Build and Runtime stage
FROM maven:3.9-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM amazoncorretto:17-alpine
WORKDIR /app

# Copy backend jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Create volume for logs
VOLUME /logs

# Expose Spring Boot port
EXPOSE 8080

# Set environment variables
ENV SPRING_PROFILES_ACTIVE=prod \
    JAVA_OPTS="-Xmx512m -Xms256m"

# Start Spring Boot application
CMD ["java", "-jar", "/app/app.jar"] 