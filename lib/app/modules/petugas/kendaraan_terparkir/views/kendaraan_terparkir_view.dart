import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

import '../controllers/kendaraan_terparkir_controller.dart';

class KendaraanTerparkirView extends GetView<KendaraanTerparkirController> {
  const KendaraanTerparkirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kendaraan Terparkir'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.getListKendaraanTerparkir(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data != null) {
              var listKendaraan = snapshot.data!.docs;
              print(listKendaraan);
              return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: listKendaraan.length,
                  itemBuilder: (context, index) {
                    var dataKendaraan = listKendaraan[index].data();
                    print('DATA KENDARAAN ${dataKendaraan}');
                    return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .getDataKendaraan(dataKendaraan['kendaraan']),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            var data = snapshot.data!.data()!;
                            return GestureDetector(
                              onTap: () => Get.toNamed(
                                  Routes.DETAIL_KENDARAAN_TERPARKIR),
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: 80,
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data['nomor_plat'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['merek_kendaraan'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                  ]),
                                ),
                              ),
                            );
                          }
                          return Text('');
                        });
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
