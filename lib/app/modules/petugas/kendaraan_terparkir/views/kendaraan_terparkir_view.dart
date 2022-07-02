import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/list_kendaraan_terparkir.dart';

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
              controller: controller.search,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  // prefixIcon: prefixIcon,
                  hintText: 'Masukan Nomor Plat',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                    ),
                    onPressed: () {},
                  ),
                  labelText: 'Cari Kendaraan',
                  border: const OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.getListKendaraanTerparkir(),
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
                          return ListKendaraanTerparkir(
                              streamDataKendaraan: controller
                                  .getDataKendaraan(dataKendaraan['kendaraan']),
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
          )
        ],
      ),
    );
  }
}
