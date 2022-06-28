import 'package:get/get.dart';

import '../controllers/ubah_password_pengendara_controller.dart';

class UbahPasswordPengendaraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahPasswordPengendaraController>(
      () => UbahPasswordPengendaraController(),
    );
  }
}
