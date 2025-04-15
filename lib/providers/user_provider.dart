import 'package:flutter/material.dart';
import '../models/user.dart'; // Import your User model

class UserProvider with ChangeNotifier {
  User? _user; // Use User (capital "U")

  User? get user => _user; // Use User (capital "U")

  void setUser(User user) { // Use User (capital "U")
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}