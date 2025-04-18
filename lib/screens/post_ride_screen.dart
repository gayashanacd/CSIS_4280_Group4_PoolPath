import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../util/util.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class PostRideScreen extends StatefulWidget {
  const PostRideScreen({Key? key}) : super(key: key);

  @override
  _PostRideScreenState createState() => _PostRideScreenState();
}

class _PostRideScreenState extends State<PostRideScreen> {
  int _currentIndex = 1;
  File? _image;
  final _picker = ImagePicker();
  final originController = TextEditingController();
  final destinationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final priceController = TextEditingController();
  final seatsController = TextEditingController();
  final originAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = ''; // Initialize as empty
    timeController.text = ''; // Initialize as empty
  }

  Future<void> getImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image.')),
      );
    }
  }

  Future<void> _postRide() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
      return;
    }

    try {
      final uri = Uri.parse("http://$local_Ip:8081/api/rides/image");
      var request = http.MultipartRequest('POST', uri);
      request.fields['origin'] = originController.text;
      request.fields['destination'] = destinationController.text;
      request.fields['date'] = dateController.text; // Use the controller's text
      request.fields['time'] = timeController.text; // Use the controller's text
      request.fields['price'] = priceController.text;
      request.fields['seats'] = seatsController.text;

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      request.fields['userId'] = user!.id.toString();

      request.fields['originAddress'] = originAddressController.text;
      request.fields['destinationAddress'] = destinationAddressController.text;

      // request.files.add(
      //   await http.MultipartFile.fromPath(
      //     'image',
      //     _image!.path,
      //     contentType: MediaType('image', 'jpeg'),
      //   ),
      // );

      print('Sending request with:');
      print('Origin: ${request.fields['origin']}');
      print('Destination: ${request.fields['destination']}');
      print('Date: ${request.fields['date']}');
      print('Time: ${request.fields['time']}');
      print('Price: ${request.fields['price']}');
      print('Seats: ${request.fields['seats']}');
      print('UserId: ${request.fields['userId']}');
      print('Origin Address: ${request.fields['originAddress']}');
      print('Destination Address: ${request.fields['destinationAddress']}');

      var response = await request.send();

      if (response.statusCode == 201) {
        print('Ride posted successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride posted successfully!')),
        );
        Navigator.pop(context);
      } else {
        print('Failed to post ride: ${response.statusCode}');
        final responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to post ride.')),
        );
      }
    } catch (e) {
      print('Error during ride posting: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while posting the ride.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Ride'),
        backgroundColor: AppColors.primaryDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'From',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: originController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Starting location',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Origin Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: originAddressController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Origin address',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'To',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: destinationController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Destination',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Destination Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: destinationAddressController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Destination address',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Image',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: _image == null
                    ? TextButton(
                  onPressed: getImage,
                  child: const Text(
                    'Browse',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 16,
                    ),
                  ),
                )
                    : Image.file(_image!),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Date',
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String month = pickedDate.month.toString().padLeft(2, '0');
                  String day = pickedDate.day.toString().padLeft(2, '0');
                  dateController.text = "${pickedDate.year}-$month-$day";
                }
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Time',
                suffixIcon: const Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  String hour = pickedTime.hour.toString().padLeft(2, '0');
                  String minute = pickedTime.minute.toString().padLeft(2, '0');
                  timeController.text = "$hour:$minute";
                }
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Price',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Price per seat',
                prefixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text(
              'Available Seats',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: seatsController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Number of seats',
                prefixIcon: const Icon(Icons.airline_seat_recline_normal),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _postRide,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Post Ride'),
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
}