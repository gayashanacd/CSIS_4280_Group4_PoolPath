import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For HTTP requests
import '../constants/theme.dart';
import '../models/ride.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/ride_card.dart';
import '../providers/user_provider.dart';
import '../../util/util.dart'; // Assuming you have local_Ip

class UserRides extends StatefulWidget {
  const UserRides({Key? key}) : super(key: key);

  @override
  _UserRidesState createState() => _UserRidesState();
}

class _UserRidesState extends State<UserRides> {
  int _currentIndex = 0;
  List<Ride> _rides = []; // Store rides from backend

  @override
  void initState() {
    super.initState();
    _fetchRides(); // Fetch rides when the screen loads
  }

  Future<void> _fetchRides() async {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final response = await http.get(Uri.parse('http://$local_Ip:8081/api/rides/user/${user?.id}'));

    if (response.statusCode == 200) {
      // Decode the JSON response
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Map the JSON data to Ride objects
      setState(() {
        _rides = jsonList.map((json) => Ride.fromJson(json)).toList();
      });
    } else {
      // Handle error (e.g., show a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load rides: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('${user?.fullName}'),
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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: _rides.length, // Use _rides.length
                itemBuilder: (context, index) {
                  final ride = _rides[index]; // Use _rides[index]
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              Navigator.pushNamed(context, '/chat');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}

