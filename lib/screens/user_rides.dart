import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For HTTP requests
import '../constants/theme.dart';
import '../models/ride.dart';
import '../providers/token_provider.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/ride_card.dart';
import '../providers/user_provider.dart';
import '../util/util.dart'; // Assuming you have local_Ip

class UserRides extends StatefulWidget {
  const UserRides({Key? key}) : super(key: key);

  @override
  _UserRidesState createState() => _UserRidesState();
}

class _UserRidesState extends State<UserRides> {
  int _currentIndex = 0;
  List<Ride> _rides = []; // Store rides from backend
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Delay the fetch to ensure the widget is fully built
    Future.delayed(Duration.zero, () {
      _fetchRides(); // Fetch rides when the screen loads
    });
  }

  Future<void> _fetchRides() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Get user data from UserProvider - using listen: false to avoid rebuild
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      final _accessTokenTemp = Provider.of<TokenProvider>(context, listen: false).accessToken;

      if (user == null) {
        setState(() {
          _errorMessage = 'User information not available';
          _isLoading = false;
        });
        return;
      }

      // Get the access token if needed
      // final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      // final token = tokenProvider.accessToken;

      final response = await http.get(
        Uri.parse('http://$local_Ip:8081/api/rides/user/${user.id}'),
        headers: {
        'Authorization': 'Bearer $_accessTokenTemp',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> jsonList = jsonDecode(response.body);
        // Map the JSON data to Ride objects
        setState(() {
          _rides = jsonList.map((json) => Ride.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        // Handle error (e.g., show a snackbar)
        setState(() {
          _errorMessage = 'Failed to load rides: ${response.statusCode}';
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load rides: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the user from the provider
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.fullName ?? 'Your Rides'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              showBackButton: false,
              onTap: () => Navigator.pushNamed(context, '/filter_rides'),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Your Rides',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_errorMessage != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading rides',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchRides,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            else if (_rides.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'No rides found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You haven\'t created any rides yet',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _fetchRides,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _rides.length,
                      itemBuilder: (context, index) {
                        final ride = _rides[index];
                        return RideCard(
                          ride: ride,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/ride_details',
                            arguments: ride,
                          ),
                        );
                      },
                    ),
                  ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
            // Your implementation for index 1
              break;
            case 2:
              Navigator.pushNamed(context, '/chat');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}