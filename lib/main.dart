import 'package:flutter/material.dart';
import 'constants/theme.dart';
import 'screens/home_screen.dart';
import 'screens/ride_details_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/post_ride_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/filter_rides_screen.dart';
import 'screens/identity_verification_screen.dart';

void main() {
  runApp(const PoolPathApp());
}

class PoolPathApp extends StatelessWidget {
  const PoolPathApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoolPath',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/ride_details': (context) => const RideDetailsScreen(),
        '/chat': (context) => const ChatScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/post_ride': (context) => const PostRideScreen(),
        '/filter_rides': (context) => const FilterRidesScreen(),
        '/identity_verification': (context) => const IdentityVerificationScreen(),
      },
    );
  }
}