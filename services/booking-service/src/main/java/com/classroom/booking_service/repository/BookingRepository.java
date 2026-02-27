package com.classroom.booking_service.repository;

import com.classroom.booking_service.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface BookingRepository extends JpaRepository<Booking, Long> {

    boolean existsByRoomIdAndBookingDate(Long roomId, LocalDate bookingDate);
}