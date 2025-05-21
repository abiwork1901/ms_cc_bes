# Credit Card Application Backend

A Spring Boot-based backend application for credit card processing, providing RESTful APIs with data persistence.

## Tech Stack

- Java 17
- Spring Boot 3.2.3
- Spring Data JPA
- H2 Database
- Springdoc OpenAPI (Swagger)
- Lombok
- Spring Actuator

## Prerequisites

- JDK 17 or higher
- Maven 3.9+

## Development Setup

1. Build the project:
   ```bash
   mvn clean install
   ```

2. Run the application:
   ```bash
   mvn spring-boot:run
   ```
   The server will start at [http://localhost:8080](http://localhost:8080)

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/creditcard/
│   │       ├── config/       # Configuration classes
│   │       ├── controller/   # REST controllers
│   │       ├── model/        # Domain models
│   │       ├── repository/   # Data repositories
│   │       ├── service/      # Business logic
│   │       └── Application.java
│   └── resources/
│       ├── application.properties  # Application configuration
│       └── application-prod.properties
└── test/
    └── java/                 # Test classes
```

## API Documentation

The API documentation is available via Swagger UI:
- Development: http://localhost:8080/swagger-ui.html
- Production: {host}/swagger-ui.html

## Database

The application uses H2 in-memory database by default:
- Console: http://localhost:8080/h2-console
- JDBC URL: jdbc:h2:mem:creditcarddb
- Username: sa
- Password: (empty)

## Testing

Run the test suite:
```bash
mvn test
```

## Health Checks

Spring Actuator endpoints:
- Health: http://localhost:8080/actuator/health
- Info: http://localhost:8080/actuator/info

## Environment Profiles

- Development: Default profile with H2 database
- Production: Configured in application-prod.properties

## Building for Production

Create a production JAR:
```bash
mvn clean package -DskipTests
```

The JAR will be created in the `target/` directory. 