# Credit Card Application - Docker Setup

This application consists of a React frontend and Spring Boot backend, combined into a single Docker container.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. Build and run the application:
   ```bash
   docker-compose up --build
   ```

2. Access the application:
   - Frontend: http://localhost:80
   - Backend API: http://localhost:8080

## Container Details

- Single container running both frontend and backend
- Frontend: React app served via Nginx
- Backend: Spring Boot application
- Nginx configured to proxy API requests to backend
- Health checks enabled
- Log volume mounted at `./logs`

## Environment Variables

- `SPRING_PROFILES_ACTIVE`: Set to `prod` by default
- `JAVA_OPTS`: JVM options (`-Xmx512m -Xms256m` by default)

## Stopping the Application

```bash
docker-compose down
``` 