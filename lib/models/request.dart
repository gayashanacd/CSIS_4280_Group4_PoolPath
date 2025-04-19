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

class Request {
  final int id;
  final int rideId;
  final int rideUserId;
  final String status;
  final int requesterId;
  final String requesterName;
  final String message;
  final int seatsRequested;
  final String? createdAt;
  final String? updatedAt;

  Request({
    required this.id,
    required this.rideId,
    required this.rideUserId,
    required this.status,
    required this.requesterId,
    required this.requesterName,
    required this.message,
    required this.seatsRequested,
    this.createdAt,
    this.updatedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      rideId: json['rideId'],
      rideUserId: json['rideUserId'],
      status: json['status'] ?? 'PENDING',
      requesterId: json['requesterId'],
      requesterName: json['requesterName'] ?? 'Unknown',
      message: json['message'] ?? '',
      seatsRequested: json['seatsRequested'] ?? 1,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rideId': rideId,
      'rideUserId': rideUserId,
      'status': status,
      'requesterId': requesterId,
      'requesterName': requesterName,
      'message': message,
      'seatsRequested': seatsRequested,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Request copyWith({
    int? id,
    int? rideId,
    int? rideUserId,
    String? status,
    int? requesterId,
    String? requesterName,
    String? message,
    int? seatsRequested,
    String? createdAt,
    String? updatedAt,
  }) {
    return Request(
      id: id ?? this.id,
      rideId: rideId ?? this.rideId,
      rideUserId: rideUserId ?? this.rideUserId,
      status: status ?? this.status,
      requesterId: requesterId ?? this.requesterId,
      requesterName: requesterName ?? this.requesterName,
      message: message ?? this.message,
      seatsRequested: seatsRequested ?? this.seatsRequested,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}