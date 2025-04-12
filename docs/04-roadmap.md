# Roadmap

This roadmap moves the repository from reference foundation to production-ready reference platform. It is intentionally phased so each step creates a usable checkpoint.

## Phase 1: Documentation and Baseline

Goal: make the current state understandable and remove confusion about production readiness.

Deliverables:

- Root README as project entry point.
- Documentation index.
- Current-state assessment.
- Target architecture.
- Build principles.
- Production readiness gates.

Exit criteria:

- A new engineer can understand the service layout, limitations, and planned path without reading every source file.
- The docs clearly state that the current project is not mass-user ready.

## Phase 2: Configuration and Secrets

Goal: remove hardcoded and localhost-only assumptions.

Status: foundation started. The project now has environment-driven service config, `.env.example`, configurable JWT secrets, configurable CORS origins, native Config Server defaults, and opt-in admin bootstrap.

Deliverables:

- `.env.example` for local and VPS deployment.
- Environment-driven Config Server, Eureka, PostgreSQL, Kafka, and JWT settings.
- No hardcoded JWT secrets.
- No sample database password in deploy configuration.
- Config Server using a deployment-controlled config source.

Exit criteria:

- Services can run in local and Docker networks without source changes.
- Secrets are injected through environment or secret storage.

## Phase 3: Containerization

Goal: make every service build and run repeatably.

Status: implemented for the local/VPS foundation. The repository now has service Dockerfiles and a full Compose platform. Production deployment still needs reverse proxy/TLS, backup automation, and release workflow hardening.

Deliverables:

- Dockerfile for each Spring Boot service.
- Compose file that runs all services and infrastructure.
- Pinned infrastructure image versions.
- Internal Docker network.
- Volumes for PostgreSQL, Kafka, and file storage.
- Healthchecks and restart policies.

Exit criteria:

- A fresh machine can start the platform with documented Compose commands.
- Public exposure guidance is documented; production should expose only the reverse proxy or gateway.

## Phase 4: Persistence and Migrations

Goal: replace prototype schema management with safe, reviewable database changes.

Status: implemented for the initial schema baseline. The four persistence-owning services now use Flyway `V1__init.sql` migrations with schema-per-service ownership, and Hibernate defaults to schema validation.

Deliverables:

- Flyway or Liquibase in each persistence-owning service.
- Schema-per-service or database-per-service decision.
- Initial migrations for current entities.
- Seed data policy.
- Backup and restore documentation.

Exit criteria:

- `spring.jpa.hibernate.ddl-auto=update` is not used by default.
- Migrations are defined for the current entity baseline.
- Migrations still need automated CI verification.
- Restore has been tested from backup.

## Phase 5: Security Hardening

Goal: make the platform safe enough for real users.

Deliverables:

- Externalized token signing configuration.
- Removed hardcoded admin bootstrap or replaced with controlled initialization.
- Reviewed authorization rules.
- CORS policy.
- Rate limits at gateway or reverse proxy.
- Protected actuator endpoints.
- Dependency and image vulnerability scans.

Exit criteria:

- No known sample credentials or secrets remain in production paths.
- Threat model and security checklist are documented.

## Phase 6: Reliability and Observability

Goal: make production behavior visible and recoverable.

Status: baseline actuator observability is implemented. All services include Actuator, expose health/readiness/liveness endpoints, and Docker Compose healthchecks use actuator endpoints for Spring services. Metrics stack, tracing, alerts, dashboards, and runbooks remain future work.

Deliverables:

- Actuator health/readiness endpoints for all services.
- Structured logs with correlation IDs.
- Metrics and dashboards.
- Distributed tracing plan.
- Kafka retry and dead-letter strategy.
- Feign timeout, retry, and circuit-breaker policy.
- Runbooks for common incidents.

Exit criteria:

- Operators can perform basic health/readiness checks.
- Full diagnose/respond capability still requires dashboards, alerts, tracing, and runbooks.
- Alerts exist for core service, database, Kafka, and disk failures.

## Phase 7: Production Readiness Gates

Goal: define the minimum bar before mass-user launch.

Deliverables:

- Security gate.
- Reliability gate.
- Performance gate.
- Data protection gate.
- Operations gate.
- Release and rollback gate.

Exit criteria:

- A release cannot be called production-ready unless every gate has evidence.

## Phase 8: Testing and CI/CD

Goal: make quality and release checks automatic.

Status: baseline CI is implemented. GitHub Actions runs Maven tests for all eight services and validates/builds the Docker Compose platform. Deeper integration, contract, security, load, vulnerability scanning, image publishing, and deployment automation remain future work.

Deliverables:

- Unit, slice, integration, contract, security, Kafka, and smoke tests.
- Testcontainers for infrastructure-backed tests.
- Load test scripts and thresholds.
- CI pipeline for build, test, scan, and image publishing.
- Deployment workflow for the VPS.

Exit criteria:

- Main branch has baseline automated build/test checks.
- Image publishing and version traceability still need implementation.
- Rollback has a documented and tested path.

## Phase 9: Kubernetes Evolution

Goal: move beyond one-server deployment when scale and operations require it.

Deliverables:

- Kubernetes deployment design.
- ConfigMap and Secret strategy.
- Ingress and TLS design.
- Persistent storage plan.
- Autoscaling and resource requests.
- Managed database and Kafka options.

Exit criteria:

- The Compose platform is stable enough to migrate intentionally rather than as a rescue project.
