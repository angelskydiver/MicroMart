# Production Readiness

Production readiness means the system can serve real users with known risk, measurable capacity, operational visibility, and a tested recovery path.

Completing documentation does not make the project production ready. Implementation must satisfy the gates below.

## Required Targets

Before a production launch, define these numbers:

- Expected registered users.
- Expected daily active users.
- Peak requests per second.
- P95 and P99 latency targets.
- Error-rate target.
- Uptime target.
- Recovery time objective.
- Recovery point objective.
- Storage growth per month.
- Deployment frequency.

## Gate 1: Security

Required evidence:

- No hardcoded JWT secrets, passwords, or admin credentials.
- Secrets are supplied through environment variables or secret storage.
- Production CORS policy is defined.
- Public routes are documented.
- Authorization rules are tested.
- Actuator and internal services are not publicly exposed.
- Dependencies and container images are scanned.
- Threat model is documented for gateway, auth, file upload, Kafka, and database access.

## Gate 2: Reliability

Required evidence:

- Every service has health and readiness checks.
- Every service has restart policy and resource expectations.
- Feign clients have timeouts.
- Retry behavior is bounded.
- Kafka consumers have retry and dead-letter behavior.
- File storage has durable volume or object storage.
- Failure modes are documented in runbooks.

## Gate 3: Data Protection

Required evidence:

- Production profile does not use `ddl-auto=update`.
- Migrations are versioned and tested.
- Database ownership boundaries are documented.
- Backup schedule is documented.
- Restore is tested.
- Sensitive data handling is documented.
- Deletion and retention behavior are documented.

## Gate 4: Observability

Required evidence:

- Structured logs are available for every service.
- Correlation IDs flow from gateway to downstream services.
- Metrics cover request rate, latency, errors, JVM, database, Kafka, and disk usage.
- Alerts exist for service down, high error rate, high latency, database unavailable, Kafka unavailable, disk near full, and certificate expiry.
- Dashboards exist for system health and service health.

## Gate 5: Performance and Scale

Required evidence:

- Load test scenario matches expected user behavior.
- Load test meets target requests per second and latency.
- Database connection pool sizing is reviewed.
- JVM memory limits are set for containers.
- Kafka throughput and consumer lag are observed under load.
- Gateway limits and reverse proxy limits are documented.

## Gate 6: Release and Rollback

Required evidence:

- CI passes build, test, and scan checks.
- Images are versioned and traceable to commits.
- Deployment steps are automated or documented exactly.
- Smoke tests run after deployment.
- Rollback steps are tested.
- Migrations are compatible with rollback strategy or have a documented recovery path.

## Gate 7: Operations

Required evidence:

- VPS access, firewall, TLS, backups, log rotation, and disk monitoring are configured.
- Runbooks exist for common incidents.
- On-call or owner responsibility is clear.
- Maintenance windows and deployment communication are defined.
- Post-incident review process is documented.

## Production Decision

The project is production-ready only when all gates have evidence. If any gate is missing, the project may still be useful for development, staging, internal trials, or limited private users, but not for mass-user public launch.
