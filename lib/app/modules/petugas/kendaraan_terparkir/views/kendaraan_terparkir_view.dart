import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/list_kendaraan_terparkir.dart';
import 'package:unbaja_parking_app/app/widgets/list_kendaraan_terparkir_tamu.dart';

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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  // prefixIcon: prefixIcon,
                  hintText: 'Masukan Nomor Plat',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                      controller.searchKeyword.value =
                          controller.searchController.text.toUpperCase();
                    },
                  ),
                  labelText: 'Cari Kendaraan',
                  border: const OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: (controller.searchKeyword.value != null &&
                        controller.searchKeyword.value != '')
                    ? controller.searchKendaraanTerparkir()
                    : controller.getListKendaraanTerparkir(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.data != null) {
                    var listKendaraan = snapshot.data!.docs;
                    print('LIST $listKendaraan');
                    if (listKendaraan.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            itemCount: listKendaraan.length,
                            itemBuilder: (context, index) {
                              var dataKendaraan = listKendaraan[index].data();
                              print('DATA KENDARAAN ${dataKendaraan}');
                              if (dataKendaraan['kendaraan'] == null) {
                                return ListKendaraanTerparkirTamu(
                                    onTap: () => Get.toNamed(
                                            Routes.DETAIL_KENDARAAN_TERPARKIR,
                                            arguments: [
                                              listKendaraan[index].reference.id
                                            ]),
                                    keteranganParkir: 'masuk',
                                    dataWaktu: dataKendaraan['masuk'],
                                    keteranganParkirColor: Colors.green,
                                    jenisKendaraan:
                                        dataKendaraan['jenis_kendaraan'],
                                    nomorPlat: dataKendaraan['nomor_plat'],
                                    merekKendaraan: dataKendaraan['merek']);
                              }
                              return ListKendaraanTerparkir(
                                  onTap: () => Get.toNamed(
                                          Routes.DETAIL_KENDARAAN_TERPARKIR,
                                          arguments: [
                                            listKendaraan[index].reference.id,
                                            dataKendaraan['kendaraan'],
                                            dataKendaraan['pengendara'],
                                          ]),
                                  streamDataKendaraan:
                                      controller.getDataKendaraan(
                                          dataKendaraan['kendaraan']),
                                  keteranganParkir: 'masuk',
                                  dataWaktu: dataKendaraan['masuk'],
                                  keteranganParkirColor: Colors.green);
                            }),
                      );
                    }
                    return const Center(child: Text('Tidak ada kendaraan'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ))
        ],
      ),
    );
  }
}
