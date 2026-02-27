package com.classroom.booking_service.service;
import com.classroom.booking_service.exception.BookingConflictException;
import com.classroom.booking_service.entity.Booking;
import com.classroom.booking_service.entity.BookingStatus;
import com.classroom.booking_service.repository.BookingRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookingService {

    private final BookingRepository repository;

    public BookingService(BookingRepository repository) {
        this.repository = repository;
    }

    public List<Booking> getAllBookings() {
        return repository.findAll();
    }

    public Booking createBooking(Booking booking) {

    	if (repository.existsByRoomIdAndBookingDateAndStatus(
    	        booking.getRoomId(),
    	        booking.getBookingDate(),
    	        BookingStatus.CONFIRMED)) {

    	    throw new BookingConflictException("Room already booked for this date");
    	}

        return repository.save(booking);
    }

    public Booking cancelBooking(Long id) {

        Booking booking = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setStatus(BookingStatus.CANCELLED);

        return repository.save(booking);
    }
}