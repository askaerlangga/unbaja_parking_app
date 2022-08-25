import 'package:get/get.dart';

import '../controllers/data_kendaraan_controller.dart';

class DataKendaraanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataKendaraanController>(
      () => DataKendaraanController(),
    );
  }
}
