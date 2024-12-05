# Security Hardening

This project still contains prototype-friendly security shortcuts. Some foundation issues have been reduced, but the project is not safe for real users until the remaining security gates are satisfied.

## Immediate Risks

- JWT secrets are now configurable, but every deployed environment must provide strong environment-specific signing material.
- Database credentials are environment-driven, but local defaults are suitable only for non-production use.
- Kafka and Zookeeper allow anonymous/plaintext access in local Compose.
- Admin bootstrap is now opt-in, but any enabled bootstrap flow must use a controlled password hash and be disabled after setup.
- Internal services and operational endpoints need a clear exposure policy.
- File upload validation and storage policy need hardening.

## Secrets

Production rules:

- No secrets in source code.
- No secrets in Docker images.
- No real `.env` files committed.
- Secrets must be injected by environment variables or a secret manager.
- JWT signing material must be long, randomly generated, rotated, and environment-specific.

Recommended variables:

```text
JWT_SECRET
POSTGRES_USER
POSTGRES_PASSWORD
SPRING_PROFILES_ACTIVE
CONFIG_SERVER_URI
EUREKA_URI
KAFKA_BOOTSTRAP_SERVERS
CORS_ALLOWED_ORIGINS
```

## Authentication

The auth service should:

- Use a configurable token signing secret or key pair.
- Define token expiry.
- Define refresh-token strategy if needed.
- Reject disabled or locked users.
- Avoid returning sensitive user fields.
- Rate limit login attempts at gateway or reverse proxy.

## Authorization

Authorization rules should be documented per endpoint.

Minimum checks:

- Public endpoints are explicitly listed.
- Admin endpoints require admin role.
- User-owned resources require ownership or admin role.
- Gateway routes match downstream service authorization.
- Tests cover both allowed and denied access.

## Admin Bootstrap

Admin bootstrap is disabled by default and controlled through configuration.

Production alternatives:

- One-time CLI command.
- Database migration that creates a disabled admin record and requires password setup.
- Secure bootstrap endpoint available only during installation.
- Manual insert through a controlled operational process.

Whatever approach is selected, default credentials must not exist in production.

## Network Exposure

Production Compose should expose only the reverse proxy publicly.

Keep private:

- PostgreSQL.
- Kafka.
- Zookeeper.
- Eureka.
- Config Server.
- Spring service ports.
- Actuator endpoints.
- Kafka UI unless separately protected.

## File Uploads

File upload handling should define:

- Maximum file size.
- Allowed content types.
- Filename handling.
- Storage location.
- Virus or malware scanning strategy.
- Retention and deletion policy.
- Authorization for download and delete.

Never trust client-provided filenames or content types without validation.

## CORS and Browser Clients

Production CORS must:

- Allow only known origins.
- Restrict methods and headers.
- Avoid wildcard credentials.
- Be configured per environment.

## Dependency and Image Security

CI should scan:

- Maven dependencies.
- Docker base images.
- Committed secrets.
- Known vulnerable transitive dependencies.

High-risk findings should block release unless explicitly accepted with an expiry date.

## Threat Model Topics

Before production, document threats and mitigations for:

- Authentication and token theft.
- Privilege escalation.
- File upload abuse.
- Kafka message poisoning.
- Service-to-service trust.
- Database access.
- Configuration leakage.
- Denial of service.
