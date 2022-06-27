import 'package:get/get.dart';

import '../controllers/qrcode_scanner_controller.dart';

class QrcodeScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrcodeScannerController>(
      () => QrcodeScannerController(),
    );
  }
}
