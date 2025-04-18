// lib/widgets/ride_card.dart
import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/ride.dart'; // Use the Ride class we defined
import 'package:intl/intl.dart';

class RideCard extends StatelessWidget {
  final Ride ride; // Use Ride, not RideModel
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
              child:
              ride.imageName.isNotEmpty // Check if imageName is not empty
                  ? Image.network( // Use Image.network
                'https://cdn.pixabay.com/photo/2012/08/28/23/05/parliament-55231_1280.jpg', // Construct the full URL
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, object, stackTrace) { // Handle image loading errors
                  return Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  );
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )
                  : Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ride.origin}-${ride.destination}', // Use origin and destination
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(Icons.person, 'Driver'), // Replace with actual driver info
                      _buildInfoItem(Icons.airline_seat_recline_normal, '${ride.seatsAvailable}'), // Use seatsAvailable
                      _buildInfoItem(Icons.attach_money, '${ride.price.toInt()}'), // Use price
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        Icons.calendar_today,
                        DateFormat('MMM dd, yyyy').format(DateTime.parse(ride.datetime)), // Parse and format datetime
                      ),
                      _buildInfoItem(
                        Icons.access_time,
                        DateFormat('HH:mm').format(DateTime.parse(ride.datetime)), // Parse and format datetime
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
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}