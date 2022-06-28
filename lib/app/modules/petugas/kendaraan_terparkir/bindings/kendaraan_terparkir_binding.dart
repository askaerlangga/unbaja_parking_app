import 'package:get/get.dart';

import '../controllers/kendaraan_terparkir_controller.dart';

class KendaraanTerparkirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KendaraanTerparkirController>(
      () => KendaraanTerparkirController(),
    );
  }
}
