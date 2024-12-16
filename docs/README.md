# Documentation

This folder documents the path from the current Spring Boot microservices reference foundation to a production-ready reference platform.

The project is not currently ready for mass-user production traffic. These documents define the target architecture, build principles, readiness gates, and implementation roadmap needed before a real launch.

## Reading Order

1. [Vision and Scope](01-vision-and-scope.md)
2. [Current State Assessment](02-current-state-assessment.md)
3. [Target Architecture](03-target-architecture.md)
4. [Roadmap](04-roadmap.md)
5. [Build Principles](05-build-principles.md)
6. [Production Readiness](06-production-readiness.md)
7. [VPS Docker Compose Deployment](07-vps-docker-compose-deployment.md)
8. [Security Hardening](08-security-hardening.md)
9. [Data and Migrations](09-data-and-migrations.md)
10. [Observability and Operations](10-observability-and-operations.md)
11. [Testing Strategy](11-testing-strategy.md)
12. [CI/CD](12-ci-cd.md)

## Decision Records

- [ADR 0001: Deployment Target](adr/0001-deployment-target.md)

## How To Use These Docs

- Use the current-state assessment to understand current limitations.
- Use the roadmap to plan implementation phases.
- Use production readiness gates before deploying to real users.
- Keep docs updated whenever architecture, deployment, or operational behavior changes.
