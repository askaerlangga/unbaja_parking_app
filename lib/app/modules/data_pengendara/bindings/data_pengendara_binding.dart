import 'package:get/get.dart';

import '../controllers/data_pengendara_controller.dart';

class DataPengendaraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataPengendaraController>(
      () => DataPengendaraController(),
    );
  }
}
