import 'package:get/get.dart';
import 'package:unbaja_parking_app/bindings/login_page_binding.dart';
import 'package:unbaja_parking_app/bindings/signup_page_binding.dart';
import 'package:unbaja_parking_app/pages/home_page.dart';
import 'package:unbaja_parking_app/pages/login_page.dart';
import 'package:unbaja_parking_app/pages/signup_page.dart';
import 'package:unbaja_parking_app/routes/page_name.dart';

class PageNavigationRoute extends GetxController {
  static final pages = [
    GetPage(name: PageName.home, page: () => HomePage()),
    GetPage(
        name: PageName.login,
        page: () => LoginPage(),
        binding: LoginPageBinding()),
    GetPage(
        name: PageName.signup,
        page: () => SignUpPage(),
        transition: Transition.rightToLeft,
        binding: SignUpPageBinding())
  ];
}
