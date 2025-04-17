import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:group04_app/models/user.dart';
import 'package:group04_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../../providers/token_provider.dart';
import '../../util/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //String local_Ip="192.168.1.166";

  bool _authenticated = false;
  String _error = "";
  String _teams = "";
  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  final String _clientId = "poolpath-ui";
  final String _clientSecret = "SuperSuperSecret";
  final String _redirectUrl = "com.wongi5.demo:/oauthredirect";
  final String _issuer = "http://$local_Ip:9000";
  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'poolpath:read',
    'poolpath:admin'
  ];

  String? _accessToken;
  String? _refreshToken;
  String? _idToken;

  bool _isBusy = false;
  bool _isLoading = false;

  final AuthorizationServiceConfiguration _serviceConfiguration =
  const AuthorizationServiceConfiguration(
      authorizationEndpoint: "http://$local_Ip:9000/oauth2/authorize",
      tokenEndpoint: "http://$local_Ip:9000/oauth2/token",
      endSessionEndpoint: "http://$local_Ip:9000/connect/logout");

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    try {
      //developer.log('Bearer $_accessToken');
      final _accessTokenTemp = Provider.of<TokenProvider>(context, listen: false).accessToken;
      final response = await http.post(
        Uri.parse('http://$local_Ip:8081/api/login'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $_accessTokenTemp',
          },
        body: jsonEncode({'username': email, 'password': password}),
      );
      developer.log('username' + email + 'password' + password);
      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        //Navigator.pushReplacementNamed(context, '/home');
        //return;
        if (response.body != null && response.body.isNotEmpty) { //check for empty body
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final user = User.fromJson(responseData);
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          //log('Login successful, but empty response body.', error: 'Empty response body');
          _showErrorDialog('Login successful, but server returned empty data.');
        }
      } else {
        print('Login failed. Status code: ${response.statusCode}, Body: ${response.body}');
        if (response.body != null && response.body.isNotEmpty) { //check for empty body before decoding
          try {
            final Map<String, dynamic> responseData = jsonDecode(response.body);
            final String message = responseData['message']?.toString().toLowerCase() ?? 'Login failed';

            if (message.contains('user') && message.contains('not')) {
              _showErrorDialog('User does not exist. Please check your email or sign up.');
            } else if (message.contains('password') && message.contains('wrong')) {
              _showErrorDialog('Incorrect password. Please try again.');
            } else {
              _showErrorDialog(responseData['message'] ?? 'Login failed. Please try again.');
            }
          } catch (e, stackTrace) {
            //log('Error during login, during json decode, or message access: $e', error: e, stackTrace: stackTrace);
            _showErrorDialog('Login failed. Please try again.');
          }
        } else {
          //log('Login failed, but server returned empty data.', error: 'Empty response body');
          _showErrorDialog('Login failed. Server returned empty data.');
        }
      }
    } catch (e, stackTrace) {
      setState(() => _isLoading = false);
      developer.log('Error during login: $e', error: e, stackTrace: stackTrace);
      _showErrorDialog('An unexpected error occurred: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),

                // Email
                Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  validator: (value) => value == null || !_isValidEmail(value)
                      ? 'Enter a valid email'
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 16),

                // Password
                Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter your password'
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: Text(
                        'Forgot?',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32),

                // Sign In Button
                ElevatedButton(
                  onPressed: () async  {
                    // In a real app, would validate and authenticate
                    await _signInWithAutoCodeExchange();
                    await _login();
                    //Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Sign Up Link
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Divider
                Row(children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ]),

                SizedBox(height: 24),

                // Social Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/google_logo.png',
                          width: 30, height: 30),
                      onPressed: () {
                        // Google login
                      },
                    ),
                    SizedBox(width: 24),
                    IconButton(
                      icon: Image.asset('assets/images/facebook_logo.png',
                          width: 30, height: 30),
                      onPressed: () {
                        // Facebook login
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleError(Object e) {
    setState(() {
      _error = "Error: $e";
    });
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    setState(() {
      _authenticated = true;
      _accessToken = response.accessToken;
      _refreshToken = response.refreshToken;
      _idToken = response.idToken;
    });

    // Share tokens globally using Provider
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    tokenProvider.setTokens(
      accessToken: response.accessToken ?? '',
      refreshToken: response.refreshToken,
      idToken: response.idToken,
    );
  }

  void _setBusyState() {
    setState(() {
      _error = "";
      _isBusy = true;
    });
  }

  void _clearBusyState() {
    setState(() {
      _isBusy = false;
    });
  }

  Future<void> _signInWithAutoCodeExchange(
      {ExternalUserAgent externalUserAgent =
          ExternalUserAgent.asWebAuthenticationSession}) async {
    try {
      _setBusyState();

      final AuthorizationTokenResponse result =
      await _appAuth.authorizeAndExchangeCode(AuthorizationTokenRequest(
          _clientId, _redirectUrl,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          externalUserAgent: externalUserAgent,
          allowInsecureConnections: true,
          issuer: _issuer,
          clientSecret: _clientSecret));

      _processAuthTokenResponse(result);
    } catch (e) {
      _handleError(e);
    } finally {
      _clearBusyState();
    }
  }
}