import 'package:get/get.dart';

import '../controllers/riwayat_kendaraan_parkir_controller.dart';

class RiwayatKendaraanParkirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatKendaraanParkirController>(
      () => RiwayatKendaraanParkirController(),
    );
  }
}
