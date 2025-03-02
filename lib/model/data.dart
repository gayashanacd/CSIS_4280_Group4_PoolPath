import 'package:pool_path/model/event.dart';
import 'package:pool_path/model/ride.dart';

class AppData {
  static List<Ride> rideList = [
    Ride(
        id: 1,
        name: 'To Douglas College',
        price: 10.00,
        isSelected: true,
        isliked: false,
        image: 'assets/car_carpooling.jpg',
        event: "Max",
        fromLocation: 'Sapperton',
        toLocation: 'Douglas College, New Westminster'),
    Ride(
        id: 2,
        name: 'Party 1',
        price: 8.00,
        isliked: false,
        image: 'assets/event_scene.jpg',
        event: "jane",
        fromLocation: 'Sapperton',
        toLocation: 'Douglas College, New Westminster'),
  ];
  static List<Ride> cartList = [
    Ride(
        id: 1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/small_tilt_shoe_1.png',
        event: "Trending Now",
        fromLocation: 'Sapperton',
        toLocation: 'Douglas College, New Westminster'),
    Ride(
        id: 2,
        name: 'Nike Air Max 97',
        price: 190.00,
        isliked: false,
        image: 'assets/small_tilt_shoe_2.png',
        event: "Trending Now",
        fromLocation: 'Sapperton',
        toLocation: 'Douglas College, New Westminster'),
    Ride(
        id: 1,
        name: 'Nike Air Max 92607',
        price: 220.00,
        isliked: false,
        image: 'assets/small_tilt_shoe_3.png',
        event: "Trending Now",
        fromLocation: 'Sapperton',
        toLocation: 'Douglas College, New Westminster'),
    Ride(
        id: 2,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/small_tilt_shoe_1.png',
        event: "Trending Now",
        fromLocation: 'Sapperton',
        toLocation: 'Douglas College, New Westminster'),
  ];
  static List<Event> eventList = [
    Event(
        id: 1,
        name: "AfroJacK - DJ Mag",
        image: 'assets/afrojack.png',
        isSelected: true),
    Event(id: 2, name: "Up the Creek Run", image: 'assets/up_the_creek.png'),
    Event(id: 3, name: "ACDC Concert", image: 'assets/acdc.png')
  ];
  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];
  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
