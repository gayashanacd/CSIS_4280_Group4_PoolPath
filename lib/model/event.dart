class Event{
  int id ;
  String name ;
  String image ;
  bool isSelected ;
  Event({required this.id,required this.name,this.isSelected = false,required this.image});
}