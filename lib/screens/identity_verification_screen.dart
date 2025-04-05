import 'package:flutter/material.dart';
import '../constants/theme.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Identity Confirmation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              SizedBox(height: 24),
              LinearProgressIndicator(
                value: 0.33, // 1 of 3 steps
                backgroundColor: AppColors.primaryMedium,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
                minHeight: 10,
              ),
              SizedBox(height: 40),
              Text(
                'Step 1 of 3: Upload clean and readable photo of front side of your government issued Driver License.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Image.asset(
                'assets/images/logo.png', // Use your actual logo
                width: 100,
                height: 50,
              ),
              SizedBox(height: 50),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryDark,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primaryMedium,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text('Go Back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Next step
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}