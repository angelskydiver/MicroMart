# Current State Assessment

## Service Inventory

| Service | Role | Current Notes |
| --- | --- | --- |
| `config-server` | Spring Cloud Config Server | Runs on port `8888`; currently reads config from the public GitHub repository. |
| `eureka-server` | Service discovery | Runs on port `8761`; services register dynamically. |
| `gateway` | API gateway | Runs on port `8080`; uses Spring Cloud Gateway and JWT validation. |
| `auth-service` | Authentication API | Handles register/login and calls `user-service` through Feign. |
| `user-service` | User/profile API | Uses JPA/PostgreSQL, JWT security, and Feign for file storage. |
| `job-service` | Example domain service | Manages categories, jobs, adverts, offers, Kafka notification producer, and Feign clients. |
| `notification-service` | Notification API and Kafka consumer | Persists notifications and consumes Kafka messages. |
| `file-storage` | File metadata and binary storage | Stores file metadata in PostgreSQL and files on the local filesystem. |

## Infrastructure

The root `docker-compose.yml` now starts the full local platform:

- PostgreSQL
- Zookeeper
- Kafka
- Kafka UI
- Config Server
- Eureka Server
- Gateway
- Auth Service
- User Service
- Job Service
- Notification Service
- File Storage

Each Spring service has a multi-stage Dockerfile. Gateway is the main local application entry point.

## Build System

- Each service is an independent Maven project.
- There is no root aggregator `pom.xml`.
- Services use Spring Boot `3.5.16`, Java `17`, and Spring Cloud `2025.0.3`.
- Springdoc API services use the Boot 3 compatible Springdoc starter.

## Configuration

- Shared config lives in `config/application.properties`.
- Services import Config Server through configurable `CONFIG_SERVER_URI` values.
- PostgreSQL, Kafka, Eureka, Config Server, CORS, JWT, file storage, and admin bootstrap settings are environment-driven.
- Config Server defaults to native local config locations instead of reading from the public GitHub repository.

## Data

- JPA services use one PostgreSQL database named `microservice`.
- Persistence-owning services use schema-per-service ownership:
  - `user_service`
  - `job_service`
  - `notification_service`
  - `file_storage`
- Flyway `V1__init.sql` migrations create the current schema baseline.
- Hibernate schema management defaults to `validate`.
- Cross-service identifiers remain plain columns instead of cross-schema foreign keys.

## Security

- JWT signing secrets are read from `security.jwt.secret`.
- PostgreSQL credentials are environment-driven.
- Kafka and Zookeeper allow anonymous/plaintext access in the local Compose file.
- Admin bootstrap is disabled by default and requires explicit environment/config values.
- Endpoint authorization exists in some services, but it needs a full review.

## File Storage

`file-storage` uses the configurable `file-storage.path` setting. For production, this should point to a durable mounted volume or object storage integration.

Production-like deployment should move files to:

- A configured mounted volume for Docker Compose.
- Object storage in a later cloud deployment.

## Testing

Current tests are mostly generated `contextLoads()` tests. The project does not yet have meaningful coverage for:

- Controllers and validation.
- Security rules.
- JPA repositories and migrations.
- Feign clients.
- Kafka producers and consumers.
- Gateway routes and filters.
- End-to-end smoke flows.
- Load or resilience behavior.

## Observability

- Actuator is configured across all services.
- Services expose health, liveness, readiness, info, and metrics endpoints for internal/local use.
- Docker Compose healthchecks use actuator health endpoints for Spring services.
- Basic log formatting includes timestamp, level, service name, thread, logger, and message.
- Prometheus/Grafana, tracing, alerting, centralized logging, and operational runbooks still need implementation.

## CI/CD

The repository does not currently include:

- CI workflow.
- Docker image build and publish pipeline.
- Vulnerability scan.
- Release versioning policy.
- Deployment automation.
- Rollback procedure.

## Readiness Summary

The project is valuable as a reference foundation but is not ready for production or mass users. The highest-priority gaps are:

- Externalize secrets and environment-specific config.
- Containerize all services.
- Replace schema auto-update with migrations.
- Add production-grade persistence and file storage.
- Add real tests and CI/CD gates.
- Add observability, backup, restore, rollback, and incident response.
