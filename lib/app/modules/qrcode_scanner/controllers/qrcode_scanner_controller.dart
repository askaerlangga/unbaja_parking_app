import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodeScannerController extends GetxController {
  MobileScannerController cameraController = MobileScannerController();
  var scanCode = ''.obs;
}
