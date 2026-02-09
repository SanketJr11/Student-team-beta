# API Endpoints
## College Classroom Booking System

---

## 1. API Overview
This document lists the planned REST API endpoints for the College Classroom Booking System.
All requests are routed through the **API Gateway**.

Base URL:
http://localhost:8080

---

## 2. Room & Availability Service APIs

### 2.1 Get All Rooms
GET api/rooms

Returns a list of all rooms.

---

### 2.2 Get Room Details
GET api/rooms/{roomId}

Returns detailed information for a specific room.

---

### 2.3 Filter Rooms
GET api/rooms?floor={floor}&capacity={capacity}

Filters rooms based on floor and optional capacity.

---

### 2.4 Check Room Availability
GET api/rooms/{roomId}/availability

Query Parameters:
- date
- startTime
- endTime

Checks whether a room is available for the given time range.

---

### 2.5 Create Room (Admin)
POST api/rooms

Creates a new room record.

---

### 2.6 Update Room (Admin)
PUT api/rooms/{roomId}

Updates an existing room.

---

### 2.7 Delete Room (Admin)
DELETE api/rooms/{roomId}

Deletes a room from the system.

---

## 3. Booking Service APIs

### 3.1 Create Booking
POST api/bookings

Creates a booking after validating room availability.

---

### 3.2 Get Booking Details
GET api/bookings/{bookingId}

Returns booking details for a specific booking.

---

### 3.3 Get Bookings by Staff
GET api/bookings?staffId={staffId}

Returns all bookings created by a staff member.

---

### 3.4 Update Booking
PUT api/bookings/{bookingId}

Updates an existing booking.

---

### 3.5 Cancel Booking
DELETE api/bookings/{bookingId}

Cancels a booking and releases the room.

---

### 3.6 Mark Booking as Not Needed
PATCH api/bookings/{bookingId}/not-needed

Marks a booking as “Not Needed” so the room becomes available again.

---

## 4. Common API Behaviour

- 400 Bad Request – Invalid input data
- 404 Not Found – Resource not found
- 409 Conflict – Double booking detected

---

## 5. Notes
- All APIs are accessed through the API Gateway
- Authentication and authorization will be added in later sprints