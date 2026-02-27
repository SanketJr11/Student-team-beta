package com.classroom.booking_service.repository;

import com.classroom.booking_service.entity.Booking;
import com.classroom.booking_service.entity.BookingStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface BookingRepository extends JpaRepository<Booking, Long> {

    // Check if a room is already CONFIRMED for a specific date
    boolean existsByRoomIdAndBookingDateAndStatus(
            Long roomId,
            LocalDate bookingDate,
            BookingStatus status
    );
}