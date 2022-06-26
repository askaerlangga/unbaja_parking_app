import 'package:get/get.dart';

import '../controllers/kendaraan_saya_controller.dart';

class KendaraanSayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KendaraanSayaController>(
      () => KendaraanSayaController(),
    );
  }
}
