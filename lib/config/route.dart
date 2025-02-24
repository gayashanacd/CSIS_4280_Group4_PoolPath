import 'package:flutter/material.dart';
import 'package:pool_path/pages/mainPage.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(key: null, title: ''),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
