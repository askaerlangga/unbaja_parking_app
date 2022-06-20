import 'package:get/get.dart';
import 'package:unbaja_parking_app/controllers/signup_page_controller.dart';

class SignUpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpPageController());
  }
}
