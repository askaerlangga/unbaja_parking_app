import 'package:get/get.dart';
import 'package:unbaja_parking_app/controllers/login_page_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginPageController());
  }
}
