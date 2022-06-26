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
                  var listKendaraan = (snapshot.data?.data()
                      as Map<String, dynamic>)['kendaraan'];
                  if (listKendaraan != null) {
                    print(listKendaraan);
                    return ListView.builder(
                        itemCount: listKendaraan.length,
                        itemBuilder: (context, index) {
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
                                            onPressed: () {},
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
                    arguments: Get.arguments);
              }),
        ),
      ]),
    );
  }
}
