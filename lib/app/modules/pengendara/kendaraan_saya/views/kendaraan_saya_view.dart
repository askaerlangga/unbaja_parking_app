import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

import '../controllers/kendaraan_saya_controller.dart';

class KendaraanSayaView extends GetView<KendaraanSayaController> {
  const KendaraanSayaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.uid = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kendaraan Saya'),
        centerTitle: true,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getUserData(Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.data != null) {
                  var userData = snapshot.data?.data() as Map<String, dynamic>;
                  var listKendaraan = userData['kendaraan'];
                  if (listKendaraan != null) {
                    print(listKendaraan);
                    return ListView.builder(
                        itemCount: listKendaraan.length,
                        itemBuilder: (context, index) {
                          print('PRINT INI ${listKendaraan[index]}');
                          return FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              future: controller
                                  .getListKendaraan(listKendaraan[index]),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  var dataKendaraan = snapshot.data!.data()
                                      as Map<String, dynamic>;
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      height: 80,
                                      child: Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${dataKendaraan['nomor_plat']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${dataKendaraan['merek_kendaraan']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  title: 'Kendaraan Utama',
                                                  middleText:
                                                      'Jadikan kendaraan ini kendaraan utama?',
                                                  onCancel: () => Get.back(),
                                                  onConfirm: () {
                                                    controller
                                                        .setKendaraanUtama(
                                                            controller.uid,
                                                            listKendaraan[
                                                                index]);
                                                    Get.back();
                                                    Get.defaultDialog(
                                                        title:
                                                            'Berhasil Mengubah',
                                                        middleText:
                                                            'Kendaraan ini sekarang menjadi kendaraan utama');
                                                  });
                                            },
                                            icon:
                                                (userData['kendaraan_utama'] ==
                                                        listKendaraan[index])
                                                    ? Icon(Icons.star)
                                                    : Icon(Icons.star_border)),
                                        const SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {
                                              Get.toNamed(
                                                  Routes.TAMBAH_EDIT_KENDARAAN,
                                                  arguments: [
                                                    listKendaraan[index],
                                                    'Ubah Kendaraan',
                                                    dataKendaraan[
                                                        'jenis_kendaraan'],
                                                    dataKendaraan[
                                                        'merek_kendaraan'],
                                                    dataKendaraan['nomor_plat']
                                                  ]);
                                            },
                                            icon: Icon(Icons.edit)),
                                        const SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {
                                              controller.hapusKendaraan(
                                                  Get.arguments,
                                                  listKendaraan[index]);
                                            },
                                            icon: Icon(Icons.delete)),
                                      ]),
                                    ),
                                  );
                                }
                                return Text('');
                              });
                        });
                  }
                  return Center(
                    child: Text('Anda tidak memiliki kendaraan'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: CustomButton(
              label: 'Tambah Kendaraan',
              icon: Icons.add,
              onPressed: () {
                Get.toNamed(Routes.TAMBAH_EDIT_KENDARAAN,
                    arguments: [Get.arguments, 'Tambah Kendaraan']);
              }),
        ),
      ]),
    );
  }
}
