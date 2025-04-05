class UserModel {
  final String id;
  final String name;
  final String? profileImage;
  final String? email;
  final String? phone;
  final Map<String, dynamic>? preferences;
  final double? rating;
  final int? totalRides;

  UserModel({
    required this.id,
    required this.name,
    this.profileImage,
    this.email,
    this.phone,
    this.preferences,
    this.rating,
    this.totalRides,
  });
}