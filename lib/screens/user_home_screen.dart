import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../data/dummy_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/ride_card.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: AppColors.primaryLight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hi, James',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Upcoming Events',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              color: AppColors.primaryMedium,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEventCategory(Icons.music_note, 'Concert'),
                  _buildEventCategory(Icons.landscape, 'Trek'),
                  _buildEventCategory(Icons.restaurant, 'Food Festival'),
                  _buildEventCategory(Icons.museum, 'Museums'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Available Rides',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 3, // Show only first 3 rides
                itemBuilder: (context, index) {
                  final ride = DummyData.rides[index];
                  return _buildCompactRideCard(ride);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/post_ride'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMedium,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Post A Ride', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 8),
                    Icon(Icons.directions_car),
                  ],
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
        },
      ),
    );
  }

  Widget _buildEventCategory(IconData icon, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.gray,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryDark),
        ),
        SizedBox(height: 4),
        Text(name, style: TextStyle(color: AppColors.white)),
      ],
    );
  }

  Widget _buildCompactRideCard(ride) {
    return Card(
      color: AppColors.primaryMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              ride.imageUrl ?? 'assets/images/placeholder.jpg',
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: AppColors.white, size: 16),
                    SizedBox(width: 4),
                    Text(ride.driverName,
                      style: TextStyle(color: AppColors.white, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text('${ride.from}-${ride.to}',
                  style: TextStyle(color: AppColors.white, fontSize: 12),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.airline_seat_recline_normal, color: AppColors.white, size: 16),
                        SizedBox(width: 4),
                        Text('${ride.availableSeats}',
                          style: TextStyle(color: AppColors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: AppColors.white, size: 16),
                        SizedBox(width: 4),
                        Text('${ride.price.toInt()}',
                          style: TextStyle(color: AppColors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}