import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
      body: Column(children: [
        SizedBox(
            height: Get.height * 0.55,
            child: Stack(
              children: <Widget>[
                MobileScanner(
                    controller: controller.cameraController,
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
                // Container(
                //   width: 100,
                //   height: 100,
                //   decoration:
                //       BoxDecoration(color: Color.fromARGB(20, 255, 255, 255)),
                // ),
                Align(
                  alignment: const Alignment(0, 0.9),
                  child: SizedBox(
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
                          valueListenable:
                              controller.cameraController.torchState,
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
                )
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
      ]),
    );
  }
}
