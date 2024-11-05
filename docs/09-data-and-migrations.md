# Data and Migrations

Database changes must be deliberate, versioned, reviewed, and recoverable.

## Current State

- Services share one PostgreSQL database named `microservice`.
- Persistence-owning services use Flyway migrations.
- Hibernate schema management defaults to `validate`.
- Service ownership is enforced through schema-per-service defaults.

Backups, restores, CI migration tests, and data retention policies still need production implementation.

## Target State

- Every persistence-owning service has its own migration history.
- Production profiles do not use `ddl-auto=update`.
- Schema ownership is documented.
- Backups and restores are tested.
- Migrations are included in CI.

## First Ownership Model

For Docker Compose on a VPS, the project uses schema-per-service in one PostgreSQL instance.

Current schemas:

- `user_service`
- `job_service`
- `notification_service`
- `file_storage`

This keeps operations simple while creating clear ownership boundaries.

Later, move to database-per-service if scale, isolation, or operational needs require it.

## Migration Tool

Flyway is the selected migration tool.

Current migration files:

- `user-service/src/main/resources/db/migration/V1__init.sql`
- `job-service/src/main/resources/db/migration/V1__init.sql`
- `notification-service/src/main/resources/db/migration/V1__init.sql`
- `file-storage/src/main/resources/db/migration/V1__init.sql`

Current schema configuration:

```properties
spring.jpa.hibernate.ddl-auto=validate
spring.flyway.enabled=true
spring.flyway.schemas=<service_schema>
spring.flyway.default-schema=<service_schema>
spring.jpa.properties.hibernate.default_schema=<service_schema>
```

Schema names can be overridden with:

```text
USER_SERVICE_DB_SCHEMA
JOB_SERVICE_DB_SCHEMA
NOTIFICATION_SERVICE_DB_SCHEMA
FILE_STORAGE_DB_SCHEMA
```

## Running Migrations

Flyway runs automatically during service startup before Hibernate validates the schema.

For Docker Compose:

```bash
docker compose up --build
```

To inspect migration logs for one service:

```bash
docker compose logs -f user-service
```

When CI is added, each persistence-owning service should run migrations against a clean PostgreSQL instance before tests.

## Migration Rules

- Migrations are immutable after merge.
- New migrations must be backward compatible when possible.
- Destructive changes require a rollout plan.
- Large data changes should be separated from schema changes.
- Rollback or recovery steps must be documented.
- CI should run migrations against a clean database.

## Seed Data

Seed data should be separated into:

- Required reference data.
- Local development sample data.
- Test data.
- Production bootstrap data.

Default admin users must not be silently created in production startup code.

## Backup Strategy

Backups should cover:

- PostgreSQL.
- File storage volume.
- Deployment configuration.
- Image version records.

Minimum policy for early production:

- Daily PostgreSQL backup.
- Daily file storage backup.
- Backup retention policy.
- Off-server copy.
- Restore test before launch and after backup strategy changes.

## Restore Strategy

Restore documentation should include:

- Where backups are stored.
- How to restore PostgreSQL.
- How to restore file storage.
- How to validate restored data.
- How to restart services safely.
- How to communicate data loss if recovery point objective is exceeded.

## Data Retention

Before production, define:

- User deletion behavior.
- File deletion behavior.
- Notification retention.
- Audit data retention.
- Backup retention.
- Personal data handling rules.
