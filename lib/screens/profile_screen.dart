// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../data/dummy_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/request.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // Profile tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: AppColors.primaryMedium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Requests',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: DummyData.rideRequests.length,
                      itemBuilder: (context, index) {
                        final request = DummyData.rideRequests[index];
                        return _buildRequestCard(request);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Rides',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildYourRideCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index != 3) { // If not profile tab
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/chat');
            }
          }
        },
      ),
    );
  }

  Widget _buildRequestCard(RideRequestModel request) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: request.passengerImage != null
                ? AssetImage(request.passengerImage!)
                : null,
            backgroundColor: AppColors.gray,
            child: request.passengerImage == null
                ? Text(request.passengerName[0])
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.passengerName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Can i join you for you next ride ?',
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: AppColors.white),
                    SizedBox(width: 4),
                    Text(
                      '18th Jan 25 8:00pm',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.location_on, size: 14, color: AppColors.white),
                    SizedBox(width: 4),
                    Text(
                      '${request.routeFrom} - ${request.routeTo}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
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

  Widget _buildYourRideCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/images/mini_cooper.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mini Cooper',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16, color: AppColors.white),
                    SizedBox(width: 4),
                    Text(
                      '500',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: AppColors.white),
                    SizedBox(width: 4),
                    Text(
                      'Vancouver - Whistler',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: AppColors.white),
                    SizedBox(width: 4),
                    Text(
                      '18th Jan 25 8:00pm',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryMedium,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'EDIT',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}