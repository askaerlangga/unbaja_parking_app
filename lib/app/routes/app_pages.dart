import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/home/views/pengendara/pengaturan_profil_view.dart';

import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/admin/menu_data_pengguna_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pengendara/edit_data_pengendara/bindings/edit_data_pengendara_binding.dart';
import '../modules/pengendara/edit_data_pengendara/views/edit_data_pengendara_view.dart';
import '../modules/pengendara/kendaraan_saya/bindings/kendaraan_saya_binding.dart';
import '../modules/pengendara/kendaraan_saya/views/kendaraan_saya_view.dart';
import '../modules/pengendara/penampil_qrcode/bindings/penampil_qrcode_binding.dart';
import '../modules/pengendara/penampil_qrcode/views/penampil_qrcode_view.dart';
import '../modules/pengendara/tambah_edit_kendaraan/bindings/tambah_edit_kendaraan_binding.dart';
import '../modules/pengendara/tambah_edit_kendaraan/views/tambah_edit_kendaraan_view.dart';
import '../modules/pengendara/ubah_password_pengendara/bindings/ubah_password_pengendara_binding.dart';
import '../modules/pengendara/ubah_password_pengendara/views/ubah_password_pengendara_view.dart';
import '../modules/petugas/qrcode_scanner/bindings/qrcode_scanner_binding.dart';
import '../modules/petugas/qrcode_scanner/views/qrcode_scanner_view.dart';
import '../modules/petugas/qrcode_scanner/views/scanner_detail_pengendara_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.QRCODE_SCANNER,
      page: () => const QrcodeScannerView(),
      binding: QrcodeScannerBinding(),
    ),
    GetPage(
      name: _Paths.MENU_DATA_PENGGUNA,
      page: () => const MenuDataPenggunaView(),
    ),
    GetPage(
      name: _Paths.PENAMPIL_QRCODE,
      page: () => const PenampilQrcodeView(),
      binding: PenampilQrcodeBinding(),
    ),
    GetPage(
      name: _Paths.KENDARAAN_SAYA,
      page: () => const KendaraanSayaView(),
      binding: KendaraanSayaBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_EDIT_KENDARAAN,
      page: () => const TambahEditKendaraanView(),
      binding: TambahKendaraanBinding(),
    ),
    GetPage(
      name: _Paths.SCANNER_DETAIL_PENGENDARA,
      page: () => const ScannerDetailPengendaraView(),
      binding: QrcodeScannerBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_PASSWORD_PENGENDARA,
      page: () => const UbahPasswordPengendaraView(),
      binding: UbahPasswordPengendaraBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_DATA_PENGENDARA,
      page: () => const EditDataPengendaraView(),
      binding: EditDataPengendaraBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_PROFIL,
      page: () => const PengaturanProfilView(),
      binding: HomeBinding(),
    ),
  ];
}
