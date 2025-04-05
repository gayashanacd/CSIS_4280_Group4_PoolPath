import 'package:flutter/material.dart';
import '../../constants/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Image.asset(
              'assets/images/logo.png', // Use your actual logo
              width: 200,
              height: 100,
            ),
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Please select your role',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 60),
            Image.asset(
              'assets/images/logo.png', // Use your actual logo
              width: 150,
              height: 60,
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleButton(
                  context,
                  'User',
                      () => Navigator.pushNamed(context, '/login'),
                ),
                SizedBox(width: 20),
                _buildRoleButton(
                  context,
                  'Driver',
                      () => Navigator.pushNamed(context, '/login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Use your app logo
              width: 50,
              height: 30,
              color: AppColors.white,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}