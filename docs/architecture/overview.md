# Architecture Overview
## College Classroom Booking System using Microservices and CI/CD

---

## 1. Application Domain and Purpose
The College Classroom Booking System is a web-based application designed to manage classroom availability and bookings within a college environment.  
The purpose of the system is to enable staff members to view available classrooms, book rooms for lectures, meetings, or events, and release rooms when they are no longer required.

The system is implemented using a microservices architecture to ensure scalability, maintainability, and independent deployment of services.

---

## 2. Problem Being Addressed
Currently, classroom booking in colleges is often handled manually or through disconnected tools. This leads to:
- Double booking of classrooms
- Lack of real-time visibility into room availability
- Inefficient utilisation of rooms
- Last-minute scheduling conflicts

This project addresses these issues by providing a centralised, real-time booking system with automated availability checks and booking validation.

---

## 3. Intended Users
The primary users of the system are:
- **Staff Members**: View room availability, create bookings, cancel bookings, and mark rooms as “Not Needed”.
- **Administrators**: Manage room details such as floor, capacity, and available equipment.

---

## 4. High-Level Rationale
A microservices-based architecture has been chosen for the following reasons:
- Each service can be developed, tested, and deployed independently
- Improved fault isolation between services
- Better scalability as demand increases
- Alignment with modern cloud-native and DevOps practices

CI/CD is incorporated to automate builds and testing, improving development speed and code quality.

---

## 5. High-Level Architecture Components

### 5.1 API Gateway
- Acts as the single entry point for all client requests
- Routes requests to backend microservices
- Integrates with Eureka Discovery Server for dynamic service lookup

### 5.2 Eureka Discovery Server
- Handles service registration and discovery
- Eliminates hard-coded service URLs

### 5.3 Config Server
- Centralised configuration management
- Stores external configuration for all microservices
- Ensures consistency across environments

---

## 6. Core Microservices

### 6.1 Room & Availability Service
**Responsibilities:**
- Manage classroom details (room number, floor, capacity, equipment)
- Provide room search and filtering functionality
- Check room availability based on date and time

**Database:**
- Uses a relational database (MySQL) to persist room information

---

### 6.2 Booking Service
**Responsibilities:**
- Manage room bookings
- Prevent double booking using time-overlap validation
- Allow booking cancellation and room release
- Communicate with Room Service to validate room availability

**Database:**
- Uses a relational database (MySQL recommended)
- Supports multiple service instances sharing the same database

---

## 7. Service Communication
- Services communicate using REST APIs
- Booking Service calls Room Service to validate room existence and availability
- All communication is routed through the API Gateway

---

## 8. CI/CD and Future Enhancements
- Jenkins is used for automated build and test execution
- Docker, monitoring, authentication, and resilience features will be added in later sprints

---

## 9. Summary
This architecture provides a scalable and maintainable foundation for the College Classroom Booking System. The combination of microservices, centralised configuration, service discovery, and CI/CD ensures the system can evolve efficiently as new requirements are introduced.