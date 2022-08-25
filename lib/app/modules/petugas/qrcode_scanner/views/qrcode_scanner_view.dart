import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

import '../controllers/qrcode_scanner_controller.dart';

class QrcodeScannerView extends GetView<QrcodeScannerController> {
  const QrcodeScannerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        centerTitle: true,
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        MobileScanner(
            controller: controller.cameraController,
            allowDuplicates: true,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                Get.toNamed(Routes.SCANNER_DETAIL_PENGENDARA,
                    arguments: [code, Get.arguments]);
                debugPrint('Barcode found! $code');
                debugPrint('Nama Petugas ${Get.arguments}');
              }
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 60,
                width: 60,
                child: MaterialButton(
                  onPressed: () {
                    controller.cameraController.toggleTorch();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.blue,
                  child: ValueListenableBuilder(
                    valueListenable: controller.cameraController.torchState,
                    builder: (context, state, child) {
                      return ((state as TorchState) == TorchState.off)
                          ? const Icon(
                              Icons.flashlight_off,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.flashlight_on,
                              color: Colors.white,
                            );
                    },
                  ),
                )),
            SizedBox(height: 20),
            Flexible(
                child: Container(
              padding: EdgeInsets.all(20),
              height: 220,
              color: Colors.white,
              child: Column(
                children: [
                  const Text(
                    'Masukan Manual',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.nomorPlatController,
                    decoration: const InputDecoration(
                        labelText: 'Nomor Plat Kendaraan',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      label: 'PROSES',
                      onPressed: () {
                        controller.cariManual(Get.arguments);
                      })
                ],
              ),
            ))
          ],
        )
      ]),
    );
  }
}
