class Ride {
  final int id;
  final String origin;
  final String originAddress;
  final String destination;
  final String destinationAddress;
  final int seatsAvailable;
  final int seatsCapacity;
  final String phoneNumber;
  final String datetime; // Keep as String for ISO 8601 format
  final int userId;
  final String createdDateTime; // Keep as String for now
  final double price;
  final String imageName;
  final bool full;

  Ride({
    required this.id,
    required this.origin,
    required this.originAddress,
    required this.destination,
    required this.destinationAddress,
    required this.seatsAvailable,
    required this.seatsCapacity,
    required this.phoneNumber,
    required this.datetime,
    required this.userId,
    required this.createdDateTime,
    required this.price,
    required this.imageName,
    required this.full,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] as int,
      origin: json['origin'] as String,
      originAddress: json['originAddress'] as String,
      destination: json['destination'] as String,
      destinationAddress: json['destinationAddress'] as String,
      seatsAvailable: json['seatsAvailable'] as int,
      seatsCapacity: json['seatsCapacity'] as int,
      phoneNumber: json['phoneNumber'] as String,
      datetime: json['datetime'] as String,
      userId: json['userId'] as int,
      createdDateTime: json['createdDateTime'] as String,
      price: (json['price'] as num).toDouble(), // Safe double conversion
      imageName: "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
      full: json['full'] as bool,
    );
  }
}