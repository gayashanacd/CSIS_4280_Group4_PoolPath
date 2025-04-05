import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/ride.dart';
import '../models/message.dart';
import '../models/request.dart';

class DummyData {
  // Users
  static final List<UserModel> users = [
    UserModel(
      id: 'u1',
      name: 'Alex',
      profileImage: 'assets/images/alex.jpg',
      email: 'alex@poolpath.com',
      phone: '+1234567890',
      rating: 4.8,
      totalRides: 42,
      preferences: {
        'smoking': false,
        'pets': true,
        'music': 'Any',
      },
    ),
    UserModel(
      id: 'u2',
      name: 'John',
      profileImage: 'assets/images/john.jpg',
      email: 'john@poolpath.com',
      phone: '+1987654321',
      rating: 4.5,
      totalRides: 15,
    ),
    UserModel(
      id: 'u3',
      name: 'Sam',
      profileImage: 'assets/images/sam.jpg',
      email: 'sam@poolpath.com',
      phone: '+1122334455',
      rating: 4.9,
      totalRides: 27,
    ),
    UserModel(
      id: 'u4',
      name: 'Andrew',
      profileImage: 'assets/images/andrew.jpg',
      email: 'andrew@poolpath.com',
      phone: '+1555666777',
      rating: 4.7,
      totalRides: 31,
    ),
    UserModel(
      id: 'u5',
      name: 'Jim',
      profileImage: 'assets/images/jim.jpg',
      rating: 4.6,
      totalRides: 19,
    ),
    UserModel(
      id: 'u6',
      name: 'Ivan',
      profileImage: 'assets/images/ivan.jpg',
      rating: 4.4,
      totalRides: 9,
    ),
  ];

  // Rides
  static final List<RideModel> rides = [
    RideModel(
      id: 'r1',
      driverId: 'u1',
      driverName: 'Alex',
      from: 'Vancouver',
      to: 'Victoria',
      date: DateTime(2025, 1, 31),
      time: TimeOfDay(hour: 8, minute: 30),
      availableSeats: 2,
      price: 250,
      imageUrl: 'assets/images/victoria.jpg',
      description: 'Scenic ride from Vancouver to Victoria, including a ferry trip across the stunning Strait of Georgia. Comfortable and convenient carpool option—reserve your seat now!',
    ),
    RideModel(
      id: 'r2',
      driverId: 'u2',
      driverName: 'John',
      from: 'Vancouver',
      to: 'Victoria',
      date: DateTime(2025, 1, 31),
      time: TimeOfDay(hour: 8, minute: 30),
      availableSeats: 3,
      price: 250,
      imageUrl: 'assets/images/victoria.jpg',
    ),
    RideModel(
      id: 'r3',
      driverId: 'u3',
      driverName: 'Sam',
      from: 'Vancouver',
      to: 'Victoria',
      date: DateTime(2025, 1, 31),
      time: TimeOfDay(hour: 8, minute: 30),
      availableSeats: 4,
      price: 250,
      imageUrl: 'assets/images/victoria.jpg',
    ),
    RideModel(
      id: 'r4',
      driverId: 'u4',
      driverName: 'Andrew',
      from: 'Vancouver',
      to: 'Victoria',
      date: DateTime(2025, 1, 31),
      time: TimeOfDay(hour: 8, minute: 30),
      availableSeats: 2,
      price: 250,
      imageUrl: 'assets/images/victoria.jpg',
    ),
    RideModel(
      id: 'r5',
      driverId: 'u1',
      driverName: 'Alex',
      from: 'Vancouver',
      to: 'Whistler',
      date: DateTime(2025, 1, 18),
      time: TimeOfDay(hour: 20, minute: 0),
      availableSeats: 2,
      price: 500,
      imageUrl: 'assets/images/whistler.jpg',
    ),
  ];

  // Messages
  static final List<MessageModel> messages = [
    MessageModel(
      id: 'm1',
      senderId: 'u2',
      receiverId: 'u1',
      content: 'Hello',
      timestamp: DateTime(2025, 1, 10, 17, 30),
    ),
    MessageModel(
      id: 'm2',
      senderId: 'u2',
      receiverId: 'u1',
      content: 'I have reached the location. What color is your cab?',
      timestamp: DateTime(2025, 1, 10, 17, 31),
    ),
    MessageModel(
      id: 'm3',
      senderId: 'u1',
      receiverId: 'u2',
      content: 'Hey, I will be there in 2 mins.',
      timestamp: DateTime(2025, 1, 10, 17, 45),
    ),
    MessageModel(
      id: 'm4',
      senderId: 'u1',
      receiverId: 'u2',
      content: 'It\'s a White Toyota Prius.',
      timestamp: DateTime(2025, 1, 10, 17, 46),
    ),
  ];

  // Ride Requests
  static final List<RideRequestModel> rideRequests = [
    RideRequestModel(
      id: 'req1',
      rideId: 'r5',
      passengerId: 'u2',
      passengerName: 'John',
      passengerImage: 'assets/images/john.jpg',
      routeFrom: 'Vancouver',
      routeTo: 'Whistler',
      date: DateTime(2025, 1, 18),
      time: TimeOfDay(hour: 20, minute: 0),
    ),
    RideRequestModel(
      id: 'req2',
      rideId: 'r5',
      passengerId: 'u3',
      passengerName: 'Sam',
      passengerImage: 'assets/images/sam.jpg',
      routeFrom: 'Vancouver',
      routeTo: 'Whistler',
      date: DateTime(2025, 1, 18),
      time: TimeOfDay(hour: 20, minute: 0),
    ),
    RideRequestModel(
      id: 'req3',
      rideId: 'r5',
      passengerId: 'u4',
      passengerName: 'Andrew',
      passengerImage: 'assets/images/andrew.jpg',
      routeFrom: 'Vancouver',
      routeTo: 'Whistler',
      date: DateTime(2025, 1, 18),
      time: TimeOfDay(hour: 20, minute: 0),
    ),
    RideRequestModel(
      id: 'req4',
      rideId: 'r5',
      passengerId: 'u5',
      passengerName: 'Jim',
      passengerImage: 'assets/images/jim.jpg',
      routeFrom: 'Vancouver',
      routeTo: 'Whistler',
      date: DateTime(2025, 1, 18),
      time: TimeOfDay(hour: 20, minute: 0),
    ),
    RideRequestModel(
      id: 'req5',
      rideId: 'r5',
      passengerId: 'u6',
      passengerName: 'Ivan',
      passengerImage: 'assets/images/ivan.jpg',
      routeFrom: 'Vancouver',
      routeTo: 'Whistler',
      date: DateTime(2025, 1, 18),
      time: TimeOfDay(hour: 20, minute: 0),
    ),
  ];
}