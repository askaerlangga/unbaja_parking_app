import 'package:get/get.dart';
import 'package:unbaja_parking_app/pages/home_page.dart';
import 'package:unbaja_parking_app/pages/login_page.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';

class PageNavigationRoute extends GetxController {
  static final pages = [
    GetPage(name: PageName.home, page: () => HomePage()),
    GetPage(name: PageName.login, page: () => LoginPage())
  ];
}
