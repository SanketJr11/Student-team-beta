# Spring Cloud Config Server

## Overview
The Config Server provides centralized configuration management for all microservices in the system. Configuration properties are stored in a Git repository and dynamically fetched by client services at runtime.

## Architecture
- **Central Configuration Repository:** Git-based configuration storage
- **Dynamic Reload:** Clients can refresh configuration without restart
- **Environment Separation:** Dev, staging, and production configurations
- **Eureka Integration:** Config Server registers itself for service discovery
- **Multi-profile Support:** Named configurations per service and environment

## Technology Stack
- **Java:** 21 LTS
- **Framework:** Spring Boot 3.2.5
- **Spring Cloud Version:** 2023.0.1
- **Server Port:** 8888
- **Backend:** File-based Git repository
- **Package Manager:** Maven

## Key Features
✅ Centralized configuration management  
✅ Git-based version control for configurations  
✅ Environment-specific profiles (dev, staging, prod)  
✅ Service discovery via Eureka registration  
✅ REST API for configuration retrieval  
✅ Actuator monitoring and health checks  
✅ Docker containerization  
✅ Production-ready configuration  

## Configuration Properties

### Config Server Settings
```properties
spring.application.name=config-server
server.port=8888

# Git Backend
spring.cloud.config.server.git.uri=file://${user.home}/.config-repo
spring.cloud.config.server.git.default-label=main
spring.cloud.config.server.git.search-paths={application}

# Eureka Registration
eureka.client.serviceUrl.defaultZone=http://localhost:8761/eureka/
eureka.instance.preferIpAddress=true
```

## Building the Project

### Prerequisites
- Java 21 JDK
- Maven 3.8.1+
- Git (for configuration repository)

### Build from Source
```bash
# Navigate to config-server directory
cd services/config-server

# Build the project
./mvnw clean package

# Run the application
./mvnw spring-boot:run
```

### Build Docker Image
```bash
# Build Docker image
docker build -t config-server:1.0 .

# Run container
docker run -p 8888:8888 config-server:1.0
```

### Using Docker Compose
```bash
# Start all services including Config Server
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f config-server
```

## API Endpoints

### Configuration Retrieval
- **URL:** `http://localhost:8888/{application}/{profile}`
- **Method:** GET
- **Response:** Configuration properties for service and environment

**Examples:**
```bash
# Get room-service development configuration
curl http://localhost:8888/room-service/dev

# Get booking-service production configuration
curl http://localhost:8888/booking-service/prod

# Get default (no profile) configuration
curl http://localhost:8888/api-gateway/default
```

### File-based Retrieval
- **URL:** `http://localhost:8888/{application}/{profile}/{label}/{filename}`
- **Method:** GET
- **Response:** Configuration file content

### Health Check
- **URL:** `http://localhost:8888/actuator/health`
- **Method:** GET
- **Response:** Service health status

### Actuator Endpoints
- **Health:** `http://localhost:8888/actuator/health`
- **Info:** `http://localhost:8888/actuator/info`
- **Metrics:** `http://localhost:8888/actuator/metrics`
- **Prometheus:** `http://localhost:8888/actuator/prometheus`
- **Config Server:** `http://localhost:8888/actuator/configserver`

## Configuration Repository Structure

The configuration repository is located at `~/.config-repo/` and contains:

```
.config-repo/
├── room-service-dev.properties
├── room-service-staging.properties
├── room-service-prod.properties
├── booking-service-dev.properties
├── booking-service-staging.properties
├── booking-service-prod.properties
└── .git/ (version control)
```

### Naming Convention
Configuration files follow the pattern: `{application}-{profile}.properties`

**Examples:**
- `room-service-dev.properties` - Room Service in development
- `booking-service-prod.properties` - Booking Service in production
- `api-gateway-staging.properties` - API Gateway in staging

## Client Configuration

### Service Discovery Client Dependencies
Add to each microservice's `pom.xml`:

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-config</artifactId>
</dependency>

<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

### Enable Config Client
Create `src/main/resources/bootstrap.properties`:

```properties
spring.application.name=room-service
spring.cloud.config.uri=http://localhost:8888
spring.cloud.config.profile=dev
spring.cloud.config.fail-fast=true
```

Or use `bootstrap.yml`:

```yaml
spring:
  application:
    name: room-service
  cloud:
    config:
      uri: http://localhost:8888
      profile: dev
      fail-fast: true
    discovery:
      enabled: true
      service-id: config-server

eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
```

### Using Configuration in Code

```java
@Configuration
public class AppConfig {
    
    @Value("${spring.datasource.url}")
    private String dataSourceUrl;
    
    @Value("${server.port}")
    private Integer serverPort;
    
    @Bean
    public DataSource dataSource() {
        // Use injected values
        return createDataSource(dataSourceUrl);
    }
}
```

## Dynamic Configuration Refresh

### Refresh Configuration Without Restart

1. Update configuration in git repository:
```bash
cd ~/.config-repo
# Edit room-service-dev.properties
git add room-service-dev.properties
git commit -m "Update database URL"
```

2. Refresh client application:
```bash
curl -X POST http://localhost:8081/actuator/refresh
```

**Note:** This requires `spring-boot-starter-actuator` in client service.

## Environment Variables & Security

### Protected Credentials
Use environment variables for sensitive data:

```properties
# In config file
spring.datasource.password=${DB_PASSWORD}
```

### Set Environment Variables
```bash
# Linux/Mac
export DB_PASSWORD=your_secure_password

# Or in Docker
docker run -e DB_PASSWORD=your_secure_password config-server:1.0
```

## Monitoring

### Health Checks
- **Liveness Probe:** `http://localhost:8888/actuator/health/liveness`
- **Readiness Probe:** `http://localhost:8888/actuator/health/readiness`

### Metrics
Access Prometheus metrics at:
```
http://localhost:8888/actuator/prometheus
```

## Directory Structure
```
config-server/
├── src/
│   ├── main/
│   │   ├── java/com/example/config_server/
│   │   │   └── ConfigServerApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       └── java/com/example/config_server/
│           └── ConfigServerApplicationTests.java
├── pom.xml
├── Dockerfile
├── .dockerignore
├── mvnw
└── mvnw.cmd
```

## Troubleshooting

### Configuration Not Found
1. Verify file exists in `~/.config-repo/`
2. Check filename matches pattern: `{application}-{profile}.properties`
3. Ensure git repository is initialized: `cd ~/.config-repo && git log`
4. Restart Config Server to reload repository

### Client Cannot Connect
1. Verify Config Server is running: `curl http://localhost:8888/actuator/health`
2. Check Eureka registration: `http://localhost:8761/` (look for config-server)
3. Verify network connectivity between services
4. Check client bootstrap configuration

### Git Repository Errors
1. Verify git is initialized: `git init ~/.config-repo`
2. Check file permissions: `chmod 755 ~/.config-repo`
3. Ensure git user is configured:
   ```bash
   cd ~/.config-repo
   git config user.email "config-server@example.com"
   git config user.name "Config Server"
   ```

## Performance Tuning

### Cache Configuration
```properties
# Cache timeout (default: 0, no caching)
spring.cloud.config.server.native.search-locations=...
```

### Git Clone Depth
```properties
# Reduce repository size for large repos
spring.cloud.config.server.git.clone-on-start=true
spring.cloud.config.server.git.repos.default.uri=...
```

## Security Considerations

### For Production Deployment
1. Use encrypted properties: `spring-cloud-config-server-encryption`
2. Enable Spring Security for API access
3. Use HTTPS/TLS for Config Server communication
4. Implement authentication for git repository access
5. Restrict configuration file permissions
6. Use network segmentation (private subnets)
7. Enable audit logging

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
docker-compose up -d config-server
```

### Staging/Production
1. Use remote Git repository (GitHub, GitLab, Gitea)
2. Configure SSH keys for repository access
3. Set up Git webhooks for auto-refresh
4. Use managed container orchestration (Kubernetes)
5. Configure encrypted properties for sensitive data
6. Enable monitoring and alerting
7. Use environment-specific profiles

## Contributing
- Follow Spring Boot best practices
- Maintain health check endpoints
- Document configuration changes
- Test with client services before deployment
- Version control all configurations

## References
- [Spring Cloud Config Documentation](https://cloud.spring.io/spring-cloud-config/multi/)
- [Spring Cloud Config Client](https://cloud.spring.io/spring-cloud-config/multi/multi_spring-cloud-config-client.html)
- [Git Backend Configuration](https://cloud.spring.io/spring-cloud-config/multi/multi__spring_cloud_config_server.html#_git_backend)
- [Spring Boot Actuator](https://spring.io/guides/gs/actuator-service/)

## License
MIT License (as per project)
