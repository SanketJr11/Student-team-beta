# Build stage
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /build
COPY . .
RUN chmod +x ./mvnw && ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre
WORKDIR /app

# Create config repository directory
RUN mkdir -p /home/app/.config-repo && chmod 755 /home/app/.config-repo

# Copy the JAR from builder stage
COPY --from=builder /build/target/config-server-*.jar config-server.jar

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8888/actuator/health/liveness || exit 1

# Expose Config Server port
EXPOSE 8888

# Set user
USER app

# Run the application
ENTRYPOINT ["java", "-jar", "config-server.jar"]
