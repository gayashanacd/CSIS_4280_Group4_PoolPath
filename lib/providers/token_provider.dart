// lib/providers/token_provider.dart
import 'package:flutter/material.dart';

class TokenProvider with ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  String? _idToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get idToken => _idToken;

  void setTokens({
    required String accessToken,
    String? refreshToken,
    String? idToken,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _idToken = idToken;
    notifyListeners();
  }

  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
    _idToken = null;
    notifyListeners();
  }
}
