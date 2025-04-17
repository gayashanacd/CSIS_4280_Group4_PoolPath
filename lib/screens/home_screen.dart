import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../constants/theme.dart';
import '../data/dummy_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/ride_card.dart';
import '../providers/user_provider.dart'; // Import UserProvider

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Access the user data using Provider
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user; // Get the user object

    return Scaffold(
      appBar: AppBar(
        title: Text(user != null ? 'Welcome, ${user.fullName}' : 'Welcome'), // Display user's name
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
                'Available Rides',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: DummyData.rides.length,
                itemBuilder: (context, index) {
                  final ride = DummyData.rides[index];
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
            case 0: // Home already active
              break;
            case 1: // Map/Location
            // Navigate to map screen if needed
              break;
            case 2: // Chat
              Navigator.pushNamed(context, '/chat');
              break;
            case 3: // Profile
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}