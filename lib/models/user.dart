import 'dart:convert';
import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final String password;
  final String fullName;
  final String phoneNumber;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? fullName,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}