# group04_app

# PoolPath - Event-Based Ridesharing App

PoolPath is a Flutter-based mobile application that connects drivers and passengers for event-based ridesharing and carpooling.

## Features

### 1. Event-Based Ride Posting & Searching
- Drivers can post rides with details like departure location, time, and available seats
- Passengers can search for available rides to specific events
- Filter rides based on departure time, event location, and price

### 2. User Profiles and Ride Preferences
- User profiles with personal details and ride preferences
- Drivers can set preferences for their rides
- View driver profiles and reviews before booking

### 3. Ride Request and Confirmation System
- Passengers can request to join rides
- Drivers can accept or reject ride requests
- Ride confirmation notifications

### 4. In-App Chat for Ride Coordination
- Chat between drivers and passengers
- Send messages to coordinate pickup details
- Receive notifications for new messages

### 5. Ride History and Reviews
- Track past rides
- Rate and review drivers/passengers after rides
- Build a community of trusted users

## Project Structure

```
lib/
├── constants/
│   └── theme.dart        # App theme and colors
├── data/
│   └── dummy_data.dart   # Sample data for development
├── models/
│   ├── user.dart         # User data model
│   ├── ride.dart         # Ride data model
│   ├── message.dart      # Message data model
│   └── request.dart      # Ride request data model
├── screens/
│   ├── home_screen.dart             # Main rides listing
│   ├── ride_details_screen.dart     # Ride details view
│   ├── chat_screen.dart             # In-app messaging
│   ├── profile_screen.dart          # User profile
│   ├── post_ride_screen.dart        # Create new ride
│   ├── filter_rides_screen.dart     # Search & filter rides
│   ├── identity_verification_screen.dart # ID verification
│   └── auth/
│       ├── login_screen.dart        # User login
│       ├── signup_screen.dart       # User registration
│       └── welcome_screen.dart      # App welcome screen
├── widgets/
│   ├── bottom_nav_bar.dart          # Bottom navigation
│   ├── search_bar.dart              # Search component
│   └── ride_card.dart               # Ride card component
└── main.dart                        # App entry point
```

## Installation

1. Ensure you have Flutter installed and set up on your system
2. Clone this repository
3. Create an `assets/images` directory and add required images
4. Run `flutter pub get` to install dependencies
5. Run `flutter run` to start the app

## Assets Required

Create an `assets/images` directory and add the following images:
- victoria.jpg (or similar for destinations)
- whistler.jpg (or similar for destinations)
- mini_cooper.jpg (for vehicle example)
- logo.png (app logo)
- google_logo.png (Google sign-in)
- facebook_logo.png (Facebook sign-in)
- Profile images for sample users (alex.jpg, john.jpg, etc.)

## Future Improvements

- Firebase integration for authentication and real-time database
- Location services and maps integration
- Payment processing
- Push notifications
- Enhanced search algorithms
- Event discovery features