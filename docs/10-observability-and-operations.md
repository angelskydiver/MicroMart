# Observability and Operations

Production systems need visibility before incidents happen. This project should treat observability as a required part of every service.

## Health and Readiness

Implemented baseline: every Spring service includes Actuator and exposes:

- Liveness health.
- Readiness health.
- Dependency health for database, Kafka, Config Server, and Eureka where relevant.

Actuator endpoints should be protected and not exposed publicly.

Current endpoints:

```text
/actuator/health
/actuator/health/liveness
/actuator/health/readiness
/actuator/metrics
```

Docker Compose healthchecks use:

```text
/actuator/health
/actuator/health/readiness
```

Prometheus scraping is not implemented yet.

## Logging

Logs should be structured and consistent.

Implemented baseline: shared console logging includes timestamp, level, service name, thread, logger, and message.

Required fields:

- Timestamp.
- Service name.
- Environment.
- Log level.
- Trace ID.
- Request ID.
- User ID when safe and available.
- Error code.

Do not log:

- Passwords.
- JWTs.
- Full secrets.
- Sensitive personal data.

## Metrics

Implemented baseline: Actuator `/actuator/metrics` is exposed for internal/local use.

Track at minimum:

- Request count.
- Request latency.
- Error rate.
- JVM memory and CPU.
- Database connection pool usage.
- Kafka producer errors.
- Kafka consumer lag.
- Disk usage for database and file storage.
- Gateway route errors and latency.

## Tracing

Not implemented yet.

Distributed tracing should connect:

- Gateway request.
- Downstream service calls.
- Feign calls.
- Kafka publish and consume flow where practical.

Use correlation IDs even before a full tracing backend is introduced.

## Dashboards

Not implemented yet.

Minimum dashboards:

- Platform overview.
- Gateway traffic.
- Service health.
- PostgreSQL health.
- Kafka health.
- JVM and container resources.
- File storage disk usage.

## Alerts

Not implemented yet.

Minimum alerts:

- Service unavailable.
- High 5xx rate.
- High latency.
- PostgreSQL unavailable.
- Kafka unavailable.
- Consumer lag above threshold.
- Disk near full.
- Backup failure.
- TLS certificate close to expiry.
- Repeated authentication failures.

## Runbooks

Create runbooks for:

- Service will not start.
- Database unavailable.
- Kafka unavailable.
- Config Server unavailable.
- Eureka registration failure.
- Disk full.
- High latency.
- High error rate.
- Failed deployment.
- Rollback.
- Restore from backup.

Each runbook should include symptoms, likely causes, commands to inspect, mitigation steps, and escalation owner.

## Operational Ownership

Before production launch, define:

- Who owns each service.
- Who can deploy.
- Who responds to incidents.
- Where logs and dashboards live.
- Where secrets are managed.
- How incidents are reviewed.
