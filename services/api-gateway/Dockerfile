# Multi-stage Dockerfile for API Gateway
# Build stage: Compile and package the application
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

# Copy Maven wrapper and project files
COPY mvnw mvnw.cmd pom.xml ./
COPY .mvn .mvn
COPY src src

# Build the application
RUN chmod +x ./mvnw && \
    ./mvnw clean package -DskipTests -q

# Runtime stage: Minimal JRE image with only the JAR
FROM eclipse-temurin:21-jre

WORKDIR /home/app

# Copy built JAR from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Create non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

# Expose gateway port
EXPOSE 8080

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health/liveness || exit 1

# Start the application
ENTRYPOINT ["java", "-XX:+UseG1GC", "-XX:MaxRAMPercentage=75.0", "-Dspring.profiles.active=${SPRING_PROFILE:-dev}", "-jar", "app.jar"]
