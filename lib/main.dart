import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unbaja_parking_app/pages/home_page.dart';
import 'package:unbaja_parking_app/routes/page_navigation_route.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: PageName.login,
      getPages: PageNavigationRoute.pages,
      home: HomePage(),
    );
  }
}
