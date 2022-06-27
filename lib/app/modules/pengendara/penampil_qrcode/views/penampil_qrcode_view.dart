import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

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
        child: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getUserData(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = (snapshot.data!.data() as Map<String, dynamic>);
              print(data['kendaraan_utama']);
              if (data['kendaraan_utama'] != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: data['kendaraan_utama'],
                      version: QrVersions.auto,
                      size: 250,
                    ),
                    const Text(
                      'SCAN QR CODE INI',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Kamu belum mengisi data kendaraan, dan pastikan kamu sudah memilih kendaraan utama',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.KENDARAAN_SAYA,
                              arguments: Get.arguments);
                        },
                        child: const Text('Kendaraan Saya'))
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
