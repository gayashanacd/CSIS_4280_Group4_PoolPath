// lib/widgets/ride_card.dart
import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/ride.dart';
import 'package:intl/intl.dart';

class RideCard extends StatelessWidget {
  final RideModel ride;
  final Function()? onTap;

  const RideCard({
    Key? key,
    required this.ride,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.primaryMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: ride.imageUrl != null
                  ? Image.asset(
                ride.imageUrl!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ride.from}-${ride.to}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(Icons.person, ride.driverName),
                      _buildInfoItem(Icons.airline_seat_recline_normal, '${ride.availableSeats}'),
                      _buildInfoItem(Icons.attach_money, '${ride.price.toInt()}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        Icons.calendar_today,
                        DateFormat('MMM dd yyyy').format(ride.date),
                      ),
                      _buildInfoItem(
                        Icons.access_time,
                        '${ride.time.hour}:${ride.time.minute.toString().padLeft(2, '0')}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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