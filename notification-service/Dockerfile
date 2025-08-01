FROM maven:3.9.11-eclipse-temurin-17-jammy AS build
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
RUN mvn -ntp -DskipTests package

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd --system spring \
    && useradd --system --gid spring spring
COPY --from=build /workspace/target/*.jar /app/app.jar
USER spring:spring
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75.0 -XX:+ExitOnOutOfMemoryError"
EXPOSE 8084
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
