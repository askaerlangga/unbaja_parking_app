import 'package:get/get.dart';

import '../controllers/penampil_qrcode_controller.dart';

class PenampilQrcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PenampilQrcodeController>(
      () => PenampilQrcodeController(),
    );
  }
}
