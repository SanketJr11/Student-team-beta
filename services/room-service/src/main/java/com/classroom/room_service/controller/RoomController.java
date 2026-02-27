package com.classroom.room_service.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

import com.classroom.room_service.entity.Room;
import com.classroom.room_service.repository.RoomRepository;

@RestController
@RequestMapping("/rooms")
public class RoomController {

    @Autowired
    private RoomRepository repository;

    @PostMapping
    public Room create(@RequestBody Room room) {
        return repository.save(room);
    }

    @GetMapping
    public List<Room> getAll() {
        return repository.findAll();
    }
}