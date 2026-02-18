# 📚 Sprint 1 - Project Documentation & Step-by-Step Guide

**Document Version:** 1.0  
**Date Created:** 18 February 2026  
**Project:** College Classroom Booking System  
**Sprint:** Sprint 1 (2-week duration)

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Sprint 1 Goals & Scope](#sprint-1-goals--scope)
3. [System Architecture](#system-architecture)
4. [Technology Stack](#technology-stack)
5. [Team Structure & Assignments](#team-structure--assignments)
6. [Step-by-Step Implementation Guide](#step-by-step-implementation-guide)
7. [Integration Points](#integration-points)
8. [Development Workflow](#development-workflow)
9. [Testing Strategy](#testing-strategy)
10. [Deployment & Docker](#deployment--docker)
11. [Monitoring & Observability](#monitoring--observability)
12. [Common Commands Reference](#common-commands-reference)
13. [Troubleshooting Guide](#troubleshooting-guide)
14. [Success Criteria](#success-criteria)

---

## 1. Project Overview

### 1.1 What is the College Classroom Booking System?

The College Classroom Booking System is a microservices-based web application that allows students and faculty to:
- **Search** available classrooms with specific criteria (capacity, equipment, building)
- **Book** classrooms for specific dates and times
- **Check availability** before booking
- **Cancel bookings** when plans change
- **Filter** rooms by various parameters

### 1.2 Why Microservices Architecture?

Instead of building one monolithic application, we're breaking it into independent services:

| Service | Responsibility |
|---------|-----------------|
| **Eureka Discovery Server** | Keeps track of all running services (service registry) |
| **Config Server** | Manages configuration centrally (database URLs, ports, etc.) |
| **API Gateway** | Single entry point for all client requests |
| **Room Service** | Manages classroom data, availability, filtering |
| **Booking Service** | Handles reservations, prevents conflicts, manages cancellations |

**Benefits:**
- ✅ Independent scaling (Room Service can scale separately from Booking Service)
- ✅ Independent deployment (update one service without redeploying all)
- ✅ Technology flexibility (each service can use different technologies)
- ✅ Team autonomy (3 people work in parallel without blocking each other)

### 1.3 Key Concepts

**Microservices**: Small, independent applications that work together  
**Service Discovery**: Automatic detection of available services (done by Eureka)  
**API Gateway**: Router that directs client requests to the right service  
**Database Persistence**: Data stored in a database (H2 for dev, PostgreSQL for production)

---

## 2. Sprint 1 Goals & Scope

### 2.1 Sprint Goal

> **Implement core backend microservices for the College Classroom Booking System including Room and Booking services with database persistence, Eureka discovery, Config Server, API Gateway routing, and booking validation (availability + prevent double booking).**

### 2.2 What We're Building in Sprint 1

#### Infrastructure Layer
1. **Eureka Discovery Server** ✅ (SCRUM-23)
   - Service registry for all microservices
   - Allows services to find and communicate with each other
   - Status: COMPLETE

2. **Config Server** (SCRUM-24)
   - Centralized configuration management
   - All services get their config from here
   - Example: database URL, API ports, feature flags

3. **API Gateway** (SCRUM-25)
   - Single entry point for all client requests
   - Routes requests to appropriate microservice
   - Handles cross-cutting concerns (logging, security)

4. **Error Handling & Validation** (SCRUM-26)
   - Shared library for error responses
   - Common validation rules
   - Consistent error format across all services

#### Room Service Layer
5. **Room Data Model** (SCRUM-27)
   - Define what a "Room" is: id, name, capacity, building, floor, equipment, etc.
   - Define relationships and constraints

6. **Room Database Schema** (SCRUM-39)
   - Create database tables to store room data
   - Define indexes for performance

7. **Room CRUD Operations** (SCRUM-28)
   - **C**reate new rooms
   - **R**ead room details
   - **U**pdate room information
   - **D**elete rooms
   - REST API endpoints for these operations

8. **Room Filtering** (SCRUM-29)
   - Search/filter rooms by capacity, building, floor, equipment
   - Example: "Find all rooms in Building A with 30+ capacity"

9. **Room Availability API** (SCRUM-30)
   - Check if a specific room is available on a specific date/time
   - Returns available/unavailable status
   - Used by Booking Service before creating a booking

#### Booking Service Layer
10. **Booking Data Model** (SCRUM-31)
    - Define what a "Booking" is: id, roomId, userId, startTime, endTime, status, etc.
    - Define relationships with Room and User

11. **Booking Database Schema** (SCRUM-41)
    - Create database tables to store booking data
    - Define indexes for performance

12. **Booking CRUD Operations** (SCRUM-32)
    - **C**reate new bookings
    - **R**ead booking details
    - **U**pdate booking information
    - **D**elete bookings
    - REST API endpoints for these operations

13. **Prevent Double Booking** (SCRUM-33)
    - Validate that two bookings don't overlap for the same room
    - Check availability before allowing booking
    - Critical business logic to prevent conflicts

14. **Cancel Booking** (SCRUM-34)
    - Allow users to cancel their bookings
    - Update booking status to "CANCELLED"
    - Release the room for other bookings

15. **Microservice Skeletons** (SCRUM-38) - *Optional*
    - Basic structure for any additional services needed
    - Only if required after assessing actual needs

### 2.3 What We're NOT Building in Sprint 1

- ❌ Frontend/User Interface (that's Sprint 2+)
- ❌ Authentication/Authorization (security Sprint)
- ❌ Advanced monitoring (Prometheus, Grafana - Sprint 2+)
- ❌ API documentation/Swagger (will do later)
- ❌ Performance optimization (will tune after MVP works)
- ❌ Kubernetes deployment (comes after Docker works)

---

## 3. System Architecture

### 3.1 High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENT APPLICATIONS                      │
│                    (Web, Mobile, Desktop)                        │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
        ┌────────────────────────────────────────┐
        │         API GATEWAY (Port 8080)         │
        │   (Routes requests to services)         │
        └────────┬──────────────────┬────────────┘
                 │                  │
        ┌────────▼──────┐    ┌──────▼──────────┐
        │  ROOM SERVICE  │    │ BOOKING SERVICE │
        │   (Port 8081)  │    │   (Port 8082)   │
        └────────┬──────┘    └──────┬───────────┘
                 │                  │
        ┌────────▼──────┐    ┌──────▼──────────┐
        │  Room Database │    │ Booking Database │
        │  (H2/Postgres) │    │ (H2/Postgres)   │
        └────────────────┘    └──────────────────┘

        ┌──────────────────────────────────────┐
        │   EUREKA DISCOVERY SERVER (8761)     │
        │   (Service registry - knows about all│
        │    running services)                 │
        └──────────────────────────────────────┘

        ┌──────────────────────────────────────┐
        │   CONFIG SERVER (8888)               │
        │   (Distributes configuration to      │
        │    all services)                     │
        └──────────────────────────────────────┘
```

### 3.2 Request Flow Example

**Scenario: User wants to book a classroom**

```
1. Client sends request to API Gateway
   POST /api/bookings/create
   {
     "roomId": 101,
     "startTime": "2026-02-20 10:00",
     "endTime": "2026-02-20 11:00",
     "userId": "student123"
   }

2. API Gateway routes to Booking Service
   (Gateway knows Booking Service address from Eureka)

3. Booking Service checks availability
   - Calls Room Service: "Is room 101 available on 2026-02-20 10:00-11:00?"
   - Room Service queries database and returns: YES/NO

4. If available:
   - Booking Service creates new booking record in database
   - Returns booking confirmation

5. If not available:
   - Booking Service returns error: "Room already booked for this time"
   - Client gets error response

6. All services log their actions
   - Can be aggregated for monitoring/debugging
```

### 3.3 Database Schema Overview

#### Room Table
```
ROOMS
├── id (Primary Key)
├── name (VARCHAR)
├── capacity (INTEGER)
├── building (VARCHAR)
├── floor (INTEGER)
├── equipment (VARCHAR) - e.g., "Projector, Whiteboard"
└── created_at (TIMESTAMP)
```

#### Booking Table
```
BOOKINGS
├── id (Primary Key)
├── room_id (Foreign Key → ROOMS.id)
├── user_id (VARCHAR)
├── start_time (TIMESTAMP)
├── end_time (TIMESTAMP)
├── status (VARCHAR) - e.g., "CONFIRMED", "CANCELLED"
├── created_at (TIMESTAMP)
└── updated_at (TIMESTAMP)
```

---

## 4. Technology Stack

### 4.1 Java & Spring Framework

| Component | Version | Purpose |
|-----------|---------|---------|
| **Java** | 21 LTS | Latest long-term support Java version |
| **Spring Boot** | 3.2.5 | Framework for building microservices |
| **Spring Cloud** | 2023.0.1 | Additional microservices tools |
| **Maven** | 3.9+ | Build tool & dependency management |

**Why these versions?**
- Java 21 LTS: Latest stable version with modern features (records, pattern matching, virtual threads)
- Spring Boot 3.2.5: Latest stable version with Spring Cloud support
- Maven: Industry standard for Java project building

### 4.2 Key Dependencies

```xml
<!-- Service Discovery -->
spring-cloud-starter-netflix-eureka-server
spring-cloud-starter-netflix-eureka-client

<!-- Configuration Management -->
spring-cloud-config-server
spring-cloud-config-client

<!-- API Gateway -->
spring-cloud-starter-gateway

<!-- Database & ORM -->
spring-boot-starter-data-jpa    (ORM - Object-Relational Mapping)
spring-boot-starter-data-r2dbc  (Reactive database)
h2database                        (In-memory database for development)

<!-- Web & REST -->
spring-boot-starter-web
spring-boot-starter-webflux     (Reactive web)

<!-- Monitoring & Health Checks -->
spring-boot-starter-actuator
micrometer-registry-prometheus

<!-- Testing -->
spring-boot-starter-test
junit-jupiter
```

### 4.3 Database

**Development:**
- H2 Database (in-memory, no setup required)
- Perfect for local development and testing

**Production (Future):**
- PostgreSQL or MySQL
- Persistent, scalable databases

### 4.4 Docker & Containerization

- **Base Image:** `eclipse-temurin:21-jdk` (for building)
- **Runtime Image:** `eclipse-temurin:21-jre` (for running)
- **Container Orchestration:** Docker Compose (for local multi-container setup)
- **Future:** Kubernetes (for production orchestration)

---

## 5. Team Structure & Assignments

### 5.1 3-Person Team with Parallel Workstreams

```
┌─────────────────────────────────────────────────────────────┐
│                    SPRINT 1 TEAM                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Person 1 (Infrastructure Lead)      4 Tasks              │
│  ├─ SCRUM-23: Eureka Discovery ✅                           │
│  ├─ SCRUM-24: Config Server                                │
│  ├─ SCRUM-25: API Gateway                                  │
│  └─ SCRUM-26: Error Handling                               │
│                                                              │
│  Person A / You (Room Service Lead) 5 Tasks               │
│  ├─ SCRUM-27: Room Model                                   │
│  ├─ SCRUM-39: Room Database                                │
│  ├─ SCRUM-28: Room CRUD                                    │
│  ├─ SCRUM-29: Filter Rooms                                 │
│  └─ SCRUM-30: Availability API                             │
│                                                              │
│  Person 3 (Booking Service Lead)    5 Tasks              │
│  ├─ SCRUM-31: Booking Model                                │
│  ├─ SCRUM-41: Booking Database                             │
│  ├─ SCRUM-32: Booking CRUD                                 │
│  ├─ SCRUM-33: Prevent Double Booking                       │
│  └─ SCRUM-34: Cancel Booking                               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 5.2 Work Schedule

**Week 1 (Feb 18-22):**
- Infrastructure: Set up Eureka, Config Server, API Gateway
- Room Service: Define models, create database schema
- Booking Service: Define models, create database schema

**Week 2 (Feb 25-Mar 3):**
- Infrastructure: Integrate API Gateway with services
- Room Service: Implement CRUD, filtering, availability API
- Booking Service: Implement CRUD, validation, cancellation

**No Blocking Dependencies:**
- Each team can work independently
- API contracts defined upfront
- Regular sync meetings (daily standup)

### 5.3 Communication Plan

| Meeting | Frequency | Duration | Purpose |
|---------|-----------|----------|---------|
| Daily Standup | Every morning | 15 min | Sync on progress, blockers |
| Task Sync | 2x per week | 30 min | Coordinate between workstreams |
| Sprint Review | End of Sprint | 1 hour | Demo completed work |
| Sprint Retrospective | End of Sprint | 1 hour | Improve process |

---

## 6. Step-by-Step Implementation Guide

### 6.1 Infrastructure Setup (Person 1 - Week 1)

#### Step 1: Eureka Discovery Server (SCRUM-23) ✅ COMPLETE

**What:** Service registry that keeps track of all running services

**Files Created:**
- `services/discovery-server/pom.xml` - Dependencies
- `services/discovery-server/src/main/java/EurekaServerApplication.java` - Main class
- `services/discovery-server/Dockerfile` - Container configuration
- `services/discovery-server/application.properties` - Configuration

**Verification:**
```bash
cd services/discovery-server
./mvnw clean package
./mvnw spring-boot:run
# Visit http://localhost:8761/
```

#### Step 2: Config Server (SCRUM-24)

**What:** Centralized configuration server that all services read config from

**Deliverables:**
1. Create `services/config-server/` project structure
2. Add Spring Cloud Config Server dependency
3. Create `src/main/resources/application.properties`:
   ```properties
   spring.application.name=config-server
   server.port=8888
   spring.cloud.config.server.git.uri=file:///path/to/config-repo
   # or use a real git repository
   ```
4. Create main class with `@EnableConfigServer`
5. Create sample configuration files for Room and Booking services
6. Test with: `curl http://localhost:8888/room-service/default`

#### Step 3: API Gateway (SCRUM-25)

**What:** Single entry point that routes requests to appropriate services

**Deliverables:**
1. Create `services/api-gateway/` project structure
2. Add Spring Cloud Gateway dependency
3. Create `src/main/resources/application.properties`:
   ```properties
   spring.application.name=api-gateway
   server.port=8080
   spring.cloud.gateway.routes[0].id=room-service
   spring.cloud.gateway.routes[0].uri=lb://ROOM-SERVICE
   spring.cloud.gateway.routes[0].predicates[0]=Path=/api/rooms/**
   spring.cloud.gateway.routes[1].id=booking-service
   spring.cloud.gateway.routes[1].uri=lb://BOOKING-SERVICE
   spring.cloud.gateway.routes[1].predicates[0]=Path=/api/bookings/**
   ```
4. Implement routing configuration
5. Add logging interceptors
6. Test with: `curl http://localhost:8080/api/rooms/` (should route to Room Service)

#### Step 4: Error Handling & Validation (SCRUM-26)

**What:** Shared library with common error responses and validation

**Deliverables:**
1. Create `shared/validation-library/` project
2. Create common response classes:
   ```java
   @Data
   public class ApiResponse<T> {
       private int status;
       private String message;
       private T data;
       private LocalDateTime timestamp;
   }
   
   @Data
   public class ErrorResponse {
       private String error;
       private String message;
       private int statusCode;
   }
   ```
3. Create custom exception classes:
   ```java
   public class RoomNotFoundException extends RuntimeException
   public class BookingConflictException extends RuntimeException
   public class InvalidBookingException extends RuntimeException
   ```
4. Create validation annotations and validators
5. Create global exception handler:
   ```java
   @RestControllerAdvice
   public class GlobalExceptionHandler {
       @ExceptionHandler(RoomNotFoundException.class)
       public ResponseEntity<ErrorResponse> handleRoomNotFound(...) { ... }
   }
   ```
6. Package as JAR library for other services to use

### 6.2 Room Service Implementation (You - Week 1 & 2)

#### Step 1: Room Data Model (SCRUM-27)

**What:** Define the Room entity with all fields and relationships

**Deliverables:**
1. Create `services/room-service/` project structure
2. Create `Room.java` entity class:
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
       private String name;
       
       @Column(nullable = false)
       private Integer capacity;
       
       @Column(nullable = false)
       private String building;
       
       @Column(nullable = false)
       private Integer floor;
       
       private String equipment;
       
       @CreationTimestamp
       private LocalDateTime createdAt;
       
       @UpdateTimestamp
       private LocalDateTime updatedAt;
   }
   ```
3. Create `RoomDTO.java` for API requests/responses
4. Create `RoomRepository.java` interface (extends JpaRepository)
5. Define validation constraints on fields

#### Step 2: Room Database Schema (SCRUM-39)

**What:** Create database tables for Room entity

**Deliverables:**
1. Create `src/main/resources/db/migration/V1__create_rooms_table.sql`:
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
       UNIQUE(name)
   );
   
   CREATE INDEX idx_building_floor ON rooms(building, floor);
   CREATE INDEX idx_capacity ON rooms(capacity);
   ```
2. Configure Flyway for database migrations
3. Test: Run application and verify tables created
4. Insert sample data:
   ```sql
   INSERT INTO rooms VALUES 
   (1, 'A101', 30, 'Building A', 1, 'Projector, Whiteboard', NOW(), NOW()),
   (2, 'A102', 20, 'Building A', 1, 'Projector', NOW(), NOW()),
   (3, 'B201', 50, 'Building B', 2, 'Interactive Board', NOW(), NOW());
   ```

#### Step 3: Room CRUD Operations (SCRUM-28)

**What:** REST API endpoints to Create, Read, Update, Delete rooms

**Deliverables:**
1. Create `RoomService.java` with business logic:
   ```java
   @Service
   public class RoomService {
       @Autowired
       private RoomRepository roomRepository;
       
       public RoomDTO createRoom(CreateRoomRequest request) { ... }
       public RoomDTO getRoom(Long id) { ... }
       public List<RoomDTO> getAllRooms() { ... }
       public RoomDTO updateRoom(Long id, UpdateRoomRequest request) { ... }
       public void deleteRoom(Long id) { ... }
   }
   ```
2. Create `RoomController.java` with REST endpoints:
   ```java
   @RestController
   @RequestMapping("/api/rooms")
   public class RoomController {
       @PostMapping
       public ResponseEntity<RoomDTO> createRoom(@RequestBody CreateRoomRequest req) { ... }
       
       @GetMapping("/{id}")
       public ResponseEntity<RoomDTO> getRoom(@PathVariable Long id) { ... }
       
       @GetMapping
       public ResponseEntity<List<RoomDTO>> getAllRooms() { ... }
       
       @PutMapping("/{id}")
       public ResponseEntity<RoomDTO> updateRoom(@PathVariable Long id, ...) { ... }
       
       @DeleteMapping("/{id}")
       public ResponseEntity<Void> deleteRoom(@PathVariable Long id) { ... }
   }
   ```
3. Test all endpoints with cURL or Postman:
   ```bash
   # Create room
   curl -X POST http://localhost:8081/api/rooms \
     -H "Content-Type: application/json" \
     -d '{"name":"C301", "capacity":25, "building":"Building C", "floor":3}'
   
   # Get room
   curl http://localhost:8081/api/rooms/1
   
   # Update room
   curl -X PUT http://localhost:8081/api/rooms/1 \
     -H "Content-Type: application/json" \
     -d '{"capacity":35}'
   
   # Delete room
   curl -X DELETE http://localhost:8081/api/rooms/1
   ```

#### Step 4: Room Filtering (SCRUM-29)

**What:** Search and filter rooms by various criteria

**Deliverables:**
1. Create `RoomFilter.java` class with filter criteria:
   ```java
   @Data
   public class RoomFilter {
       private Integer minCapacity;
       private String building;
       private Integer floor;
       private String equipment;
   }
   ```
2. Extend `RoomRepository` with custom queries:
   ```java
   public interface RoomRepository extends JpaRepository<Room, Long> {
       List<Room> findByCapacityGreaterThanEqual(Integer capacity);
       List<Room> findByBuilding(String building);
       List<Room> findByBuildingAndFloor(String building, Integer floor);
       List<Room> findByEquipmentContaining(String equipment);
       
       // Custom query using @Query
       @Query("SELECT r FROM Room r WHERE r.capacity >= :capacity " +
              "AND (:building IS NULL OR r.building = :building)")
       List<Room> findByFilters(@Param("capacity") Integer capacity, 
                               @Param("building") String building);
   }
   ```
3. Create filter endpoint in controller:
   ```java
   @GetMapping("/search")
   public ResponseEntity<List<RoomDTO>> searchRooms(
       @RequestParam(required = false) Integer minCapacity,
       @RequestParam(required = false) String building,
       @RequestParam(required = false) Integer floor) { ... }
   ```
4. Test filtering:
   ```bash
   # Find rooms with min capacity 30
   curl "http://localhost:8081/api/rooms/search?minCapacity=30"
   
   # Find rooms in Building A
   curl "http://localhost:8081/api/rooms/search?building=Building%20A"
   
   # Combine filters
   curl "http://localhost:8081/api/rooms/search?minCapacity=30&building=Building%20A&floor=2"
   ```

#### Step 5: Availability API (SCRUM-30)

**What:** Check if a specific room is available on a specific date/time

**Deliverables:**
1. Create `RoomAvailability.java` class:
   ```java
   @Data
   public class RoomAvailability {
       private Long roomId;
       private LocalDateTime checkInTime;
       private LocalDateTime checkOutTime;
       private boolean available;
       private String reason; // "Available", "Room booked", etc.
   }
   ```
2. Create availability check logic in RoomService:
   ```java
   public RoomAvailability checkAvailability(Long roomId, 
                                             LocalDateTime startTime, 
                                             LocalDateTime endTime) {
       // Query booking service to check if any bookings overlap
       // Return availability result
   }
   ```
3. Create endpoint in RoomController:
   ```java
   @GetMapping("/{id}/availability")
   public ResponseEntity<RoomAvailability> checkAvailability(
       @PathVariable Long id,
       @RequestParam LocalDateTime startTime,
       @RequestParam LocalDateTime endTime) { ... }
   ```
4. Implement inter-service communication:
   ```java
   // Call Booking Service via REST to check availability
   RestTemplate restTemplate = new RestTemplate();
   BookingCheckResponse response = restTemplate.postForObject(
       "http://booking-service:8082/api/bookings/check-availability",
       availabilityRequest,
       BookingCheckResponse.class
   );
   ```
5. Test availability:
   ```bash
   # Check if room 1 is available on Feb 20 from 10am-11am
   curl "http://localhost:8081/api/rooms/1/availability?" \
        "startTime=2026-02-20T10:00:00&endTime=2026-02-20T11:00:00"
   ```

### 6.3 Booking Service Implementation (Person 3 - Week 1 & 2)

#### Step 1: Booking Data Model (SCRUM-31)

**What:** Define the Booking entity with all fields and relationships

**Deliverables:**
1. Create `services/booking-service/` project structure
2. Create `Booking.java` entity class:
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
       private Long roomId; // Reference to Room Service
       
       @Column(nullable = false)
       private String userId; // Reference to User Service
       
       @Column(nullable = false)
       private LocalDateTime startTime;
       
       @Column(nullable = false)
       private LocalDateTime endTime;
       
       @Enumerated(EnumType.STRING)
       private BookingStatus status; // CONFIRMED, CANCELLED, PENDING
       
       @CreationTimestamp
       private LocalDateTime createdAt;
       
       @UpdateTimestamp
       private LocalDateTime updatedAt;
   }
   ```
3. Create `BookingDTO.java` for API requests/responses
4. Create `BookingRepository.java` interface
5. Define validation constraints

#### Step 2: Booking Database Schema (SCRUM-41)

**What:** Create database tables for Booking entity

**Deliverables:**
1. Create `src/main/resources/db/migration/V1__create_bookings_table.sql`:
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
       CONSTRAINT chk_times CHECK (start_time < end_time)
   );
   
   CREATE INDEX idx_room_id ON bookings(room_id);
   CREATE INDEX idx_user_id ON bookings(user_id);
   CREATE INDEX idx_start_time ON bookings(start_time);
   CREATE UNIQUE INDEX idx_room_time ON bookings(room_id, start_time, end_time, status)
       WHERE status = 'CONFIRMED';
   ```
2. Configure Flyway for migrations
3. Test: Run application and verify tables created
4. Insert sample data

#### Step 3: Booking CRUD Operations (SCRUM-32)

**What:** REST API endpoints for Create, Read, Update, Delete bookings

**Deliverables:**
1. Create `BookingService.java` with business logic
2. Create `BookingController.java` with REST endpoints:
   ```java
   @RestController
   @RequestMapping("/api/bookings")
   public class BookingController {
       @PostMapping
       public ResponseEntity<BookingDTO> createBooking(...) { ... }
       
       @GetMapping("/{id}")
       public ResponseEntity<BookingDTO> getBooking(@PathVariable Long id) { ... }
       
       @GetMapping
       public ResponseEntity<List<BookingDTO>> getAllBookings() { ... }
       
       @PutMapping("/{id}")
       public ResponseEntity<BookingDTO> updateBooking(...) { ... }
       
       @DeleteMapping("/{id}")
       public ResponseEntity<Void> deleteBooking(@PathVariable Long id) { ... }
   }
   ```
3. Test all endpoints

#### Step 4: Prevent Double Booking (SCRUM-33)

**What:** Critical business logic to prevent conflicting bookings

**Deliverables:**
1. Create availability validation in BookingService:
   ```java
   private void validateAvailability(Long roomId, 
                                    LocalDateTime startTime, 
                                    LocalDateTime endTime) {
       List<Booking> conflicts = bookingRepository.findConflictingBookings(
           roomId, startTime, endTime);
       
       if (!conflicts.isEmpty()) {
           throw new BookingConflictException(
               "Room already booked for this time period");
       }
   }
   ```
2. Add database query to find overlapping bookings:
   ```java
   // In BookingRepository
   @Query("SELECT b FROM Booking b WHERE b.roomId = :roomId " +
          "AND b.status = 'CONFIRMED' " +
          "AND b.startTime < :endTime " +
          "AND b.endTime > :startTime")
   List<Booking> findConflictingBookings(@Param("roomId") Long roomId,
                                         @Param("startTime") LocalDateTime startTime,
                                         @Param("endTime") LocalDateTime endTime);
   ```
3. Call this validation before creating booking
4. Test conflict detection:
   ```bash
   # Try to book same room at overlapping time - should fail
   curl -X POST http://localhost:8082/api/bookings \
     -H "Content-Type: application/json" \
     -d '{"roomId":1, "userId":"student1", 
          "startTime":"2026-02-20T10:00", "endTime":"2026-02-20T10:30"}'
   # Should return: Booking conflict error
   ```

#### Step 5: Cancel Booking (SCRUM-34)

**What:** Allow users to cancel their bookings

**Deliverables:**
1. Create cancel endpoint in BookingController:
   ```java
   @PatchMapping("/{id}/cancel")
   public ResponseEntity<BookingDTO> cancelBooking(@PathVariable Long id) {
       Booking booking = bookingRepository.findById(id)
           .orElseThrow(() -> new BookingNotFoundException(...));
       
       if (booking.getStatus() == BookingStatus.CANCELLED) {
           throw new InvalidBookingException("Booking already cancelled");
       }
       
       booking.setStatus(BookingStatus.CANCELLED);
       bookingRepository.save(booking);
       return ResponseEntity.ok(convertToDTO(booking));
   }
   ```
2. Add validation to prevent canceling old bookings:
   ```java
   if (booking.getStartTime().isBefore(LocalDateTime.now())) {
       throw new InvalidBookingException(
           "Cannot cancel past bookings");
   }
   ```
3. Test cancellation:
   ```bash
   # Cancel booking with id 5
   curl -X PATCH http://localhost:8082/api/bookings/5/cancel
   ```

---

## 7. Integration Points

### 7.1 How Services Communicate

#### Service A calls Service B

```
Service A (Room Service) needs to call Service B (Booking Service)

Instead of hardcoding "http://localhost:8082", use Service Discovery:

1. Service A asks Eureka: "Where is Booking Service?"
2. Eureka responds: "It's running at 192.168.1.100:8082"
3. Service A makes HTTP request to that address

Code:
@Autowired
private DiscoveryClient discoveryClient;

ServiceInstance instance = discoveryClient.getInstances("BOOKING-SERVICE").get(0);
String url = instance.getUri().toString() + "/api/bookings/check";
```

#### API Gateway routes requests

```
Client makes request: POST /api/bookings/create

API Gateway:
1. Sees the path /api/bookings/**
2. Knows this should go to Booking Service
3. Routes to: http://booking-service:8082/api/bookings/create

Client never directly calls microservices, only through Gateway.
```

#### Config Server provides configuration

```
Booking Service starts up:

1. Asks Config Server: "What's my configuration?"
2. Config Server checks Git repository or file system
3. Returns configuration like:
   - Database URL
   - Service port
   - Feature flags
   - Any other needed config

This way, you can change configuration without redeploying the service.
```

### 7.2 Data Flow: Creating a Booking

```
Complete flow when user books a room:

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
   - Receives request
   - Routes to Booking Service (via discovery)
   ↓
   
3. BOOKING SERVICE (Port 8082)
   - Receives create booking request
   - Validates input (times, roomId, userId)
   - Checks: Is room 1 available from 10:00-11:00?
   - Makes HTTP call to ROOM SERVICE
   ↓
   
4. ROOM SERVICE (Port 8081)
   - Receives availability check
   - Queries database
   - Calls BOOKING SERVICE back: "Already 2 confirmed bookings for room 1 that day"
   - Returns: availability = false
   ↓
   
5. BOOKING SERVICE (back in step 3)
   - Gets availability = false
   - Throws BookingConflictException
   - Returns error to client
   ↓
   
6. API GATEWAY
   - Receives error from Booking Service
   - Passes to client
   ↓
   
7. CLIENT
   Receives: 409 Conflict
   {
     "error": "BookingConflict",
     "message": "Room already booked for this time period"
   }

---

Alternative: If room is available

At step 5 (booking service get success):
   - Creates new BOOKING record in database
   - Returns booking confirmation
   - Client gets: 201 Created with booking details
```

---

## 8. Development Workflow

### 8.1 Development Environment Setup

**Prerequisites:**
- Java 21 JDK installed
- Maven 3.9+ installed
- Git installed
- IDE (IntelliJ IDEA or VS Code recommended)
- Docker installed (for containerized testing)

**Setup Steps:**

1. **Clone repository:**
   ```bash
   git clone <repository-url>
   cd Student-team-beta
   ```

2. **Build all services:**
   ```bash
   # Build Eureka (already done)
   cd services/discovery-server
   ./mvnw clean package
   
   # Build Room Service
   cd ../room-service
   ./mvnw clean package
   
   # Build Booking Service
   cd ../booking-service
   ./mvnw clean package
   ```

3. **Run services locally:**
   ```bash
   # Terminal 1: Start Eureka
   cd services/discovery-server
   ./mvnw spring-boot:run
   
   # Terminal 2: Start Config Server
   cd services/config-server
   ./mvnw spring-boot:run
   
   # Terminal 3: Start API Gateway
   cd services/api-gateway
   ./mvnw spring-boot:run
   
   # Terminal 4: Start Room Service
   cd services/room-service
   ./mvnw spring-boot:run
   
   # Terminal 5: Start Booking Service
   cd services/booking-service
   ./mvnw spring-boot:run
   ```

4. **Verify services are running:**
   ```bash
   # Check Eureka Dashboard
   curl http://localhost:8761/
   # Should show all services registered
   
   # Check health
   curl http://localhost:8080/actuator/health
   ```

### 8.2 Git Workflow

**Branch naming convention:**
```
feature/SCRUM-27-room-model
bugfix/SCRUM-33-booking-conflict
hotfix/database-timeout
```

**Commit message format:**
```
SCRUM-27: Implement Room model entity

- Created Room.java with JPA annotations
- Added validation for capacity and floor
- Created RoomDTO for API responses
```

**Pull Request checklist:**
- [ ] Code follows team style guide
- [ ] All tests pass locally
- [ ] Tests added for new functionality
- [ ] No debug code or console.log
- [ ] Related Jira ticket linked

### 8.3 Code Review Process

1. **Person creates feature branch**
   ```bash
   git checkout -b feature/SCRUM-27-room-model
   # Make changes
   git add .
   git commit -m "SCRUM-27: ..."
   git push origin feature/SCRUM-27-room-model
   ```

2. **Create Pull Request (PR)**
   - Describe what changed
   - Link to SCRUM ticket
   - Request code review from team member

3. **Code Review (Peer)**
   - Review code logic
   - Check for bugs
   - Suggest improvements
   - Approve or request changes

4. **Merge to main**
   - Reviewer approves
   - Author merges PR
   - Delete feature branch

---

## 9. Testing Strategy

### 9.1 Unit Tests

**What to test:** Individual methods/functions

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
    }
    
    @Test
    void testCreateRoom_InvalidCapacity() {
        CreateRoomRequest request = new CreateRoomRequest(
            "A101", -5, "Building A", 1, "Projector");
        
        assertThrows(InvalidRoomException.class, 
            () -> roomService.createRoom(request));
    }
}
```

### 9.2 Integration Tests

**What to test:** Multiple components working together

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

### 9.3 End-to-End Tests

**What to test:** Complete workflows across services

```
Test: User books a room

Setup:
1. Start all services (or use Docker Compose)
2. Insert test data (rooms)

Test Steps:
1. Call GET /api/rooms (should return rooms)
2. Call GET /api/rooms/1/availability (should be available)
3. Call POST /api/bookings/create (should succeed)
4. Call GET /api/rooms/1/availability (should be unavailable)
5. Call POST /api/bookings/create again (should fail)

Cleanup:
1. Delete test booking
2. Verify database is clean
```

### 9.4 Running Tests

```bash
# Run all unit tests
./mvnw test

# Run specific test class
./mvnw test -Dtest=RoomServiceTest

# Run with coverage report
./mvnw test jacoco:report

# View coverage: target/site/jacoco/index.html
```

---

## 10. Deployment & Docker

### 10.1 Docker Build for Single Service

```bash
cd services/room-service

# Build Docker image
docker build -t room-service:1.0 .

# Run container
docker run -p 8081:8081 room-service:1.0

# View logs
docker logs <container-id>

# Stop container
docker stop <container-id>
```

### 10.2 Docker Compose for Full Stack

**File: `deployments/docker-compose/docker-compose.yml`**

```yaml
version: '3.8'

services:
  eureka:
    image: eureka-server:1.0
    ports:
      - "8761:8761"
    environment:
      - SPRING_PROFILES_ACTIVE=docker
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
    environment:
      - EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka:8761/eureka/

  api-gateway:
    image: api-gateway:1.0
    ports:
      - "8080:8080"
    depends_on:
      eureka:
        condition: service_healthy
    environment:
      - EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka:8761/eureka/

  room-service:
    image: room-service:1.0
    ports:
      - "8081:8081"
    depends_on:
      eureka:
        condition: service_healthy
    environment:
      - EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka:8761/eureka/
      - DATABASE_URL=jdbc:h2:mem:roomdb

  booking-service:
    image: booking-service:1.0
    ports:
      - "8082:8082"
    depends_on:
      eureka:
        condition: service_healthy
    environment:
      - EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka:8761/eureka/
      - DATABASE_URL=jdbc:h2:mem:bookingdb

networks:
  default:
    name: student-booking-network
```

**Run full stack:**
```bash
cd deployments/docker-compose
docker-compose up -d
docker-compose logs -f
docker-compose down
```

---

## 11. Monitoring & Observability

### 11.1 Health Checks

**Endpoint: `/actuator/health`**

```bash
curl http://localhost:8081/actuator/health

Response:
{
  "status": "UP",
  "components": {
    "diskSpace": { "status": "UP", "details": {...} },
    "db": { "status": "UP", "details": {...} },
    "livenessState": { "status": "UP" },
    "readinessState": { "status": "UP" }
  }
}
```

### 11.2 Metrics

**Endpoint: `/actuator/metrics`**

```bash
# List all metrics
curl http://localhost:8081/actuator/metrics

# Get specific metric
curl http://localhost:8081/actuator/metrics/jvm.memory.used
```

### 11.3 Application Info

**Endpoint: `/actuator/info`**

```bash
curl http://localhost:8081/actuator/info

Response:
{
  "app": {
    "name": "Room Service",
    "version": "1.0.0"
  },
  "java": {
    "version": "21"
  }
}
```

---

## 12. Common Commands Reference

### 12.1 Maven Commands

```bash
# Clean build (remove old build)
./mvnw clean

# Compile code
./mvnw compile

# Run tests
./mvnw test

# Package into JAR
./mvnw package

# Install to local repository
./mvnw install

# Run Spring Boot app directly
./mvnw spring-boot:run

# Skip tests during build
./mvnw package -DskipTests

# Build with specific profile
./mvnw package -P production
```

### 12.2 Git Commands

```bash
# Clone repository
git clone <url>

# Create and switch to new branch
git checkout -b feature/SCRUM-27

# Stage changes
git add .

# Commit changes
git commit -m "SCRUM-27: message"

# Push to remote
git push origin feature/SCRUM-27

# Pull latest changes
git pull origin main

# View commit history
git log --oneline

# View differences
git diff

# Revert changes
git reset --hard HEAD
```

### 12.3 Docker Commands

```bash
# Build image
docker build -t service-name:1.0 .

# Run container
docker run -p 8080:8080 service-name:1.0

# List running containers
docker ps

# View logs
docker logs <container-id>

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>

# Docker Compose up
docker-compose up -d

# Docker Compose down
docker-compose down

# View Docker Compose logs
docker-compose logs -f <service-name>
```

### 12.4 cURL Commands for API Testing

```bash
# GET request
curl http://localhost:8081/api/rooms/1

# POST request with JSON
curl -X POST http://localhost:8081/api/rooms \
  -H "Content-Type: application/json" \
  -d '{"name":"A101","capacity":30,"building":"Building A","floor":1}'

# PUT request
curl -X PUT http://localhost:8081/api/rooms/1 \
  -H "Content-Type: application/json" \
  -d '{"capacity":35}'

# DELETE request
curl -X DELETE http://localhost:8081/api/rooms/1

# Request with query parameters
curl "http://localhost:8081/api/rooms/search?minCapacity=30&building=Building%20A"

# Request with headers
curl -H "Authorization: Bearer token" http://localhost:8081/api/rooms

# Pretty print JSON response
curl http://localhost:8081/api/rooms | jq .
```

---

## 13. Troubleshooting Guide

### 13.1 Common Issues & Solutions

#### Issue: "Connection refused" when calling another service

**Cause:** Service not running or wrong port/address

**Solution:**
```bash
# 1. Check if service is running
docker ps
# or 
ps aux | grep java

# 2. Check if service registered with Eureka
curl http://localhost:8761/eureka/apps

# 3. Check service logs
docker logs <service-name>
# or
./mvnw spring-boot:run (and watch terminal)

# 4. Verify correct service name in config
# Should match: @EnableEurekaClient + spring.application.name
```

#### Issue: "Database table not found"

**Cause:** Flyway migrations didn't run

**Solution:**
```bash
# 1. Check if Flyway is in pom.xml
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
</dependency>

# 2. Verify migration files exist
ls src/main/resources/db/migration/

# 3. Check application.properties
spring.flyway.enabled=true
spring.jpa.hibernate.ddl-auto=validate

# 4. Check logs for Flyway output
# Should see: "Successfully validated 1 migration (execution time 5ms)"
```

#### Issue: "Port already in use"

**Cause:** Another process using same port

**Solution:**
```bash
# Find process using port 8081
lsof -i :8081
# or on Windows
netstat -ano | findstr :8081

# Kill process
kill <process-id>
# or on Windows
taskkill /PID <process-id> /F

# Change port in application.properties
server.port=8083
```

#### Issue: "Eureka server not registering services"

**Cause:** Service not configured correctly for Eureka

**Solution:**
```
Check each service has:

1. Dependency in pom.xml:
   spring-cloud-starter-netflix-eureka-client

2. Annotation in main class:
   @EnableEurekaClient
   @SpringBootApplication

3. Configuration in application.properties:
   eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
   spring.application.name=room-service
```

#### Issue: "Cross-origin request blocked"

**Cause:** CORS not configured

**Solution:**
```java
@Configuration
public class CorsConfig {
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/**")
                    .allowedOrigins("*")
                    .allowedMethods("*")
                    .allowedHeaders("*");
            }
        };
    }
}
```

### 13.2 Debug Checklist

```
When something doesn't work:

1. ✓ Check service is running
   - curl http://localhost:<port>/actuator/health

2. ✓ Check service registered with Eureka
   - curl http://localhost:8761/eureka/apps

3. ✓ Check logs for errors
   - Look for stacktraces, error messages

4. ✓ Check configuration
   - Right port, database URL, service name

5. ✓ Check database
   - Tables exist: SELECT * FROM information_schema.tables
   - Data exists: SELECT * FROM rooms

6. ✓ Test direct call to service (bypass gateway)
   - curl http://localhost:8081/api/rooms

7. ✓ Check if database is connected
   - curl http://localhost:8081/actuator/health (check 'db' component)

8. ✓ Check dependencies are correct
   - Run: ./mvnw dependency:tree
   - Look for conflicts/missing dependencies
```

---

## 14. Success Criteria

### 14.1 Sprint 1 Definition of Done

**For Each Task to be "DONE":**

1. **Code Complete**
   - [ ] Feature implemented according to requirements
   - [ ] Code follows team style guide
   - [ ] No hardcoded values or debug code

2. **Tested**
   - [ ] Unit tests written and passing
   - [ ] Integration tests passing
   - [ ] Manual testing completed
   - [ ] Edge cases handled

3. **Documented**
   - [ ] JavaDoc comments on public methods
   - [ ] README updated if needed
   - [ ] Database changes documented

4. **Code Reviewed**
   - [ ] Pull Request reviewed by team member
   - [ ] All feedback addressed
   - [ ] Approved and merged to main branch

5. **Integrated**
   - [ ] Works with other services
   - [ ] Registered with Eureka
   - [ ] Accessible through API Gateway
   - [ ] Uses Config Server for configuration

### 14.2 Sprint 1 Overall Success Criteria

```
Infrastructure (Person 1):
✅ Eureka server running and registering services
✅ Config server distributing config to services
✅ API Gateway routing requests to Room & Booking services
✅ Error handling library created and used across services

Room Service (You):
✅ Can create/read/update/delete rooms
✅ Can filter rooms by capacity, building, floor
✅ Can check room availability for specific time slots
✅ Integrated with Booking Service for availability check
✅ Database persistence working

Booking Service (Person 3):
✅ Can create/read/update/delete bookings
✅ Prevents double bookings (validates availability)
✅ Can cancel bookings
✅ Calls Room Service for availability checks
✅ Database persistence working

Overall:
✅ All services start without errors
✅ Services register with Eureka
✅ API Gateway can route requests successfully
✅ Can book a room via API Gateway
✅ Can cancel a booking
✅ Docker images build successfully
✅ Docker Compose brings up full stack
✅ All tests passing
✅ Code is documented
✅ Team is ready for Sprint 2
```

### 14.3 Key Metrics

By end of Sprint 1:

| Metric | Target | Status |
|--------|--------|--------|
| Test Coverage | > 70% | TBD |
| Code Review Completion | 100% | TBD |
| Build Success Rate | 100% | TBD |
| Service Uptime | > 99% | TBD |
| API Response Time | < 200ms avg | TBD |
| Team Velocity | 15 story points | TBD |

---

## 15. Additional Resources

### 15.1 Helpful Links

**Spring Cloud Documentation**
- https://spring.io/projects/spring-cloud
- https://cloud.spring.io/spring-cloud-netflix/

**Spring Boot Guides**
- https://spring.io/guides/gs/spring-boot/
- https://spring.io/guides/gs/rest-service/

**Microservices Patterns**
- https://microservices.io/
- https://martinfowler.com/microservices/

**Docker Documentation**
- https://docs.docker.com/
- https://docs.docker.com/compose/

**Maven Guide**
- https://maven.apache.org/guides/

### 15.2 Team Resources

- **Jira Board:** [Link to your Jira project]
- **Git Repository:** [Link to your Git repo]
- **Documentation Wiki:** [Link if you have one]
- **Communication Channel:** [Slack, Teams, etc.]

### 15.3 Learning Path

**Week 1:**
- [ ] Read this document thoroughly
- [ ] Watch Spring Boot basics video (if available)
- [ ] Watch Microservices introduction (if available)
- [ ] Setup development environment

**Week 2:**
- [ ] Complete your assigned tasks
- [ ] Review team members' code
- [ ] Ask questions if unclear
- [ ] Help team members if they're blocked

**After Sprint:**
- [ ] Reflect on what went well
- [ ] Identify improvements for Sprint 2
- [ ] Update documentation based on learnings

---

## 📝 Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-18 | Initial Sprint 1 documentation |

---

## 📞 Contact & Support

**Have questions about this document?**
- Ask in team communication channel
- Check Jira ticket descriptions
- Review service README files
- Ask during daily standup

**Need help with specific task?**
- Check Troubleshooting Guide (section 13)
- Review Common Commands (section 12)
- Check service-specific documentation
- Pair with team member

---

**Document prepared for Sprint 1 submission**  
**College Classroom Booking System - Backend Microservices**  
**Team: Person 1 (Infra), Person A/You (Room Service), Person 3 (Booking Service)**

---

*Ready to start building? Good luck! 🚀*
