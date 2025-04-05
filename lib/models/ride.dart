import 'package:flutter/material.dart';

class RideModel {
  final String id;
  final String driverId;
  final String driverName;
  final String from;
  final String to;
  final DateTime date;
  final TimeOfDay time;
  final int availableSeats;
  final double price;
  final String? description;
  final String? imageUrl;

  RideModel({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.availableSeats,
    required this.price,
    this.description,
    this.imageUrl,
  });
}
