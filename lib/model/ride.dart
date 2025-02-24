class Ride{
  int id;
  String name ;
  String event ;
  String image ;
  double price ;
  bool isliked ;
  bool isSelected ;
  Ride({required this.id,required this.name, required this.event, required this.price, required this.isliked,this.isSelected = false,required this.image});
}