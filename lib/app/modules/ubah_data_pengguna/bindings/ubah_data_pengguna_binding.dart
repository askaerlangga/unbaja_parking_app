import 'package:get/get.dart';

import '../controllers/ubah_data_pengguna_controller.dart';

class UbahDataPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahDataPenggunaController>(
      () => UbahDataPenggunaController(),
    );
  }
}
