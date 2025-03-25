# ADR 0001: Initial Deployment Target

## Status

Accepted

## Context

The current project is a Spring Boot microservices reference platform with independent Maven services, PostgreSQL, Kafka, Zookeeper, Eureka, Config Server, and API Gateway.

The goal is to evolve it into a reusable real-world reference platform. The first deployment target must be practical and teach production fundamentals without immediately requiring Kubernetes complexity.

## Decision

Use Docker Compose on a single VPS as the first production-style deployment target.

Kubernetes remains a future target after the Compose deployment is stable, observable, secure, and tested.

## Consequences

Benefits:

- Faster first deployable milestone.
- Easier local-to-server mental model.
- Lower operational cost.
- Good platform for learning containerization, configuration, secrets, healthchecks, backups, and rollback.

Tradeoffs:

- Limited horizontal scaling.
- Limited self-healing compared with Kubernetes.
- More manual operational responsibility.
- Requires careful VPS hardening and backup procedures.

## Follow-Up Work

- Add Dockerfiles for every service.
- Expand Compose to run the full platform.
- Add `.env.example`.
- Protect public exposure with a reverse proxy and TLS.
- Add healthchecks, backups, restore tests, and rollback docs.
- Revisit Kubernetes when traffic, availability, or team needs justify it.
