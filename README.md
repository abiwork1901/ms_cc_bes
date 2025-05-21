# Credit Card Application Backend - Docker Setup

This is the Spring Boot backend service for the Credit Card Application.

## Prerequisites

- Docker

## Quick Start

1. Build the Docker image:
   ```bash
   docker build -t ms-cc-backend .
   ```

2. Run the container:
   ```bash
   docker run -d -p 8080:8080 --name ms-cc-backend-container ms-cc-backend
   ```

3. Access the application:
   - Backend API: http://localhost:8080
   - H2 Console: http://localhost:8080/h2-console
   - Actuator Endpoints: http://localhost:8080/actuator

## Container Details

- Spring Boot application running on OpenJDK 17 (Amazon Corretto)
- H2 in-memory database
- Log volume mounted at `/logs`
- Port 8080 exposed for API access

## Environment Variables

- `SPRING_PROFILES_ACTIVE`: Set to `prod` by default
- `JAVA_OPTS`: JVM options (`-Xmx512m -Xms256m` by default)

## Stopping the Container

```bash
docker stop ms-cc-backend-container
docker rm ms-cc-backend-container
```

## Viewing Logs

```bash
docker logs ms-cc-backend-container
``` 