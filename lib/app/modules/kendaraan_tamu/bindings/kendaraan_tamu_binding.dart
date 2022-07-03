import 'package:get/get.dart';

import '../controllers/kendaraan_tamu_controller.dart';

class KendaraanTamuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KendaraanTamuController>(
      () => KendaraanTamuController(),
    );
  }
}
