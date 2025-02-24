import 'package:flutter/material.dart';

import 'package:pool_path/model/ride.dart';
import 'package:pool_path/themes/light_color.dart';
import 'package:pool_path/widgets/title_text.dart';
import 'package:pool_path/widgets/extentions.dart';

class ProductCard extends StatelessWidget {
  final Ride ride;
  final ValueChanged<Ride> onSelected;
  ProductCard({ Key? key, required this.ride, required this.onSelected}) : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   Product product;
//   @override
//   void initState() {
//     product = widget.product;
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: !ride.isSelected ? 20 : 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(
                  ride.isliked ? Icons.favorite : Icons.favorite_border,
                  color:
                  ride.isliked ? LightColor.red : LightColor.iconColor,
                ),
                onPressed: () {},
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: ride.isSelected ? 15 : 0),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: LightColor.orange.withAlpha(40),
                      ),
                      Image.asset(ride.image)
                    ],
                  ),
                ),
                // SizedBox(height: 5),
                TitleText(
                  text: ride.name,
                  fontSize: ride.isSelected ? 16 : 14, key: null,
                ),
                TitleText(
                  text: ride.event,
                  fontSize: ride.isSelected ? 14 : 12,
                  color: LightColor.orange, key: null,
                ),
                TitleText(
                  text: ride.price.toString(),
                  fontSize: ride.isSelected ? 18 : 16, key: null,
                ),
              ],
            ),
          ],
        ),
      ).ripple(() {
        Navigator.of(context).pushNamed('/detail');
        onSelected(ride);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
