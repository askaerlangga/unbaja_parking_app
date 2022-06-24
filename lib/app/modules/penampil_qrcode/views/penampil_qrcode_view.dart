import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/penampil_qrcode_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PenampilQrcodeView extends GetView<PenampilQrcodeController> {
  const PenampilQrcodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tampil QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: "1234567890",
              version: QrVersions.auto,
              size: 250,
            ),
            const Text(
              'SCAN QR CODE INI',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
