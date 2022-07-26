import 'package:get/get.dart';

import '../controllers/tambah_akun_controller.dart';

class TambahAkunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahAkunController>(
      () => TambahAkunController(),
    );
  }
}
