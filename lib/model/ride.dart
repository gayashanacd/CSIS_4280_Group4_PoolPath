class Ride{
  int id;
  String name ;
  String event ;
  String image ;
  double price ;
  bool isliked ;
  bool isSelected ;
  String fromLocation;
  String toLocation;
  Ride({required this.id,required this.name, required this.event, required this.price, required this.isliked,this.isSelected = false,required this.image, required this.fromLocation, required this.toLocation});
}