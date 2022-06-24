import 'package:get/get.dart';

import '../controllers/tambah_edit_kendaraan_controller.dart';

class TambahKendaraanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahEditKendaraanController>(
      () => TambahEditKendaraanController(),
    );
  }
}
