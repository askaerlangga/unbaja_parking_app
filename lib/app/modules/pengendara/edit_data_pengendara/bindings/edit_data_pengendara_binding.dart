import 'package:get/get.dart';

import '../controllers/edit_data_pengendara_controller.dart';

class EditDataPengendaraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDataPengendaraController>(
      () => EditDataPengendaraController(),
    );
  }
}
