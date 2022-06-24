import 'package:cloud_firestore/cloud_firestore.dart';
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
            FutureBuilder<DocumentSnapshot<Object?>>(
              future: controller.getUserData(Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var data = (snapshot.data!.data() as Map<String, dynamic>);
                  print(data['kendaraan_utama']);
                  return QrImage(
                    data: data['kendaraan_utama'],
                    version: QrVersions.auto,
                    size: 250,
                  );
                }
                return const CircularProgressIndicator();
              },
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
