# Config Server Quick Start

## 1-Minute Startup

### Start Config Server Locally
```bash
cd services/config-server
./mvnw spring-boot:run
```
Server runs at `http://localhost:8888`

### Using Docker Compose
```bash
cd deployments/docker-compose
docker-compose up -d
```
All services start automatically (Eureka + Config Server)

## Get Configuration

### Room Service Development Config
```bash
curl http://localhost:8888/room-service/dev
```

**Expected Output:**
```json
{
  "name": "room-service",
  "profiles": ["dev"],
  "label": "main",
  "version": "...",
  "state": null,
  "propertySources": [
    {
      "name": "file:/Users/{user}/.config-repo/room-service-dev.properties",
      "source": {
        "spring.jpa.hibernate.ddl-auto": "create-drop",
        "spring.jpa.show-sql": "true",
        ...
      }
    }
  ]
}
```

### Available Configurations
```bash
# Room Service
curl http://localhost:8888/room-service/dev
curl http://localhost:8888/room-service/staging
curl http://localhost:8888/room-service/prod

# Booking Service
curl http://localhost:8888/booking-service/dev
curl http://localhost:8888/booking-service/staging
curl http://localhost:8888/booking-service/prod
```

## Health Check
```bash
curl http://localhost:8888/actuator/health
```

**Expected Response:**
```json
{
  "status": "UP",
  "components": {
    "db": {"status": "UP"},
    "diskSpace": {"status": "UP"},
    "livenessState": {"status": "UP"},
    "readinessState": {"status": "UP"}
  }
}
```

## Update Configuration

### 1. Edit Configuration File
```bash
cd ~/.config-repo
nano room-service-dev.properties
# Make changes
```

### 2. Commit to Git
```bash
git add room-service-dev.properties
git commit -m "Update database connection pool size"
git log  # Verify commit
```

### 3. Verify Config Server Picks Up Changes
```bash
curl http://localhost:8888/room-service/dev
# Check version field changed
```

## Configure a Client Service

### Add Dependencies to pom.xml
```xml
<!-- In pom.xml of your microservice -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-config</artifactId>
</dependency>

<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

### Create bootstrap.properties
```properties
# src/main/resources/bootstrap.properties
spring.application.name=room-service
spring.cloud.config.uri=http://localhost:8888
spring.cloud.config.profile=dev
spring.cloud.config.fail-fast=true
```

**For Production Docker:**
```properties
spring.cloud.config.uri=http://config-server:8888
eureka.client.serviceUrl.defaultZone=http://discovery-server:8761/eureka/
```

### Use Configuration in Code
```java
@Component
public class DatabaseConfig {
    
    @Value("${spring.datasource.url}")
    private String dbUrl;
    
    @PostConstruct
    public void init() {
        System.out.println("Database URL: " + dbUrl);
    }
}
```

## Current Configuration Files

| File | Service | Environment | Database |
|------|---------|-------------|----------|
| `room-service-dev.properties` | Room Service | Development | localhost:3306 |
| `room-service-staging.properties` | Room Service | Staging | mysql-staging |
| `room-service-prod.properties` | Room Service | Production | mysql-prod |
| `booking-service-dev.properties` | Booking Service | Development | localhost:3306 |
| `booking-service-staging.properties` | Booking Service | Staging | mysql-staging |
| `booking-service-prod.properties` | Booking Service | Production | mysql-prod |

## Monitoring

### View Metrics
```bash
curl http://localhost:8888/actuator/metrics
```

### Prometheus Metrics
```bash
curl http://localhost:8888/actuator/prometheus
```

### Server Info
```bash
curl http://localhost:8888/actuator/info
```

## Refresh Configuration Without Restart

**Client Service (Room Service example):**

1. Ensure client has actuator enabled
2. Update configuration in git repository
3. Call refresh endpoint:
```bash
curl -X POST http://localhost:8081/actuator/refresh
```

## Docker Commands

### Build Config Server Image
```bash
cd services/config-server
docker build -t config-server:1.0 .
```

### Run as Container
```bash
docker run \
  -p 8888:8888 \
  -e eureka.client.serviceUrl.defaultZone=http://discovery-server:8761/eureka/ \
  config-server:1.0
```

### View Container Logs
```bash
docker logs -f config-server
# or
docker-compose logs -f config-server
```

### Container Health Check
```bash
docker inspect config-server | grep -A 10 Health
```

## Logs

### View Application Logs
```bash
# If running with ./mvnw spring-boot:run
# Logs appear in console

# If using Docker Compose
docker-compose logs -f config-server

# Last 100 lines
docker-compose logs -n 100 config-server
```

### Set Log Level
```properties
# In application.properties
logging.level.root=INFO
logging.level.org.springframework.cloud=DEBUG
logging.level.org.eclipse.jgit=DEBUG
```

## Common Tasks

### Add New Service Configuration
```bash
cd ~/.config-repo
echo "spring.application.name=new-service" > new-service-dev.properties
echo "server.port=8083" >> new-service-dev.properties
git add new-service-dev.properties
git commit -m "Add configuration for new-service"
```

### Check Git Repository State
```bash
cd ~/.config-repo
git status
git log --oneline
git branch -a
```

### Verify Service Discovery
```bash
# Check if config-server is registered with Eureka
curl http://localhost:8761/eureka/apps/config-server
```

### Test Configuration Endpoint
```bash
# Get all profiles for a service
curl http://localhost:8888/config-server/default

# Get with label
curl http://localhost:8888/room-service/dev/main

# Get raw properties
curl http://localhost:8888/room-service/dev/main/room-service-dev.properties
```

## Troubleshooting

### Config Server Won't Start
```bash
# Check port 8888 is available
lsof -i :8888

# Check Java/Maven installation
./mvnw --version
java -version
```

### Cannot Connect to Config Server
```bash
# Verify it's running
curl http://localhost:8888/actuator/health

# Check Eureka registration
curl http://localhost:8761/eureka/apps
```

### Configuration Not Found (404)
```bash
# Verify file exists
ls ~/.config-repo/

# Verify filename matches: {app}-{profile}.properties
# Example: room-service-dev.properties

# Check git repository
cd ~/.config-repo && git log
```

### Git Repository Issues
```bash
# Initialize if missing
git init ~/.config-repo
cd ~/.config-repo
git config user.email "config-server@example.com"
git config user.name "Config Server"
```

## Next Steps

1. **Start Config Server:** `./mvnw spring-boot:run`
2. **Test Endpoint:** `curl http://localhost:8888/room-service/dev`
3. **Add to Service:** Include config client in microservice
4. **Configure Profiles:** Update properties by environment
5. **Deploy:** Use Docker Compose for local, K8s for production

## Integration with Other Services

- **Eureka:** Config Server registers automatically, clients discover it
- **Room Service:** Will retrieve `room-service-{profile}.properties`
- **Booking Service:** Will retrieve `booking-service-{profile}.properties`
- **API Gateway:** Will retrieve `api-gateway-{profile}.properties`

## Key Endpoints

| Endpoint | Purpose |
|----------|---------|
| `GET /{app}/{profile}` | Get configuration |
| `GET /{app}/{profile}/{label}` | Get with git branch |
| `GET /actuator/health` | Health check |
| `GET /actuator/metrics` | JVM metrics |
| `GET /actuator/prometheus` | Prometheus format |
| `POST /actuator/refresh` | Force refresh (clients) |

---

**For detailed information, see README.md**
