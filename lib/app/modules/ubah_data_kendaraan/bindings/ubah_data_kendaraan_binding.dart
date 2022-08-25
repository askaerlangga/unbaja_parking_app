import 'package:get/get.dart';

import '../controllers/ubah_data_kendaraan_controller.dart';

class UbahDataKendaraanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahDataKendaraanController>(
      () => UbahDataKendaraanController(),
    );
  }
}
