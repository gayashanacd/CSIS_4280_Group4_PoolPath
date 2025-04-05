// lib/screens/ride_details_screen.dart
import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/ride.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({Key? key}) : super(key: key);

  @override
  _RideDetailsScreenState createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ride = ModalRoute.of(context)!.settings.arguments as RideModel;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    ride.imageUrl ?? 'assets/images/placeholder.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back, color: AppColors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.search, color: AppColors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ride.from}-${ride.to}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 16),
                  Text(
                    ride.description ?? 'No description provided.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryMedium,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoItem(Icons.calendar_today,
                            DateFormat('MMM dd yyyy').format(ride.date)),
                        _buildInfoItem(Icons.access_time,
                            '${ride.time.hour}:${ride.time.minute.toString().padLeft(2, '0')}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryMedium,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primaryDark,
                          child: Text(
                            ride.driverName[0],
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          ride.driverName,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.airline_seat_recline_normal,
                                color: AppColors.white),
                            SizedBox(width: 4),
                            Text(
                              '${ride.availableSeats}',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(Icons.attach_money, color: AppColors.white),
                            SizedBox(width: 4),
                            Text(
                              '${ride.price.toInt()}',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text('Reserve a seat'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/chat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text('Chat with Driver'),
                    ),
                  ),
                ],
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

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.white, size: 18),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}