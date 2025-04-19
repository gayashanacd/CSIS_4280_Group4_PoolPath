// lib/screens/ride_request_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../constants/theme.dart';
import '../models/ride.dart';
import '../providers/token_provider.dart';
import '../util/util.dart';
import '../widgets/bottom_nav_bar.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({Key? key}) : super(key: key);

  @override
  _RideRequestScreenState createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  bool _requestSuccess = false;
  int _currentIndex = 0;

  Future<void> _requestRide(Ride ride, String token) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _requestSuccess = false;
    });

    try {
      final response = await http.post(
        Uri.parse('http://$local_Ip:8081/api/rides/${ride.id}/requests'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        // You can add a body if needed for the request
        // body: json.encode({'seats': 1}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _requestSuccess = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to request ride: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Auto-request the ride when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Ride? ride = ModalRoute.of(context)?.settings.arguments as Ride?;
      final accessToken = Provider.of<TokenProvider>(context, listen: false).accessToken;

      if (ride != null && accessToken != null) {
        _requestRide(ride, accessToken);
      } else {
        setState(() {
          _errorMessage = 'Missing ride information or access token';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Ride? ride = ModalRoute.of(context)?.settings.arguments as Ride?;

    if (ride == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Ride details not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Reservation'),
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isLoading)
                Column(
                  children: [
                    const CircularProgressIndicator(color: AppColors.primaryDark),
                    const SizedBox(height: 20),
                    Text(
                      'Processing your request...',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              else if (_requestSuccess)
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ride Successfully Requested!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your ride request from ${ride.origin} to ${ride.destination} has been submitted successfully.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryMedium,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'From:',
                                style: TextStyle(
                                  color: AppColors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                ride.origin,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'To:',
                                style: TextStyle(
                                  color: AppColors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                ride.destination,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price:',
                                style: TextStyle(
                                  color: AppColors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '\$${ride.price.toInt()}',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else if (_errorMessage != null)
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Request Failed',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _errorMessage!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Back to Ride Details', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),
              if (!_isLoading && !_requestSuccess)
                ElevatedButton(
                  onPressed: () {
                    final accessToken = Provider.of<TokenProvider>(context, listen: false).accessToken;
                    if (accessToken != null) {
                      _requestRide(ride, accessToken);
                    } else {
                      setState(() {
                        _errorMessage = 'Missing access token';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Try Again', style: TextStyle(fontSize: 16)),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}