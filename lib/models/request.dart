// lib/models/request.dart
import 'package:flutter/material.dart';

class RideRequestModel {
  final String id;
  final String rideId;
  final String passengerId;
  final String passengerName;
  final String? passengerImage;
  final String routeFrom;
  final String routeTo;
  final DateTime date;
  final TimeOfDay time;

  RideRequestModel({
    required this.id,
    required this.rideId,
    required this.passengerId,
    required this.passengerName,
    this.passengerImage,
    required this.routeFrom,
    required this.routeTo,
    required this.date,
    required this.time,
  });
}