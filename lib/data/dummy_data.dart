import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/ride.dart';
import '../models/message.dart';
import '../models/request.dart';

class DummyData {
  // Users
  static List<User> users = [
    User(
      id: 1,
      username: 'alex@example.com',
      password: 'password123',
      fullName: 'Alex Smith',
      phoneNumber: '+1234567890',
    ),
    User(
      id: 2,
      username: 'john@example.com',
      password: 'password456',
      fullName: 'John Doe',
      phoneNumber: '+1987654321',
    ),
    User(
      id: 3,
      username: 'sam@example.com',
      password: 'password789',
      fullName: 'Sam Johnson',
      phoneNumber: '+1122334455',
    ),
    User(
      id: 4,
      username: 'andrew@example.com',
      password: 'passwordabc',
      fullName: 'Andrew Williams',
      phoneNumber: '+1555666777',
    ),
    User(
      id: 5,
      username: 'jim@example.com',
      password: 'passworddef',
      fullName: 'Jim Brown',
      phoneNumber: '+1444555666',
    ),
    User(
      id: 6,
      username: 'ivan@example.com',
      password: 'passwordghi',
      fullName: 'Ivan Davis',
      phoneNumber: '+1777888999',
    ),
  ];



  static final List<Ride> rides = [
    Ride(
      id: 1, // Replace with appropriate IDs
      userId: 1, // Replace with appropriate user IDs (driverId)
      origin: 'Vancouver', // from
      destination: 'Victoria', // to
      originAddress: 'Vancouver', // Placeholder - you might need a different value
      destinationAddress: 'Victoria', // Placeholder
      datetime: DateTime(2025, 1, 31, 8, 30).toIso8601String(), // date and time combined
      seatsAvailable: 2,
      seatsCapacity: 2,
      price: 250.0,
      phoneNumber: '1234', // Placeholder
      imageName: 'victoria.jpg', // imageUrl (without 'assets/images/')
      full: false,
      createdDateTime: DateTime.now().toIso8601String(), // Placeholder
    ),
    Ride(
      id: 2,
      userId: 2,
      origin: 'Vancouver',
      destination: 'Victoria',
      originAddress: 'Vancouver',
      destinationAddress: 'Victoria',
      datetime: DateTime(2025, 1, 31, 8, 30).toIso8601String(),
      seatsAvailable: 3,
      seatsCapacity: 3,
      price: 250.0,
      phoneNumber: '1234',
      imageName: 'victoria.jpg',
      full: false,
      createdDateTime: DateTime.now().toIso8601String(),
    ),
    Ride(
      id: 3,
      userId: 3,
      origin: 'Vancouver',
      destination: 'Victoria',
      originAddress: 'Vancouver',
      destinationAddress: 'Victoria',
      datetime: DateTime(2025, 1, 31, 8, 30).toIso8601String(),
      seatsAvailable: 4,
      seatsCapacity: 4,
      price: 250.0,
      phoneNumber: '1234',
      imageName: 'victoria.jpg',
      full: false,
      createdDateTime: DateTime.now().toIso8601String(),
    ),
    Ride(
      id: 4,
      userId: 4,
      origin: 'Vancouver',
      destination: 'Victoria',
      originAddress: 'Vancouver',
      destinationAddress: 'Victoria',
      datetime: DateTime(2025, 1, 31, 8, 30).toIso8601String(),
      seatsAvailable: 2,
      seatsCapacity: 2,
      price: 250.0,
      phoneNumber: '1234',
      imageName: 'victoria.jpg',
      full: false,
      createdDateTime: DateTime.now().toIso8601String(),
    ),
    Ride(
      id: 5,
      userId: 1,
      origin: 'Vancouver',
      destination: 'Whistler',
      originAddress: 'Vancouver',
      destinationAddress: 'Whistler',
      datetime: DateTime(2025, 1, 18, 20, 0).toIso8601String(),
      seatsAvailable: 2,
      seatsCapacity: 2,
      price: 500.0,
      phoneNumber: '1234',
      imageName: 'whistler.jpg',
      full: false,
      createdDateTime: DateTime.now().toIso8601String(),
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