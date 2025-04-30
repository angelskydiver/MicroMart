# Build Principles

These principles guide all implementation work after the documentation phase.

## Build From Contracts

Define public behavior before changing internals.

- Document REST APIs with OpenAPI.
- Document Kafka event names, payloads, owners, and versioning.
- Keep backward compatibility for published APIs and persisted data.
- Prefer explicit request and response DTOs over exposing entity models.

## Keep Services Independently Owned

Each service should have clear responsibility.

- A service owns its source code, configuration, schema, migrations, and tests.
- Services should not directly write another service's data.
- Shared code should be introduced only when duplication becomes meaningful and stable.

## Prefer Secure Defaults

Production profiles must be safe by default.

- No hardcoded secrets.
- No sample passwords.
- No anonymous infrastructure access in deploy profiles.
- No public database, Kafka, Config Server, or Eureka ports.
- Operational endpoints must be authenticated or network-restricted.

## Make Deployment Repeatable

Every service should run the same way across environments.

- Build versioned container images.
- Use environment-driven configuration.
- Pin infrastructure image versions.
- Keep startup, healthcheck, migration, backup, and rollback steps documented.

## Own Data Changes

Database changes are production changes.

- Use Flyway or Liquibase for schema changes.
- Review migrations like application code.
- Test migrations against realistic data.
- Avoid destructive migrations unless a rollback or recovery path exists.

## Treat Observability As Product Behavior

A feature is not production ready if it cannot be operated.

- Emit structured logs.
- Include correlation IDs across gateway and services.
- Expose health and readiness checks.
- Publish metrics for latency, errors, throughput, and dependencies.
- Add alerts for user-impacting failures.

## Test Where Failures Happen

Do not rely only on `contextLoads()` tests.

- Unit test domain logic.
- Slice test controllers, validation, and security.
- Integration test PostgreSQL, Kafka, and Feign behavior.
- Smoke test deployed environments.
- Load test before claiming scale readiness.

## Design For Failure

Every external dependency can fail.

- Set timeouts on outbound calls.
- Use bounded retries.
- Add circuit breakers where failure isolation matters.
- Use dead-letter topics for poison Kafka messages.
- Make repeated operations idempotent where practical.

## Plan Rollback Before Release

Each release should include:

- Versioned artifact or image.
- Verification steps.
- Rollback steps.
- Migration safety notes.
- Known operational risks.
