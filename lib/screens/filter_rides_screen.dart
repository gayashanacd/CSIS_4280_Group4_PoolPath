import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../data/dummy_data.dart';
import '../widgets/ride_card.dart';

class FilterRidesScreen extends StatefulWidget {
  const FilterRidesScreen({Key? key}) : super(key: key);

  @override
  _FilterRidesScreenState createState() => _FilterRidesScreenState();
}

class _FilterRidesScreenState extends State<FilterRidesScreen> {
  String? _selectedTime;
  bool _lessThan50 = false;
  bool _nearLocation = false;
  bool _tomorrow = false;
  bool _seat1 = false;
  bool _seat2 = false;
  bool _seat4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'search',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.mic, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.primaryMedium,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTimeButton('Now', isSelected: _selectedTime == 'Now'),
                      _buildTimeButton('2 pm', isSelected: _selectedTime == '2 pm'),
                      _buildTimeButton('2:30 pm', isSelected: _selectedTime == '2:30 pm'),
                      _buildTimeButton('4 pm', isSelected: _selectedTime == '4 pm'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCheckbox('Less than \$50', _lessThan50,
                                    (val) => setState(() => _lessThan50 = val!)),
                            _buildCheckbox('Near your location', _nearLocation,
                                    (val) => setState(() => _nearLocation = val!)),
                            _buildCheckbox('Tomorrow', _tomorrow,
                                    (val) => setState(() => _tomorrow = val!)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCheckbox('1 seat availability', _seat1,
                                    (val) => setState(() => _seat1 = val!)),
                            _buildCheckbox('2 seat availability', _seat2,
                                    (val) => setState(() => _seat2 = val!)),
                            _buildCheckbox('4 seat availability', _seat4,
                                    (val) => setState(() => _seat4 = val!)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: DummyData.rides.length,
                itemBuilder: (context, index) {
                  final ride = DummyData.rides[index];
                  return RideCard(
                    ride: ride,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/ride_details',
                      arguments: ride,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton(String text, {bool isSelected = false}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedTime = text;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.primaryDark : Colors.transparent,
        foregroundColor: AppColors.white,
        elevation: isSelected ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.primaryDark),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: AppColors.white,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryDark;
            }
            return AppColors.white;
          }),
        ),
        Text(label, style: TextStyle(color: AppColors.white)),
      ],
    );
  }
}
