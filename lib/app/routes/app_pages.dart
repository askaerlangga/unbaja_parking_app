import 'package:get/get.dart';

import '../modules/data_admin/bindings/data_admin_binding.dart';
import '../modules/data_admin/views/data_admin_detail_view.dart';
import '../modules/data_admin/views/data_admin_view.dart';
import '../modules/data_kendaraan/bindings/data_kendaraan_binding.dart';
import '../modules/data_kendaraan/views/data_kendaraan_view.dart';
import '../modules/data_pengendara/bindings/data_pengendara_binding.dart';
import '../modules/data_pengendara/views/data_pengendara_detail_view.dart';
import '../modules/data_pengendara/views/data_pengendara_view.dart';
import '../modules/data_petugas/bindings/data_petugas_binding.dart';
import '../modules/data_petugas/views/data_petugas_detail_view.dart';
import '../modules/data_petugas/views/data_petugas_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/admin/menu_data_pengguna_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/pengendara/pengaturan_profil_view.dart';
import '../modules/kendaraan_tamu/bindings/kendaraan_tamu_binding.dart';
import '../modules/kendaraan_tamu/views/kendaraan_tamu_keluar_detail_view.dart';
import '../modules/kendaraan_tamu/views/kendaraan_tamu_keluar_view.dart';
import '../modules/kendaraan_tamu/views/kendaraan_tamu_masuk_view.dart';
import '../modules/kendaraan_tamu/views/kendaraan_tamu_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
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
import '../modules/petugas/kendaraan_terparkir/bindings/kendaraan_terparkir_binding.dart';
import '../modules/petugas/kendaraan_terparkir/views/detail_kendaraan_terparkir_view.dart';
import '../modules/petugas/kendaraan_terparkir/views/kendaraan_terparkir_view.dart';
import '../modules/petugas/qrcode_scanner/bindings/qrcode_scanner_binding.dart';
import '../modules/petugas/qrcode_scanner/views/qrcode_scanner_view.dart';
import '../modules/petugas/qrcode_scanner/views/scanner_detail_pengendara_view.dart';
import '../modules/riwayat_kendaraan_parkir/bindings/riwayat_kendaraan_parkir_binding.dart';
import '../modules/riwayat_kendaraan_parkir/views/detail_riwayat_kendaraan_parkir_view.dart';
import '../modules/riwayat_kendaraan_parkir/views/riwayat_kendaraan_parkir_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/tambah_akun/bindings/tambah_akun_binding.dart';
import '../modules/tambah_akun/views/tambah_akun_view.dart';
import '../modules/ubah_data_pengguna/bindings/ubah_data_pengguna_binding.dart';
import '../modules/ubah_data_pengguna/views/ubah_data_pengguna_view.dart';

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
    GetPage(
      name: _Paths.KENDARAAN_TERPARKIR,
      page: () => const KendaraanTerparkirView(),
      binding: KendaraanTerparkirBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KENDARAAN_TERPARKIR,
      page: () => const DetailKendaraanTerparkirView(),
      binding: KendaraanTerparkirBinding(),
    ),
    GetPage(
      name: _Paths.KENDARAAN_TAMU,
      page: () => const KendaraanTamuView(),
      binding: KendaraanTamuBinding(),
    ),
    GetPage(
      name: _Paths.KENDARAAN_TAMU_MASUK,
      page: () => const KendaraanTamuMasukView(),
      binding: KendaraanTamuBinding(),
    ),
    GetPage(
      name: _Paths.KENDARAAN_TAMU_KELUAR,
      page: () => const KendaraanTamuKeluarView(),
      binding: KendaraanTamuBinding(),
    ),
    GetPage(
      name: _Paths.KENDARAAN_TAMU_KELUAR_DETAIL,
      page: () => const KendaraanTamuKeluarDetailView(),
      binding: KendaraanTamuBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_KENDARAAN_PARKIR,
      page: () => const RiwayatKendaraanParkirView(),
      binding: RiwayatKendaraanParkirBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RIWAYAT_KENDARAAN_PARKIR,
      page: () => const DetailRiwayatKendaraanParkirView(),
      binding: RiwayatKendaraanParkirBinding(),
    ),
    GetPage(
      name: _Paths.DATA_PENGENDARA,
      page: () => const DataPengendaraView(),
      binding: DataPengendaraBinding(),
    ),
    GetPage(
      name: _Paths.DATA_PENGENDARA_DETAIL,
      page: () => const DataPengendaraDetailView(),
      binding: DataPengendaraBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      page: () => const LaporanView(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_DATA_PENGGUNA,
      page: () => const UbahDataPenggunaView(),
      binding: UbahDataPenggunaBinding(),
    ),
    GetPage(
      name: _Paths.DATA_ADMIN,
      page: () => const DataAdminView(),
      binding: DataAdminBinding(),
    ),
    GetPage(
      name: _Paths.DATA_ADMIN_DETAIL,
      page: () => const DataAdminDetailView(),
      binding: DataAdminBinding(),
    ),
    GetPage(
      name: _Paths.DATA_PETUGAS,
      page: () => const DataPetugasView(),
      binding: DataPetugasBinding(),
    ),
    GetPage(
      name: _Paths.DATA_PETUGAS_DETAIL,
      page: () => const DataPetugasDetailView(),
      binding: DataPetugasBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_AKUN,
      page: () => const TambahAkunView(),
      binding: TambahAkunBinding(),
    ),
    GetPage(
      name: _Paths.DATA_KENDARAAN,
      page: () => const DataKendaraanView(),
      binding: DataKendaraanBinding(),
    ),
  ];
}
