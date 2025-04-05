// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../data/dummy_data.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentIndex = 2; // Chat tab selected
  final TextEditingController _messageController = TextEditingController();
  final String currentUserId = 'u2'; // Simulating logged in user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.black,
              child: Text('SL', style: TextStyle(color: AppColors.white)),
            ),
            SizedBox(width: 12),
            Text('Alex'),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(16),
              itemCount: DummyData.messages.length,
              itemBuilder: (context, index) {
                final message = DummyData.messages[DummyData.messages.length - 1 - index];
                final isMe = message.senderId == currentUserId;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: isMe ? 64 : 0,
                      right: isMe ? 0 : 64,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.white : AppColors.primaryMedium,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.content,
                          style: TextStyle(
                            color: isMe ? AppColors.black : AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          DateFormat('h:mm a').format(message.timestamp),
                          style: TextStyle(
                            color: isMe
                                ? AppColors.black.withOpacity(0.6)
                                : AppColors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 70,
            color: AppColors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // In a real app, this would send the message
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index != 2) { // If not chat tab
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}