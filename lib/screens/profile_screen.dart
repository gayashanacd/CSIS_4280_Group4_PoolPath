import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/theme.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/bottom_nav_bar.dart';
import '../util/util.dart';
import 'post_ride_screen.dart'; // Import PostRideScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  Future<void> _updateUser(User user, {bool isPasswordChange = false}) async {
    final url = Uri.parse('http://$local_Ip:8081/api/users/${user.id}'); // Replace with your API URL
    try {
      final body = json.encode({
        'username': user.username,
        'password': user.password,
        'fullName': user.fullName,
        'phoneNumber': user.phoneNumber,
      });
      print('Request URL: $url');
      print('Request Body: $body');
      print('Is Password Change: $isPasswordChange'); // Debug for password


      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Update successful
        print('User updated successfully');
        // Optionally, update the user provider with the new data
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        // Update failed
        print('Failed to update user: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile. Please try again.')),
        );
      }
    } catch (error) {
      print('Error updating user: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while updating profile.')),
      );
    }
  }

  void _logout(BuildContext context) {
    // Clear the user data from the provider
    Provider.of<UserProvider>(context, listen: false).clearUser();

    // Navigate back to the login screen
    Navigator.pushReplacementNamed(context, '/login'); // Replace '/login' with your actual login route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
            children: [
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final user = userProvider.user;
                  if (user != null) {
                    return _buildProfileHeader(user);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              _buildEditProfileSection(),
              _buildRidesAndRequestsSection(),
              _buildLogoutSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index != 3) {
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

  Widget _buildProfileHeader(User user) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
          ),
          SizedBox(height: 10),
          Text(
            user.fullName,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Information'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showEditInformationDialog(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Forget Password'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showForgetPasswordDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRidesAndRequestsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rides & Requests',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text('Your Rides'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle your rides
                },
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text('Your Requests'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle your requests
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outline),
                title: Text('Host a Ride'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostRideScreen())); // Navigate to PostRideScreen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _logout(context);
            },
          ),
        ),
      ),
    );
  }

  void _showEditInformationDialog(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user!;

    String newFullName = user.fullName;
    String newUsername = user.username;
    String newPhoneNumber = user.phoneNumber;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildEditField(context, 'Full Name', user.fullName, (newValue) {
                  print('Editing Full Name: $newValue');
                  newFullName = newValue;
                }),
                _buildEditField(context, 'Username', user.username, (newValue) {
                  print('Editing Username: $newValue');
                  newUsername = newValue;
                }),
                _buildEditField(context, 'Phone Number', user.phoneNumber, (newValue) {
                  print('Editing Phone Number: $newValue');
                  newPhoneNumber = newValue;
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedUser = user.copyWith(
                  fullName: newFullName,
                  username: newUsername,
                  phoneNumber: newPhoneNumber,
                );
                _updateUser(updatedUser);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showForgetPasswordDialog(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user!;
    String newPassword = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your new password:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    newPassword = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {

                _updateUser(user.copyWith(password: newPassword), isPasswordChange: true);
                Navigator.pop(context);
              },
              child: Text('Reset Password'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditField(BuildContext context, String title, String currentValue, Function(String) onSave) {
    String newValue = currentValue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            initialValue: currentValue,
            onChanged: (value) {
              newValue = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}