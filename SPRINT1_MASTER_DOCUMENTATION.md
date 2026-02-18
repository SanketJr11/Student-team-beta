# 📖 SPRINT 1 - MASTER DOCUMENTATION
## College Classroom Booking System - Complete Project Guide

**Document Type:** Master Documentation (Combined)  
**Version:** 2.0  
**Date Created:** 18 February 2026  
**Project:** College Classroom Booking System  
**Sprint:** Sprint 1 (2-week duration: Feb 18 - Mar 4, 2026)

---

## 🎯 EXECUTIVE SUMMARY

This master document combines Sprint 1 planning and technical implementation guidance into one comprehensive reference guide. It covers:

- ✅ Sprint goals, scope, and deliverables
- ✅ Complete team structure and assignments
- ✅ System architecture and technology stack
- ✅ Step-by-step implementation for all 15 tasks
- ✅ Integration points between services
- ✅ Development workflow and testing strategy
- ✅ Docker deployment and monitoring
- ✅ Troubleshooting and success criteria

**Status:** 🚀 **IN PROGRESS** (Started: 18 February 2026)

---

## 📑 TABLE OF CONTENTS

### PART 1: SPRINT PLANNING & OVERVIEW
1. [Sprint 1 Overview](#sprint-1-overview)
2. [Sprint Goal & Scope](#sprint-goal--scope)
3. [Team Structure & Assignments](#team-structure--assignments)
4. [Project Overview](#project-overview)

### PART 2: ARCHITECTURE & DESIGN
5. [System Architecture](#system-architecture)
6. [Technology Stack](#technology-stack)
7. [Database Schema](#database-schema)
8. [Integration Points](#integration-points)

### PART 3: IMPLEMENTATION GUIDE
9. [Step-by-Step Implementation](#step-by-step-implementation)
10. [Infrastructure Setup](#infrastructure-setup)
11. [Room Service Implementation](#room-service-implementation)
12. [Booking Service Implementation](#booking-service-implementation)

### PART 4: DEVELOPMENT & OPERATIONS
13. [Development Workflow](#development-workflow)
14. [Testing Strategy](#testing-strategy)
15. [Deployment & Docker](#deployment--docker)
16. [Monitoring & Observability](#monitoring--observability)

### PART 5: REFERENCE & SUPPORT
17. [Common Commands Reference](#common-commands-reference)
18. [Troubleshooting Guide](#troubleshooting-guide)
19. [Success Criteria](#success-criteria)
20. [Learning Resources](#learning-resources)

---

# PART 1: SPRINT PLANNING & OVERVIEW

## Sprint 1 Overview

### 🎯 Sprint Status
- **Status:** 🚀 IN PROGRESS
- **Start Date:** 18 February 2026
- **End Date:** 4 March 2026 (2 weeks)
- **Duration:** 2 weeks (10 business days)
- **Team Size:** 3 people (parallel workstreams)
- **Total Items:** 15 SCRUM items

### 📊 Progress Summary
- **Completed:** 1/15 items (6.7%)
  - ✅ SCRUM-23: Eureka Discovery Server
- **In Progress:** 14/14 items (0%)
- **Not Started:** 0 items

---

## Sprint Goal & Scope

### 🎯 Primary Sprint Goal

> **Implement core backend microservices for the College Classroom Booking System including Room and Booking services with database persistence, Eureka discovery, Config Server, API Gateway routing, and booking validation (availability + prevent double booking).**

### ✅ Outcome
Proper sprint planning for submission with 3 parallel workstreams moving together without blocking each other.

### 📋 Sprint 1 Scope - 15 Items

**SCRUM-23 ✅ COMPLETE**
- Eureka Discovery Server (DONE - Java 21 LTS, Docker-ready)

**Infrastructure (Person 1) - 3 Items Remaining**
- SCRUM-24: Config Server - Centralized configuration management
- SCRUM-25: API Gateway routing - Single entry point with service discovery
- SCRUM-26: Validation + error response - Shared library for error handling

**Room Service (You/Person A) - 5 Items**
- SCRUM-27: Room model - Define Room domain model with fields
- SCRUM-39: Room DB - Create database schema for rooms
- SCRUM-28: Room CRUD - Create, Read, Update, Delete operations
- SCRUM-29: Filter rooms - Advanced room filtering functionality
- SCRUM-30: Availability API - Check room availability for time slots

**Booking Service (Person 3) - 5 Items**
- SCRUM-31: Booking model - Define Booking domain model
- SCRUM-41: Booking DB - Create database schema for bookings
- SCRUM-32: Booking CRUD - Create, Read, Update, Delete operations
- SCRUM-33: Prevent double booking - Business logic for conflict prevention
- SCRUM-34: Cancel booking - Booking cancellation functionality

**Optional (If Needed) - 1 Item**
- SCRUM-38: Microservice skeletons - Setup additional services

### ❌ Out of Scope (Sprint 2+)
- ❌ Frontend/User Interface
- ❌ Authentication/Authorization
- ❌ Advanced monitoring (Prometheus, Grafana)
- ❌ API documentation/Swagger
- ❌ Performance optimization
- ❌ Kubernetes deployment

---

## Team Structure & Assignments

### 👥 3-Person Team with Parallel Workstreams

```
┌─────────────────────────────────────────────────────────────┐
│                    SPRINT 1 TEAM                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  PERSON 1: INFRASTRUCTURE LEAD                              │
│  ├─ SCRUM-23: Eureka Discovery ✅ COMPLETE                │
│  ├─ SCRUM-24: Config Server                                │
│  ├─ SCRUM-25: API Gateway Routing                          │
│  └─ SCRUM-26: Error Handling & Validation                  │
│  Total: 4 Tasks (1 complete, 3 in progress)               │
│                                                              │
│  PERSON A / YOU: ROOM SERVICE LEAD                          │
│  ├─ SCRUM-27: Room Model                                    │
│  ├─ SCRUM-39: Room Database                                │
│  ├─ SCRUM-28: Room CRUD                                    │
│  ├─ SCRUM-29: Filter Rooms                                 │
│  └─ SCRUM-30: Availability API                             │
│  Total: 5 Tasks (0 complete, 5 in progress)               │
│                                                              │
│  PERSON 3: BOOKING SERVICE LEAD                            │
│  ├─ SCRUM-31: Booking Model                                │
│  ├─ SCRUM-41: Booking Database                             │
│  ├─ SCRUM-32: Booking CRUD                                 │
│  ├─ SCRUM-33: Prevent Double Booking                       │
│  └─ SCRUM-34: Cancel Booking                               │
│  Total: 5 Tasks (0 complete, 5 in progress)               │
│                                                              │
│  OPTIONAL:                                                  │
│  ├─ SCRUM-38: Microservice Skeletons (if needed)           │
│  └─ Total: 1 Task (optional)                               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 📅 Work Schedule & Milestones

**Week 1 (Feb 18-22):**
- Infrastructure: Set up Eureka ✅, Config Server, API Gateway
- Room Service: Define models, create database schema
- Booking Service: Define models, create database schema

**Week 2 (Feb 25-Mar 4):**
- Infrastructure: Integrate services with API Gateway
- Room Service: Implement CRUD, filtering, availability API
- Booking Service: Implement CRUD, validation, cancellation

### 🚫 No Blocking Dependencies
- Each workstream can work independently
- API contracts defined upfront
- Regular sync meetings prevent blocking

### 📞 Communication Plan

| Meeting | Frequency | Duration | Purpose |
|---------|-----------|----------|---------|
| Daily Standup | Every morning | 15 min | Sync progress, identify blockers |
| Workstream Sync | 2x per week | 30 min | Coordinate between teams |
| Sprint Review | End of Sprint | 1 hour | Demo completed work |
| Sprint Retro | End of Sprint | 1 hour | Improve process for Sprint 2 |

---

## Project Overview

### 🏢 What is the College Classroom Booking System?

The College Classroom Booking System is a **microservices-based web application** that enables:
- **Search** available classrooms with specific criteria (capacity, equipment, building)
- **Book** classrooms for specific dates and times
- **Check availability** before booking
- **Cancel bookings** when plans change
- **Filter** rooms by various parameters (building, capacity, floor, equipment)

### 🏗️ Why Microservices Architecture?

Instead of one monolithic application, we build independent services:

| Service | Responsibility | Port | Team |
|---------|-----------------|------|------|
| **Eureka Discovery** | Service registry - tracks all running services | 8761 | Person 1 |
| **Config Server** | Centralized configuration management | 8888 | Person 1 |
| **API Gateway** | Single entry point, routes to services | 8080 | Person 1 |
| **Room Service** | Manages classroom data & availability | 8081 | You |
| **Booking Service** | Handles reservations & validations | 8082 | Person 3 |

### ✅ Benefits of Microservices

- ✅ **Independent Scaling** - Scale Room Service separately from Booking Service
- ✅ **Independent Deployment** - Update one service without redeploying all
- ✅ **Technology Flexibility** - Each service can use different tech (if needed)
- ✅ **Team Autonomy** - 3 people work in parallel without blocking each other
- ✅ **Failure Isolation** - One service down doesn't bring down entire system
- ✅ **Easy Testing** - Test each service independently

### 📚 Key Concepts Explained

**Microservices**: Small, independent applications that work together  
**Service Discovery**: Automatic detection of available services (Eureka handles this)  
**API Gateway**: Router that directs client requests to the right service  
**Database Persistence**: Data stored in a database (H2 for dev, PostgreSQL for production)  
**Spring Cloud**: Set of tools for building distributed systems

---

# PART 2: ARCHITECTURE & DESIGN

## System Architecture

### 🏗️ High-Level Architecture Diagram

```
┌──────────────────────────────────────────────────────────────────┐
│                    CLIENT APPLICATIONS                           │
│              (Web, Mobile, Desktop, 3rd Party)                   │
└────────────────────────────┬─────────────────────────────────────┘
                             │
                             ▼
        ┌────────────────────────────────────────┐
        │    API GATEWAY (Port 8080)              │
        │    Route /api/rooms/** to Room Service │
        │    Route /api/bookings/** to Booking   │
        └────────┬──────────────────┬────────────┘
                 │                  │
        ┌────────▼──────┐    ┌──────▼──────────┐
        │ ROOM SERVICE   │    │ BOOKING SERVICE │
        │  (Port 8081)   │    │   (Port 8082)   │
        └────────┬──────┘    └──────┬───────────┘
                 │                  │
        ┌────────▼──────┐    ┌──────▼──────────┐
        │ Room Database  │    │ Booking Database│
        │ (H2/Postgres)  │    │ (H2/Postgres)   │
        └────────────────┘    └──────────────────┘

Support Services (All Services Use):
┌──────────────────────────────────────┐
│ EUREKA DISCOVERY SERVER (8761)       │
│ Service registry - knows about all   │
│ running services, enables discovery  │
└──────────────────────────────────────┘

┌──────────────────────────────────────┐
│ CONFIG SERVER (8888)                 │
│ Distributes configuration to all     │
│ services centrally                   │
└──────────────────────────────────────┘
```

### 📊 Request Flow Example

**Scenario: User books a classroom**

```
Complete Request Flow:

1. CLIENT
   POST /api/bookings/create
   {
     "roomId": 1,
     "userId": "student123",
     "startTime": "2026-02-20T10:00:00",
     "endTime": "2026-02-20T11:00:00"
   }
   ↓
   
2. API GATEWAY (Port 8080)
   - Receives request at /api/bookings/create
   - Matches route: /api/bookings/** → BOOKING-SERVICE
   - Asks Eureka: "Where is BOOKING-SERVICE?"
   - Eureka: "It's at 192.168.1.100:8082"
   - Forwards request to Booking Service
   ↓
   
3. BOOKING SERVICE (Port 8082)
   - Receives create booking request
   - Validates input: times, roomId, userId format
   - Business Logic: "Is room 1 available from 10:00-11:00?"
   - Calls Room Service: availability check
   ↓
   
4. ROOM SERVICE (Port 8081)
   - Receives availability check request
   - Queries database for room 1
   - Checks for conflicting bookings
   - Returns: available=false (room already booked 10:00-10:30)
   ↓
   
5. BOOKING SERVICE (continuing)
   - Gets availability = false
   - Throws BookingConflictException
   - Prepares error response
   ↓
   
6. API GATEWAY
   - Receives error response from Booking Service
   - Passes to client with appropriate HTTP status
   ↓
   
7. CLIENT RECEIVES
   HTTP Status: 409 Conflict
   {
     "error": "BookingConflict",
     "message": "Room already booked for this time period",
     "timestamp": "2026-02-18T10:30:00"
   }

---

ALTERNATIVE: If room is available

At step 4 (Booking Service gets success):
   - Room Service returns: available=true
   - Booking Service creates new booking in database
   - Sets status = "CONFIRMED"
   - Returns booking confirmation:
   HTTP Status: 201 Created
   {
     "id": 42,
     "roomId": 1,
     "userId": "student123",
     "startTime": "2026-02-20T10:00:00",
     "endTime": "2026-02-20T11:00:00",
     "status": "CONFIRMED"
   }
```

---

## Technology Stack

### 🔧 Java & Spring Framework

| Component | Version | Purpose |
|-----------|---------|---------|
| **Java** | 21 LTS | Latest long-term support version |
| **Spring Boot** | 3.2.5 | Framework for building microservices |
| **Spring Cloud** | 2023.0.1 | Distributed systems tools |
| **Maven** | 3.9+ | Build tool & dependency management |

**Why these versions?**
- Java 21 LTS: Latest stable with modern features (records, pattern matching, virtual threads)
- Spring Boot 3.2.5: Latest stable with Spring Cloud support
- Maven: Industry standard for Java projects

### 📦 Key Dependencies

```xml
<!-- Service Discovery & Registration -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>

<!-- Configuration Management -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-config-server</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-config</artifactId>
</dependency>

<!-- API Gateway -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-gateway</artifactId>
</dependency>

<!-- Database & ORM -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>runtime</scope>
</dependency>

<!-- Web -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- Monitoring & Health -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>

<!-- Testing -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
```

### 🗄️ Databases

**Development:**
- H2 Database (in-memory, zero setup, perfect for local development)

**Production (Future):**
- PostgreSQL or MySQL (persistent, scalable)

### 🐳 Container Technology

- **Docker** - Container images for services
- **Docker Compose** - Orchestrate multiple containers locally
- **Base Images:**
  - Build: `eclipse-temurin:21-jdk` (full JDK for compilation)
  - Runtime: `eclipse-temurin:21-jre` (lightweight JRE)

---

## Database Schema

### 📊 Room Table

```sql
CREATE TABLE rooms (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    building VARCHAR(100) NOT NULL,
    floor INT NOT NULL,
    equipment VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE(name),
    
    -- Indexes for performance
    INDEX idx_building_floor (building, floor),
    INDEX idx_capacity (capacity),
    INDEX idx_building (building)
);
```

**Room Fields:**
| Field | Type | Purpose |
|-------|------|---------|
| id | BIGINT | Unique identifier |
| name | VARCHAR(255) | Room name (e.g., "A101") |
| capacity | INT | Number of seats |
| building | VARCHAR(100) | Building location (e.g., "Building A") |
| floor | INT | Floor number (1, 2, 3, etc.) |
| equipment | VARCHAR(500) | Available equipment (e.g., "Projector, Whiteboard") |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

### 📊 Booking Table

```sql
CREATE TABLE bookings (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_id BIGINT NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'CONFIRMED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_times CHECK (start_time < end_time),
    CONSTRAINT fk_room FOREIGN KEY (room_id) REFERENCES rooms(id),
    
    -- Indexes for performance
    INDEX idx_room_id (room_id),
    INDEX idx_user_id (user_id),
    INDEX idx_start_time (start_time),
    UNIQUE INDEX idx_room_time ON bookings(room_id, start_time, end_time, status)
        WHERE status = 'CONFIRMED'
);
```

**Booking Fields:**
| Field | Type | Purpose |
|-------|------|---------|
| id | BIGINT | Unique identifier |
| room_id | BIGINT | Reference to room being booked |
| user_id | VARCHAR(100) | User making the booking |
| start_time | TIMESTAMP | Booking start time |
| end_time | TIMESTAMP | Booking end time |
| status | VARCHAR(20) | Status (CONFIRMED, CANCELLED, PENDING) |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

---

## Integration Points

### 🔗 How Services Communicate

#### Service-to-Service Communication

```java
// Room Service calls Booking Service
@Autowired
private RestTemplate restTemplate;

public RoomAvailability checkAvailability(Long roomId, 
                                         LocalDateTime startTime,
                                         LocalDateTime endTime) {
    // Ask Eureka where Booking Service is
    ServiceInstance instance = discoveryClient
        .getInstances("BOOKING-SERVICE").get(0);
    
    String url = instance.getUri() + "/api/bookings/check-availability";
    
    // Make REST call
    AvailabilityRequest request = new AvailabilityRequest(
        roomId, startTime, endTime);
    AvailabilityResponse response = restTemplate.postForObject(
        url, request, AvailabilityResponse.class);
    
    return new RoomAvailability(roomId, startTime, endTime, 
        response.isAvailable());
}
```

#### API Gateway Routing

```yaml
# In API Gateway configuration
spring:
  cloud:
    gateway:
      routes:
        # Route all /api/rooms/** to Room Service
        - id: room-service
          uri: lb://ROOM-SERVICE
          predicates:
            - Path=/api/rooms/**
        
        # Route all /api/bookings/** to Booking Service
        - id: booking-service
          uri: lb://BOOKING-SERVICE
          predicates:
            - Path=/api/bookings/**
```

#### Config Server Distribution

```java
// Each microservice reads config from Config Server
// In bootstrap.properties:
spring.cloud.config.uri=http://localhost:8888
spring.cloud.config.name=room-service

// Gets configuration from Git/filesystem:
// room-service.properties
//   database.url=jdbc:h2:mem:roomdb
//   server.port=8081
//   eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
```

### 📊 Data Flow: Complete Booking Workflow

```
Step 1: Check Availability
Client → GET /api/rooms/1/availability?startTime=...&endTime=...
  → API Gateway → Room Service
  → Room Service queries database
  → Returns: available=true/false

Step 2: Create Booking
Client → POST /api/bookings/create with room details
  → API Gateway → Booking Service
  → Booking Service checks availability (calls Room Service)
  → If available: Create booking record in database
  → Returns: Booking confirmation or error

Step 3: Cancel Booking
Client → PATCH /api/bookings/5/cancel
  → API Gateway → Booking Service
  → Booking Service updates status to CANCELLED
  → Returns: Confirmation

All requests flow through API Gateway - clients never call services directly!
```

---

# PART 3: IMPLEMENTATION GUIDE

## Step-by-Step Implementation

### 📋 Implementation Checklist

This section provides detailed implementation instructions for all 15 SCRUM items.

---

## Infrastructure Setup

### SCRUM-23: Eureka Discovery Server ✅ COMPLETE

**Status:** ✅ COMPLETE (Java 21 LTS, fully tested, Docker-ready)

**What it does:**
- Keeps registry of all running microservices
- Allows services to discover and communicate with each other
- Provides Eureka Dashboard at http://localhost:8761

**Key files:**
```
services/discovery-server/
├── pom.xml (dependencies, Java 21 config)
├── src/main/java/EurekaServerApplication.java (main class)
├── src/main/resources/application.properties (config)
├── src/test/java/EurekaServerApplicationTests.java (tests)
├── Dockerfile (containerization)
└── README.md (documentation)
```

**Verification:**
```bash
# Start service
cd services/discovery-server
./mvnw spring-boot:run

# Check running
curl http://localhost:8761/
# Should return Eureka dashboard

# Check health
curl http://localhost:8761/actuator/health
# Should return: {"status":"UP"}
```

**Docker:**
```bash
docker build -t eureka-server:1.0 .
docker run -p 8761:8761 eureka-server:1.0
```

---

### SCRUM-24: Config Server

**What it does:**
- Centralized configuration management for all services
- Services read config (database URL, ports, properties) from here
- Allows changing config without redeploying services

**Implementation steps:**

1. **Create project structure**
   ```bash
   mkdir -p services/config-server/src/main/{java,resources}
   mkdir -p services/config-server/src/test/java
   ```

2. **Create pom.xml**
   ```xml
   <parent>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-parent</artifactId>
       <version>3.2.5</version>
   </parent>
   <properties>
       <java.version>21</java.version>
       <spring-cloud.version>2023.0.1</spring-cloud.version>
   </properties>
   <dependencies>
       <dependency>
           <groupId>org.springframework.cloud</groupId>
           <artifactId>spring-cloud-config-server</artifactId>
       </dependency>
   </dependencies>
   ```

3. **Create main class**
   ```java
   @EnableConfigServer
   @SpringBootApplication
   public class ConfigServerApplication {
       public static void main(String[] args) {
           SpringApplication.run(ConfigServerApplication.class, args);
       }
   }
   ```

4. **Create application.properties**
   ```properties
   spring.application.name=config-server
   server.port=8888
   spring.cloud.config.server.git.uri=file://./config-repo
   # or use a real git repository
   ```

5. **Create config files for services**
   ```
   config-repo/
   ├── room-service.properties
   ├── booking-service.properties
   ├── api-gateway.properties
   └── discovery-server.properties
   ```

6. **Test**
   ```bash
   curl http://localhost:8888/room-service/default
   # Should return room-service configuration
   ```

---

### SCRUM-25: API Gateway Routing

**What it does:**
- Single entry point for all client requests
- Routes requests to appropriate microservice based on path
- Handles cross-cutting concerns (logging, error handling)

**Implementation steps:**

1. **Create project structure**
   ```bash
   mkdir -p services/api-gateway/src/main/{java,resources}
   ```

2. **Create pom.xml with Spring Cloud Gateway**
   ```xml
   <dependency>
       <groupId>org.springframework.cloud</groupId>
       <artifactId>spring-cloud-starter-gateway</artifactId>
   </dependency>
   ```

3. **Create main class**
   ```java
   @EnableEurekaClient
   @SpringBootApplication
   public class ApiGatewayApplication {
       public static void main(String[] args) {
           SpringApplication.run(ApiGatewayApplication.class, args);
       }
   }
   ```

4. **Create application.properties**
   ```properties
   spring.application.name=api-gateway
   server.port=8080
   
   # Eureka discovery
   eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
   
   # Gateway routes
   spring.cloud.gateway.routes[0].id=room-service
   spring.cloud.gateway.routes[0].uri=lb://ROOM-SERVICE
   spring.cloud.gateway.routes[0].predicates[0]=Path=/api/rooms/**
   
   spring.cloud.gateway.routes[1].id=booking-service
   spring.cloud.gateway.routes[1].uri=lb://BOOKING-SERVICE
   spring.cloud.gateway.routes[1].predicates[0]=Path=/api/bookings/**
   ```

5. **Test routing**
   ```bash
   # Test gateway running
   curl http://localhost:8080/actuator/health
   
   # Test routing (when services are running)
   curl http://localhost:8080/api/rooms/
   # Should route to ROOM-SERVICE:8081/api/rooms/
   ```

---

### SCRUM-26: Validation + Error Response

**What it does:**
- Shared library with common error responses
- Validation rules used across services
- Consistent error format for all services

**Implementation steps:**

1. **Create shared library project**
   ```bash
   mkdir -p shared/validation-library/src/main/{java,resources}
   ```

2. **Create common response classes**
   ```java
   @Data
   @AllArgsConstructor
   @NoArgsConstructor
   public class ApiResponse<T> {
       private int status;
       private String message;
       private T data;
       private LocalDateTime timestamp;
   }
   
   @Data
   @AllArgsConstructor
   public class ErrorResponse {
       private String error;
       private String message;
       private int statusCode;
       private LocalDateTime timestamp;
   }
   ```

3. **Create custom exceptions**
   ```java
   public class RoomNotFoundException extends RuntimeException { ... }
   public class BookingConflictException extends RuntimeException { ... }
   public class InvalidBookingException extends RuntimeException { ... }
   public class InvalidRoomException extends RuntimeException { ... }
   ```

4. **Create validation annotations**
   ```java
   @Target(ElementType.FIELD)
   @Retention(RetentionPolicy.RUNTIME)
   @Constraint(validatedBy = CapacityValidator.class)
   public @interface ValidCapacity {
       String message() default "Capacity must be positive";
       Class<?>[] groups() default {};
       Class<? extends Payload>[] payload() default {};
   }
   ```

5. **Create global exception handler**
   ```java
   @RestControllerAdvice
   public class GlobalExceptionHandler {
       
       @ExceptionHandler(RoomNotFoundException.class)
       public ResponseEntity<ErrorResponse> handleRoomNotFound(
           RoomNotFoundException ex) {
           return ResponseEntity.status(404)
               .body(new ErrorResponse("RoomNotFound", ex.getMessage(), 404));
       }
       
       @ExceptionHandler(BookingConflictException.class)
       public ResponseEntity<ErrorResponse> handleBookingConflict(
           BookingConflictException ex) {
           return ResponseEntity.status(409)
               .body(new ErrorResponse("BookingConflict", ex.getMessage(), 409));
       }
       
       // ... more exception handlers
   }
   ```

6. **Package as JAR**
   ```bash
   mvn package
   mvn install:install-file -Dfile=target/validation-library-1.0.jar ...
   ```

7. **Use in other services**
   ```xml
   <!-- In Room Service and Booking Service pom.xml -->
   <dependency>
       <groupId>com.example</groupId>
       <artifactId>validation-library</artifactId>
       <version>1.0</version>
   </dependency>
   ```

---

## Room Service Implementation

### SCRUM-27: Room Data Model

**What it does:**
- Defines what a "Room" is in the system
- JPA entity mapped to database table
- Validations on fields

**Implementation:**

1. **Create Room entity class**
   ```java
   @Entity
   @Table(name = "rooms")
   @Data
   @AllArgsConstructor
   @NoArgsConstructor
   public class Room {
       @Id
       @GeneratedValue(strategy = GenerationType.IDENTITY)
       private Long id;
       
       @Column(nullable = false)
       @NotBlank(message = "Room name is required")
       private String name;
       
       @Column(nullable = false)
       @Min(value = 1, message = "Capacity must be at least 1")
       @Max(value = 1000, message = "Capacity cannot exceed 1000")
       private Integer capacity;
       
       @Column(nullable = false)
       @NotBlank(message = "Building is required")
       private String building;
       
       @Column(nullable = false)
       @Min(value = 0, message = "Floor must be 0 or higher")
       private Integer floor;
       
       private String equipment; // e.g., "Projector, Whiteboard"
       
       @CreationTimestamp
       @Column(updatable = false)
       private LocalDateTime createdAt;
       
       @UpdateTimestamp
       private LocalDateTime updatedAt;
   }
   ```

2. **Create DTOs**
   ```java
   // For API requests
   @Data
   public class CreateRoomRequest {
       @NotBlank
       private String name;
       @Min(1)
       private Integer capacity;
       @NotBlank
       private String building;
       @Min(0)
       private Integer floor;
       private String equipment;
   }
   
   // For API responses
   @Data
   public class RoomDTO {
       private Long id;
       private String name;
       private Integer capacity;
       private String building;
       private Integer floor;
       private String equipment;
       private LocalDateTime createdAt;
   }
   ```

3. **Create repository**
   ```java
   public interface RoomRepository extends JpaRepository<Room, Long> {
       List<Room> findByCapacityGreaterThanEqual(Integer capacity);
       List<Room> findByBuilding(String building);
       List<Room> findByBuildingAndFloor(String building, Integer floor);
       List<Room> findByEquipmentContaining(String equipment);
   }
   ```

---

### SCRUM-39: Room Database Schema

**What it does:**
- Creates database tables for Room data
- Flyway manages database migrations
- Indexes for performance

**Implementation:**

1. **Create migration file**
   ```
   src/main/resources/db/migration/V1__create_rooms_table.sql
   ```

2. **Migration content**
   ```sql
   CREATE TABLE rooms (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       name VARCHAR(255) NOT NULL UNIQUE,
       capacity INT NOT NULL,
       building VARCHAR(100) NOT NULL,
       floor INT NOT NULL,
       equipment VARCHAR(500),
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
       
       INDEX idx_building_floor (building, floor),
       INDEX idx_capacity (capacity),
       INDEX idx_building (building)
   );
   ```

3. **Add Flyway to pom.xml**
   ```xml
   <dependency>
       <groupId>org.flywaydb</groupId>
       <artifactId>flyway-core</artifactId>
   </dependency>
   ```

4. **Configure in application.properties**
   ```properties
   spring.flyway.enabled=true
   spring.jpa.hibernate.ddl-auto=validate
   ```

5. **Insert test data** (optional)
   ```
   src/main/resources/db/migration/V2__insert_test_data.sql
   ```

   ```sql
   INSERT INTO rooms (name, capacity, building, floor, equipment) VALUES
   ('A101', 30, 'Building A', 1, 'Projector, Whiteboard'),
   ('A102', 20, 'Building A', 1, 'Projector'),
   ('A201', 25, 'Building A', 2, 'Interactive Board'),
   ('B101', 50, 'Building B', 1, 'Projector, Audio System'),
   ('B201', 40, 'Building B', 2, 'Whiteboard');
   ```

---

### SCRUM-28: Room CRUD Operations

**What it does:**
- Create, Read, Update, Delete API endpoints for rooms
- RESTful API following HTTP standards
- Input validation and error handling

**Implementation:**

1. **Create Room Service class**
   ```java
   @Service
   public class RoomService {
       @Autowired
       private RoomRepository roomRepository;
       
       public RoomDTO createRoom(CreateRoomRequest request) {
           Room room = new Room();
           room.setName(request.getName());
           room.setCapacity(request.getCapacity());
           room.setBuilding(request.getBuilding());
           room.setFloor(request.getFloor());
           room.setEquipment(request.getEquipment());
           
           Room saved = roomRepository.save(room);
           return convertToDTO(saved);
       }
       
       public RoomDTO getRoom(Long id) {
           return roomRepository.findById(id)
               .map(this::convertToDTO)
               .orElseThrow(() -> new RoomNotFoundException(
                   "Room not found with id: " + id));
       }
       
       public List<RoomDTO> getAllRooms() {
           return roomRepository.findAll().stream()
               .map(this::convertToDTO)
               .collect(Collectors.toList());
       }
       
       public RoomDTO updateRoom(Long id, UpdateRoomRequest request) {
           Room room = roomRepository.findById(id)
               .orElseThrow(() -> new RoomNotFoundException(
                   "Room not found with id: " + id));
           
           if (request.getCapacity() != null) {
               room.setCapacity(request.getCapacity());
           }
           if (request.getEquipment() != null) {
               room.setEquipment(request.getEquipment());
           }
           
           Room updated = roomRepository.save(room);
           return convertToDTO(updated);
       }
       
       public void deleteRoom(Long id) {
           if (!roomRepository.existsById(id)) {
               throw new RoomNotFoundException(
                   "Room not found with id: " + id);
           }
           roomRepository.deleteById(id);
       }
       
       private RoomDTO convertToDTO(Room room) {
           RoomDTO dto = new RoomDTO();
           dto.setId(room.getId());
           dto.setName(room.getName());
           dto.setCapacity(room.getCapacity());
           dto.setBuilding(room.getBuilding());
           dto.setFloor(room.getFloor());
           dto.setEquipment(room.getEquipment());
           dto.setCreatedAt(room.getCreatedAt());
           return dto;
       }
   }
   ```

2. **Create Room Controller**
   ```java
   @RestController
   @RequestMapping("/api/rooms")
   public class RoomController {
       @Autowired
       private RoomService roomService;
       
       @PostMapping
       public ResponseEntity<RoomDTO> createRoom(
           @Valid @RequestBody CreateRoomRequest request) {
           RoomDTO created = roomService.createRoom(request);
           return ResponseEntity.status(HttpStatus.CREATED).body(created);
       }
       
       @GetMapping("/{id}")
       public ResponseEntity<RoomDTO> getRoom(@PathVariable Long id) {
           return ResponseEntity.ok(roomService.getRoom(id));
       }
       
       @GetMapping
       public ResponseEntity<List<RoomDTO>> getAllRooms() {
           return ResponseEntity.ok(roomService.getAllRooms());
       }
       
       @PutMapping("/{id}")
       public ResponseEntity<RoomDTO> updateRoom(
           @PathVariable Long id,
           @Valid @RequestBody UpdateRoomRequest request) {
           return ResponseEntity.ok(roomService.updateRoom(id, request));
       }
       
       @DeleteMapping("/{id}")
       public ResponseEntity<Void> deleteRoom(@PathVariable Long id) {
           roomService.deleteRoom(id);
           return ResponseEntity.noContent().build();
       }
   }
   ```

3. **Test CRUD operations**
   ```bash
   # Create
   curl -X POST http://localhost:8081/api/rooms \
     -H "Content-Type: application/json" \
     -d '{"name":"C301","capacity":25,"building":"Building C","floor":3}'
   
   # Read one
   curl http://localhost:8081/api/rooms/1
   
   # Read all
   curl http://localhost:8081/api/rooms
   
   # Update
   curl -X PUT http://localhost:8081/api/rooms/1 \
     -H "Content-Type: application/json" \
     -d '{"capacity":35}'
   
   # Delete
   curl -X DELETE http://localhost:8081/api/rooms/1
   ```

---

### SCRUM-29: Filter Rooms

**What it does:**
- Search and filter rooms by various criteria
- Multiple filter options: capacity, building, floor, equipment
- Flexible query parameters

**Implementation:**

1. **Extend Room Repository**
   ```java
   public interface RoomRepository extends JpaRepository<Room, Long> {
       // Find by single criteria
       List<Room> findByCapacityGreaterThanEqual(Integer capacity);
       List<Room> findByBuilding(String building);
       List<Room> findByBuildingAndFloor(String building, Integer floor);
       List<Room> findByEquipmentContaining(String equipment);
       
       // Custom query for complex filters
       @Query("SELECT r FROM Room r WHERE " +
              "(:minCapacity IS NULL OR r.capacity >= :minCapacity) AND " +
              "(:building IS NULL OR r.building = :building) AND " +
              "(:floor IS NULL OR r.floor = :floor) AND " +
              "(:equipment IS NULL OR r.equipment LIKE %:equipment%)")
       List<Room> findByFilters(
           @Param("minCapacity") Integer minCapacity,
           @Param("building") String building,
           @Param("floor") Integer floor,
           @Param("equipment") String equipment);
   }
   ```

2. **Add filter method to Service**
   ```java
   public List<RoomDTO> searchRooms(Integer minCapacity, 
                                     String building, 
                                     Integer floor,
                                     String equipment) {
       return roomRepository.findByFilters(minCapacity, building, floor, equipment)
           .stream()
           .map(this::convertToDTO)
           .collect(Collectors.toList());
   }
   ```

3. **Add search endpoint to Controller**
   ```java
   @GetMapping("/search")
   public ResponseEntity<List<RoomDTO>> searchRooms(
       @RequestParam(required = false) Integer minCapacity,
       @RequestParam(required = false) String building,
       @RequestParam(required = false) Integer floor,
       @RequestParam(required = false) String equipment) {
       List<RoomDTO> results = roomService.searchRooms(
           minCapacity, building, floor, equipment);
       return ResponseEntity.ok(results);
   }
   ```

4. **Test filtering**
   ```bash
   # Find rooms with min capacity 30
   curl "http://localhost:8081/api/rooms/search?minCapacity=30"
   
   # Find rooms in Building A
   curl "http://localhost:8081/api/rooms/search?building=Building%20A"
   
   # Find rooms with specific floor
   curl "http://localhost:8081/api/rooms/search?floor=2"
   
   # Combine filters
   curl "http://localhost:8081/api/rooms/search?minCapacity=30&building=Building%20A&floor=2"
   ```

---

### SCRUM-30: Availability API

**What it does:**
- Check if a specific room is available for a specific time period
- Queries Booking Service for conflicts
- Returns availability status

**Implementation:**

1. **Create Availability classes**
   ```java
   @Data
   public class AvailabilityRequest {
       private Long roomId;
       private LocalDateTime startTime;
       private LocalDateTime endTime;
   }
   
   @Data
   public class AvailabilityResponse {
       private Long roomId;
       private LocalDateTime startTime;
       private LocalDateTime endTime;
       private boolean available;
       private String reason;
   }
   ```

2. **Add availability check to Service**
   ```java
   @Service
   public class RoomService {
       @Autowired
       private RestTemplate restTemplate;
       
       @Autowired
       private DiscoveryClient discoveryClient;
       
       public AvailabilityResponse checkAvailability(
           Long roomId, 
           LocalDateTime startTime, 
           LocalDateTime endTime) {
           
           // Verify room exists
           Room room = roomRepository.findById(roomId)
               .orElseThrow(() -> new RoomNotFoundException(
                   "Room not found: " + roomId));
           
           // Validate times
           if (startTime.isAfter(endTime)) {
               return new AvailabilityResponse(roomId, startTime, endTime,
                   false, "Start time must be before end time");
           }
           
           if (startTime.isBefore(LocalDateTime.now())) {
               return new AvailabilityResponse(roomId, startTime, endTime,
                   false, "Cannot book rooms in the past");
           }
           
           // Check with Booking Service
           try {
               ServiceInstance bookingService = discoveryClient
                   .getInstances("BOOKING-SERVICE").get(0);
               
               String url = bookingService.getUri() + 
                   "/api/bookings/check-availability";
               
               AvailabilityRequest request = new AvailabilityRequest();
               request.setRoomId(roomId);
               request.setStartTime(startTime);
               request.setEndTime(endTime);
               
               AvailabilityResponse response = restTemplate.postForObject(
                   url, request, AvailabilityResponse.class);
               
               return response != null ? response :
                   new AvailabilityResponse(roomId, startTime, endTime,
                       true, "Available");
               
           } catch (Exception e) {
               // If booking service unavailable, assume available
               return new AvailabilityResponse(roomId, startTime, endTime,
                   true, "Available (booking service unreachable)");
           }
       }
   }
   ```

3. **Add endpoint to Controller**
   ```java
   @GetMapping("/{id}/availability")
   public ResponseEntity<AvailabilityResponse> checkAvailability(
       @PathVariable Long id,
       @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
       LocalDateTime startTime,
       @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
       LocalDateTime endTime) {
       
       AvailabilityResponse response = roomService.checkAvailability(
           id, startTime, endTime);
       return ResponseEntity.ok(response);
   }
   ```

4. **Test availability**
   ```bash
   # Check if room 1 is available Feb 20, 10am-11am
   curl "http://localhost:8081/api/rooms/1/availability?" \
        "startTime=2026-02-20T10:00:00&endTime=2026-02-20T11:00:00"
   
   # Response:
   # {
   #   "roomId": 1,
   #   "startTime": "2026-02-20T10:00:00",
   #   "endTime": "2026-02-20T11:00:00",
   #   "available": true,
   #   "reason": "Available"
   # }
   ```

---

## Booking Service Implementation

### SCRUM-31: Booking Data Model

**Implementation:**

1. **Create Booking entity**
   ```java
   @Entity
   @Table(name = "bookings")
   @Data
   @AllArgsConstructor
   @NoArgsConstructor
   public class Booking {
       @Id
       @GeneratedValue(strategy = GenerationType.IDENTITY)
       private Long id;
       
       @Column(nullable = false)
       @Min(1)
       private Long roomId;
       
       @Column(nullable = false)
       @NotBlank(message = "User ID is required")
       private String userId;
       
       @Column(nullable = false)
       private LocalDateTime startTime;
       
       @Column(nullable = false)
       private LocalDateTime endTime;
       
       @Enumerated(EnumType.STRING)
       @Column(nullable = false)
       private BookingStatus status;
       
       @CreationTimestamp
       @Column(updatable = false)
       private LocalDateTime createdAt;
       
       @UpdateTimestamp
       private LocalDateTime updatedAt;
       
       @PrePersist
       protected void onCreate() {
           if (status == null) {
               status = BookingStatus.CONFIRMED;
           }
       }
   }
   ```

2. **Create Booking status enum**
   ```java
   public enum BookingStatus {
       PENDING,
       CONFIRMED,
       CANCELLED
   }
   ```

3. **Create DTOs**
   ```java
   @Data
   public class CreateBookingRequest {
       @NotNull
       @Min(1)
       private Long roomId;
       @NotBlank
       private String userId;
       @NotNull
       private LocalDateTime startTime;
       @NotNull
       private LocalDateTime endTime;
   }
   
   @Data
   public class BookingDTO {
       private Long id;
       private Long roomId;
       private String userId;
       private LocalDateTime startTime;
       private LocalDateTime endTime;
       private BookingStatus status;
       private LocalDateTime createdAt;
   }
   ```

---

### SCRUM-41: Booking Database Schema

**Implementation:**

1. **Create migration**
   ```
   src/main/resources/db/migration/V1__create_bookings_table.sql
   ```

2. **Migration SQL**
   ```sql
   CREATE TABLE bookings (
       id BIGINT PRIMARY KEY AUTO_INCREMENT,
       room_id BIGINT NOT NULL,
       user_id VARCHAR(100) NOT NULL,
       start_time TIMESTAMP NOT NULL,
       end_time TIMESTAMP NOT NULL,
       status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
       
       CONSTRAINT chk_times CHECK (start_time < end_time),
       
       INDEX idx_room_id (room_id),
       INDEX idx_user_id (user_id),
       INDEX idx_start_time (start_time),
       INDEX idx_status (status),
       UNIQUE INDEX idx_room_time ON bookings(room_id, start_time, end_time, status)
           WHERE status = 'CONFIRMED'
   );
   ```

---

### SCRUM-32: Booking CRUD Operations

**Similar structure to Room CRUD:**

1. **Create BookingService**
2. **Create BookingController** with endpoints:
   - POST /api/bookings - Create booking
   - GET /api/bookings/{id} - Get booking
   - GET /api/bookings - List bookings
   - PUT /api/bookings/{id} - Update booking
   - DELETE /api/bookings/{id} - Delete booking

3. **Test endpoints**
   ```bash
   # Create
   curl -X POST http://localhost:8082/api/bookings \
     -H "Content-Type: application/json" \
     -d '{"roomId":1,"userId":"student1","startTime":"2026-02-20T10:00:00","endTime":"2026-02-20T11:00:00"}'
   ```

---

### SCRUM-33: Prevent Double Booking

**Critical business logic:**

```java
@Service
public class BookingService {
    
    private void validateAvailability(Long roomId, 
                                      LocalDateTime startTime,
                                      LocalDateTime endTime) {
        // Find all confirmed bookings that overlap
        List<Booking> conflicts = bookingRepository.findConflictingBookings(
            roomId, startTime, endTime);
        
        if (!conflicts.isEmpty()) {
            throw new BookingConflictException(
                "Room " + roomId + " is already booked for this time period");
        }
    }
    
    public BookingDTO createBooking(CreateBookingRequest request) {
        // Validate time logic
        if (request.getStartTime().isAfter(request.getEndTime())) {
            throw new InvalidBookingException(
                "Start time must be before end time");
        }
        
        if (request.getStartTime().isBefore(LocalDateTime.now())) {
            throw new InvalidBookingException(
                "Cannot book rooms in the past");
        }
        
        // Check availability
        validateAvailability(request.getRoomId(), 
                            request.getStartTime(), 
                            request.getEndTime());
        
        // Create booking
        Booking booking = new Booking();
        booking.setRoomId(request.getRoomId());
        booking.setUserId(request.getUserId());
        booking.setStartTime(request.getStartTime());
        booking.setEndTime(request.getEndTime());
        booking.setStatus(BookingStatus.CONFIRMED);
        
        Booking saved = bookingRepository.save(booking);
        return convertToDTO(saved);
    }
}
```

**Repository query:**
```java
@Query("SELECT b FROM Booking b WHERE b.roomId = :roomId " +
       "AND b.status = 'CONFIRMED' " +
       "AND b.startTime < :endTime " +
       "AND b.endTime > :startTime")
List<Booking> findConflictingBookings(
    @Param("roomId") Long roomId,
    @Param("startTime") LocalDateTime startTime,
    @Param("endTime") LocalDateTime endTime);
```

---

### SCRUM-34: Cancel Booking

**Implementation:**

```java
@PatchMapping("/{id}/cancel")
public ResponseEntity<BookingDTO> cancelBooking(@PathVariable Long id) {
    Booking booking = bookingRepository.findById(id)
        .orElseThrow(() -> new BookingNotFoundException(
            "Booking not found: " + id));
    
    // Check if already cancelled
    if (booking.getStatus() == BookingStatus.CANCELLED) {
        throw new InvalidBookingException(
            "Booking is already cancelled");
    }
    
    // Prevent canceling past bookings
    if (booking.getStartTime().isBefore(LocalDateTime.now())) {
        throw new InvalidBookingException(
            "Cannot cancel past bookings");
    }
    
    // Cancel booking
    booking.setStatus(BookingStatus.CANCELLED);
    Booking updated = bookingRepository.save(booking);
    
    return ResponseEntity.ok(convertToDTO(updated));
}
```

**Test:**
```bash
curl -X PATCH http://localhost:8082/api/bookings/5/cancel
```

---

# PART 4: DEVELOPMENT & OPERATIONS

## Development Workflow

### 📝 Git Workflow

**Branch naming:**
```
feature/SCRUM-27-room-model
bugfix/SCRUM-33-double-booking
hotfix/database-timeout
```

**Commit message:**
```
SCRUM-27: Implement Room model entity

- Created Room.java with JPA annotations
- Added validation for capacity and floor
- Created RoomDTO for API responses
- Added database schema migration
```

**Pull Request Checklist:**
- [ ] Code follows style guide
- [ ] All tests pass locally
- [ ] Tests added for new features
- [ ] No debug code
- [ ] Jira ticket linked
- [ ] Code review approval
- [ ] Ready to merge

---

## Testing Strategy

### 🧪 Unit Tests

```java
@SpringBootTest
class RoomServiceTest {
    
    @InjectMocks
    private RoomService roomService;
    
    @Mock
    private RoomRepository roomRepository;
    
    @Test
    void testCreateRoom_Success() {
        CreateRoomRequest request = new CreateRoomRequest(
            "A101", 30, "Building A", 1, "Projector");
        Room room = new Room(1L, "A101", 30, "Building A", 1, "Projector", NOW, NOW);
        
        when(roomRepository.save(any())).thenReturn(room);
        
        RoomDTO result = roomService.createRoom(request);
        
        assertEquals("A101", result.getName());
        assertEquals(30, result.getCapacity());
        verify(roomRepository, times(1)).save(any());
    }
}
```

### 🧪 Integration Tests

```java
@SpringBootTest
@AutoConfigureMockMvc
class RoomControllerIntegrationTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    void testCreateRoom_API() throws Exception {
        mockMvc.perform(post("/api/rooms")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"name\":\"A101\",\"capacity\":30," +
                     "\"building\":\"Building A\",\"floor\":1}"))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.name").value("A101"));
    }
}
```

**Run tests:**
```bash
./mvnw test
./mvnw test -Dtest=RoomServiceTest
./mvnw test jacoco:report
```

---

## Deployment & Docker

### 🐳 Docker Build

```dockerfile
# Dockerfile example
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /build
COPY . .
RUN chmod +x ./mvnw && ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=builder /build/target/room-service-*.jar room-service.jar

EXPOSE 8081
ENTRYPOINT ["java", "-jar", "room-service.jar"]
```

**Build image:**
```bash
docker build -t room-service:1.0 .
docker run -p 8081:8081 room-service:1.0
```

### 🐳 Docker Compose

```yaml
version: '3.8'

services:
  eureka:
    image: eureka-server:1.0
    ports:
      - "8761:8761"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8761/"]
      interval: 30s
      timeout: 3s
      retries: 3

  config-server:
    image: config-server:1.0
    ports:
      - "8888:8888"
    depends_on:
      eureka:
        condition: service_healthy

  api-gateway:
    image: api-gateway:1.0
    ports:
      - "8080:8080"
    depends_on:
      eureka:
        condition: service_healthy

  room-service:
    image: room-service:1.0
    ports:
      - "8081:8081"
    depends_on:
      eureka:
        condition: service_healthy

  booking-service:
    image: booking-service:1.0
    ports:
      - "8082:8082"
    depends_on:
      eureka:
        condition: service_healthy

networks:
  default:
    name: student-booking-network
```

**Run:**
```bash
docker-compose up -d
docker-compose logs -f
docker-compose down
```

---

## Monitoring & Observability

### 🏥 Health Checks

```bash
# Service health
curl http://localhost:8081/actuator/health

# Response:
{
  "status": "UP",
  "components": {
    "db": {"status": "UP"},
    "livenessState": {"status": "UP"},
    "readinessState": {"status": "UP"}
  }
}
```

### 📊 Metrics

```bash
# List metrics
curl http://localhost:8081/actuator/metrics

# Get specific metric
curl http://localhost:8081/actuator/metrics/jvm.memory.used
```

---

# PART 5: REFERENCE & SUPPORT

## Common Commands Reference

### Maven Commands

```bash
./mvnw clean              # Clean build
./mvnw compile            # Compile
./mvnw test               # Run tests
./mvnw package            # Package JAR
./mvnw install            # Install locally
./mvnw spring-boot:run    # Run app
./mvnw package -DskipTests # Package without tests
```

### Git Commands

```bash
git clone <url>                        # Clone repo
git checkout -b feature/SCRUM-27       # Create branch
git add .                              # Stage changes
git commit -m "SCRUM-27: message"      # Commit
git push origin feature/SCRUM-27       # Push
git pull origin main                   # Pull
git log --oneline                      # History
git diff                               # Differences
```

### Docker Commands

```bash
docker build -t service:1.0 .          # Build image
docker run -p 8081:8081 service:1.0    # Run container
docker ps                              # List running
docker logs <container-id>             # View logs
docker stop <container-id>             # Stop
docker compose up -d                   # Start stack
docker compose down                    # Stop stack
docker compose logs -f service-name    # Follow logs
```

### cURL Commands

```bash
# GET
curl http://localhost:8081/api/rooms/1

# POST
curl -X POST http://localhost:8081/api/rooms \
  -H "Content-Type: application/json" \
  -d '{"name":"A101","capacity":30,"building":"Building A","floor":1}'

# PUT
curl -X PUT http://localhost:8081/api/rooms/1 \
  -H "Content-Type: application/json" \
  -d '{"capacity":35}'

# DELETE
curl -X DELETE http://localhost:8081/api/rooms/1

# With query params
curl "http://localhost:8081/api/rooms/search?minCapacity=30&building=Building%20A"

# Pretty print JSON
curl http://localhost:8081/api/rooms | jq .
```

---

## Troubleshooting Guide

### ❌ "Connection refused" Error

**Cause:** Service not running or wrong port

**Solution:**
```bash
# Check if running
docker ps
ps aux | grep java

# Check Eureka registration
curl http://localhost:8761/eureka/apps

# Check service logs
docker logs <service-id>
./mvnw spring-boot:run

# Verify port and address
# application.properties: server.port=8081
```

### ❌ "Database table not found"

**Cause:** Flyway migrations didn't run

**Solution:**
```bash
# Verify migration files exist
ls src/main/resources/db/migration/

# Check Flyway enabled
# application.properties:
# spring.flyway.enabled=true
# spring.jpa.hibernate.ddl-auto=validate

# Check logs for Flyway output
```

### ❌ "Port already in use"

**Solution:**
```bash
# Find process
lsof -i :8081
netstat -ano | findstr :8081

# Kill process
kill <pid>

# Or change port
# application.properties: server.port=8083
```

### ❌ "Service not registering with Eureka"

**Check:**
1. Dependency: `spring-cloud-starter-netflix-eureka-client`
2. Annotation: `@EnableEurekaClient` on main class
3. Config: `eureka.client.service-url.defaultZone=http://localhost:8761/eureka/`
4. Name: `spring.application.name=room-service`

---

## Success Criteria

### ✅ Sprint 1 Definition of Done

**For each task:**
- [ ] Feature implemented per requirements
- [ ] Unit tests written and passing
- [ ] Integration tests passing
- [ ] Manual testing completed
- [ ] Code reviewed and approved
- [ ] Merged to main branch
- [ ] Works with other services
- [ ] Registered with Eureka
- [ ] Accessible through API Gateway

### ✅ Sprint 1 Success Metrics

By end of Sprint 1, all of these should be true:

**Infrastructure:**
- ✅ Eureka server running & registering services
- ✅ Config server distributing config
- ✅ API Gateway routing requests correctly
- ✅ Error handling library available

**Room Service:**
- ✅ Can CRUD rooms
- ✅ Can filter rooms
- ✅ Can check availability
- ✅ Integrated with Booking Service

**Booking Service:**
- ✅ Can CRUD bookings
- ✅ Prevents double bookings
- ✅ Can cancel bookings
- ✅ Integrated with Room Service

**Overall:**
- ✅ All services start without errors
- ✅ Services register with Eureka
- ✅ API Gateway routes successfully
- ✅ Can book a room end-to-end
- ✅ Docker images build
- ✅ Docker Compose brings up full stack
- ✅ All tests passing
- ✅ Code documented
- ✅ Team ready for Sprint 2

---

## Learning Resources

### 📚 Documentation Links

- [Spring Cloud Official Docs](https://spring.io/projects/spring-cloud)
- [Spring Cloud Netflix Eureka](https://cloud.spring.io/spring-cloud-netflix/)
- [Spring Boot Guide](https://spring.io/guides/gs/spring-boot/)
- [Microservices Patterns](https://microservices.io/)
- [Docker Documentation](https://docs.docker.com/)
- [Maven Guide](https://maven.apache.org/guides/)

### 🎓 Learning Path

**Week 1:**
- [ ] Read this document
- [ ] Watch Spring Boot basics
- [ ] Setup development environment
- [ ] Start assigned tasks

**Week 2:**
- [ ] Complete implementation
- [ ] Review team members' code
- [ ] Ask questions if blocked
- [ ] Help team members

**After Sprint:**
- [ ] Reflect on learnings
- [ ] Identify improvements
- [ ] Plan Sprint 2

---

## Document Information

**Master Documentation File**
- **File Name:** SPRINT1_MASTER_DOCUMENTATION.md
- **Combined From:**
  1. EUREKA_SPRINT1_COMPLETED.md (Sprint planning)
  2. SPRINT1_PROJECT_DOCUMENTATION.md (Technical guide)
- **Version:** 2.0 (Combined)
- **Date:** 18 February 2026
- **Prepared By:** Shivendra (Person A)

**Document Structure:**
- Part 1: Sprint Planning & Overview (sections 1-4)
- Part 2: Architecture & Design (sections 5-8)
- Part 3: Implementation Guide (sections 9-12)
- Part 4: Development & Operations (sections 13-16)
- Part 5: Reference & Support (sections 17-20)

**Total Content:**
- ~3000+ lines of documentation
- 20 major sections
- Code examples throughout
- Step-by-step instructions
- Common commands reference
- Troubleshooting guide
- Success criteria

---

## Next Steps

### ✅ Immediate Actions

1. **Distribute this document** to your team
2. **Review together** - 30-minute walkthrough
3. **Answer questions** - Clarify any unclear points
4. **Start Sprint 1** - Begin implementation
5. **Daily syncs** - 15-minute standups

### 🚀 Sprint Kickoff

- [ ] Sprint Goal understood by all
- [ ] Task assignments confirmed
- [ ] Development environment set up
- [ ] First tasks started
- [ ] Daily standup scheduled

### 📋 First Week Goals

**Person 1 (Infrastructure):**
- Start SCRUM-24 (Config Server)
- Setup API Gateway routing

**You (Room Service):**
- Complete SCRUM-27 (Room Model)
- Complete SCRUM-39 (Room DB)

**Person 3 (Booking Service):**
- Complete SCRUM-31 (Booking Model)
- Complete SCRUM-41 (Booking DB)

---

## Contact & Support

**Questions about documentation?**
- Check Table of Contents for topic
- Review Troubleshooting Guide
- Ask during daily standup
- Create Jira issue if something is broken/unclear

**Need help with specific task?**
- Check step-by-step implementation section
- Review code examples
- Look at Common Commands
- Pair with team member

**Found an error in documentation?**
- Update the document
- Notify team
- Correct in next version

---

**Master Documentation Complete**
**Ready for Sprint 1 Submission**
**Good luck with implementation! 🚀**

---

*Last Updated: 18 February 2026*  
*Version: 2.0 - Master Documentation (Combined)*  
*Status: Ready for Distribution*
