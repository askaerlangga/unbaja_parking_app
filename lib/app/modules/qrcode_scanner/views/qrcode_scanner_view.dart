import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/qrcode_scanner_controller.dart';

class QrcodeScannerView extends GetView<QrcodeScannerController> {
  const QrcodeScannerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var scanCode = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
            height: Get.height * 0.55,
            child: Stack(
              children: <Widget>[
                MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        final String code = barcode.rawValue!;
                        controller.scanCode.value = code;
                        debugPrint('Barcode found! $code');
                      }
                    }),
              ],
            )),
        Flexible(
            child: SizedBox(
                height: Get.height * 0.45,
                child: Center(
                  child: Obx(
                    () => Text('${controller.scanCode.value}'),
                  ),
                ))),
        // Container(
        //   height: Get.height * 0.3,
        //   color: Colors.blue,
        // ),
        // Stack(
        //   children: [
        //     SizedBox(
        //       height: Get.height * 0.3,
        //     ),
        //     Container(color: Colors.red),
        //   ],
        // )
        // SizedBox(
        //     height: Get.height * 0.7,
        //     child: Stack(
        //       children: [
        //
        //       ],
        //     )),
        // SizedBox(
        //   height: Get.height * 0.2,
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: [

        //       )
        //     ],
        //   ),
        // )
      ]),
    );
  }
}
