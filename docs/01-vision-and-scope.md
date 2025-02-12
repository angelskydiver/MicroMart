# Vision and Scope

## Vision

Build this repository into a reusable Spring Boot microservices reference platform that shows how to design, secure, deploy, test, and operate real services.

The project should be useful for learning, portfolio work, team onboarding, and as a starting point for production-style microservice systems. It should not present prototype shortcuts as production patterns.

## Target Users

- Backend engineers learning Spring Boot microservices.
- Teams that need a practical reference for gateway, service discovery, config, persistence, messaging, and operations.
- Developers who want a Docker Compose first path before moving to Kubernetes.

## Goals

- Keep the existing service layout as the baseline reference architecture.
- Make local development repeatable.
- Make VPS deployment possible with Docker Compose.
- Define production readiness gates before any mass-user launch.
- Document security, data ownership, observability, testing, CI/CD, and operational practices.
- Keep the platform generic enough to adapt to different domains.

## Non-Goals

- This documentation phase does not make the code production ready by itself.
- Docker Compose on one VPS is not the final answer for large-scale traffic.
- The project is not tied to one business domain, even though the current reference domain uses users, jobs, adverts, offers, notifications, and files.
- Kubernetes, autoscaling, and multi-region deployment are future evolution topics, not the first implementation target.

## Success Criteria

The project can be considered a real reference platform when:

- Every service can be built, tested, containerized, and deployed repeatably.
- Secrets and environment-specific values are externalized.
- Database changes are migration-managed.
- Logs, metrics, health checks, traces, and alerts are available.
- Backups, restores, rollbacks, and incident response are documented and tested.
- CI/CD enforces quality and security gates.
- Load tests prove the platform can handle the defined traffic target.

## Mass-User Readiness Position

The current project is a reference foundation. It can become production ready only after implementation work satisfies the readiness gates in [Production Readiness](06-production-readiness.md).
