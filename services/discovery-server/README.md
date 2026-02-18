# Eureka Discovery Server

## Overview
The Eureka Discovery Server is a Spring Cloud Netflix Eureka server that provides service registration and discovery capabilities for the microservices architecture. All microservices register themselves with Eureka, allowing them to discover and communicate with each other.

## Architecture
- **Service Discovery:** Centralized registry for all microservices
- **Health Monitoring:** Automatic heartbeat detection and service deregistration
- **Load Balancing:** Client-side load balancing with registered services
- **Dashboard:** Web UI to view registered services and their status

## Technology Stack
- **Java:** 21 LTS
- **Framework:** Spring Boot 3.2.5
- **Spring Cloud Version:** 2023.0.1
- **Server Port:** 8761
- **Package Manager:** Maven

## Key Features
✅ Service registration and discovery  
✅ Health check endpoints  
✅ Actuator monitoring  
✅ Docker containerization  
✅ Production-ready configuration  

## Configuration

### Application Properties
```properties
spring.application.name=eureka-server
server.port=8761

# Eureka Server - Don't register with itself
eureka.client.register-with-eureka=false
eureka.client.fetch-registry=false

# Actuator Configuration
management.endpoints.web.exposure.include=health,info,metrics,prometheus
management.endpoint.health.show-details=always
management.health.livenessState.enabled=true
management.health.readinessState.enabled=true
```

## Building the Project

### Prerequisites
- Java 21 JDK
- Maven 3.8.1+

### Build from Source
```bash
# Navigate to the discovery-server directory
cd services/discovery-server

# Build the project
./mvnw clean package

# Run the application
./mvnw spring-boot:run
```

### Build Docker Image
```bash
# Build Docker image
docker build -t eureka-server:1.0 .

# Run container
docker run -p 8761:8761 eureka-server:1.0
```

### Using Docker Compose
```bash
# Start all services including Eureka
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f discovery-server
```

## API Endpoints

### Health Check
- **URL:** `http://localhost:8761/actuator/health`
- **Method:** GET
- **Response:** Service health status

### Actuator Endpoints
- **Health:** `http://localhost:8761/actuator/health`
- **Info:** `http://localhost:8761/actuator/info`
- **Metrics:** `http://localhost:8761/actuator/metrics`
- **Prometheus:** `http://localhost:8761/actuator/prometheus`

### Eureka Dashboard
- **URL:** `http://localhost:8761/`
- **Content:** Web UI showing all registered services, instances, and their status

### Service Registration API
- **URL:** `http://localhost:8761/eureka/apps`
- **Method:** GET
- **Response:** JSON list of all registered applications

## Client Registration

### Service Discovery Client Dependencies
Add to each microservice's `pom.xml`:

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

### Enable Eureka Client
Add annotation to your Spring Boot application:

```java
@SpringBootApplication
@EnableEurekaClient
public class YourServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(YourServiceApplication.class, args);
    }
}
```

### Client Configuration
```yaml
spring:
  application:
    name: your-service-name
  
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
  instance:
    preferIpAddress: true
    lease-renewal-interval-in-seconds: 10
    lease-expiration-duration-in-seconds: 30
```

## Monitoring

### Health Checks
- **Liveness Probe:** `http://localhost:8761/actuator/health/liveness`
- **Readiness Probe:** `http://localhost:8761/actuator/health/readiness`

### Metrics
Access Prometheus metrics at:
```
http://localhost:8761/actuator/prometheus
```

## Directory Structure
```
discovery-server/
├── src/
│   ├── main/
│   │   ├── java/com/example/eureka_server/
│   │   │   └── EurekaServerApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       └── java/com/example/eureka_server/
│           └── EurekaServerApplicationTests.java
├── pom.xml
├── Dockerfile
├── .dockerignore
├── mvnw
└── mvnw.cmd
```

## Troubleshooting

### Service Registration Issues
1. Ensure client application has `@EnableEurekaClient` annotation
2. Verify client configuration has correct `defaultZone` URL
3. Check network connectivity between client and Eureka server

### No Services Appearing
1. Wait 1-2 minutes for client heartbeat (default interval: 30s)
2. Check application logs for registration errors
3. Verify Eureka server is running: `curl http://localhost:8761/actuator/health`

### High Memory Usage
1. Adjust Eureka cache refresh intervals
2. Check for orphaned service instances in dashboard
3. Monitor instance count in metrics

## Performance Tuning

### Eureka Server Configuration
```properties
# Cache configuration
eureka.server.registry-sync-retries=0
eureka.server.registry-fetch-interval-seconds=30

# Instance eviction configuration
eureka.server.eviction-interval-timer-in-ms=60000
eureka.instance.lease-expiration-duration-in-seconds=90
```

### Client Configuration
```properties
# Reduce traffic to Eureka server
eureka.client.fetch-registry-interval-seconds=30
eureka.instance.lease-renewal-interval-in-seconds=30
```

## Security Considerations

### For Production Deployment
1. Enable Spring Security for Eureka dashboard access
2. Use HTTPS/TLS for Eureka server communication
3. Implement authentication for service registration
4. Use network segmentation (private subnets)
5. Enable audit logging

### Example Security Configuration
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

## Deployment

### Local Development
```bash
docker-compose up -d discovery-server
```

### Staging/Production
1. Use managed container orchestration (Kubernetes)
2. Configure persistent storage for registry state
3. Set up Eureka peer replication for HA
4. Enable monitoring and alerting
5. Use environment-specific configurations

## Contributing
- Follow Spring Boot best practices
- Maintain health check endpoints
- Document configuration changes
- Test with client services before deployment

## References
- [Spring Cloud Eureka Documentation](https://cloud.spring.io/spring-cloud-netflix/multi/multi_spring-cloud-eureka-server.html)
- [Spring Boot Actuator](https://spring.io/guides/gs/actuator-service/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

## License
MIT License (as per project)
