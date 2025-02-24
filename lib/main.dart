import 'package:flutter/material.dart';
import 'package:pool_path/config/route.dart';
import 'package:pool_path/pages/mainPage.dart';
import 'package:pool_path/pages/product_detail.dart';
import 'package:pool_path/widgets/customRoute.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pool_path/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoolPath',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => ProductDetailPage(), settings: null);
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => MainPage(key: null, title: '',), settings: null);
        }
      },
      initialRoute: "MainPage",
    );
  }
}
