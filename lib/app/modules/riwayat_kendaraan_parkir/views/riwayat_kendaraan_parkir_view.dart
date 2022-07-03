import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/list_kendaraan_terparkir.dart';

import '../controllers/riwayat_kendaraan_parkir_controller.dart';

class RiwayatKendaraanParkirView
    extends GetView<RiwayatKendaraanParkirController> {
  const RiwayatKendaraanParkirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Parkir'),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
                label: 'Pilih Tanggal',
                onPressed: () async {
                  DateTime? select = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDay.value,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2023));
                  print(select);
                  if (select != null &&
                      select != controller.selectedDay.value) {
                    controller.selectedDay.value = select;
                  }
                  print(controller.selectedDay.value);
                }),
          ),
          Obx(() => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: (controller.searchKeyword.value != null &&
                        controller.searchKeyword.value != '')
                    ? controller.searchParkir()
                    : controller.getListParkir(),
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
                                  streamDataKendaraan:
                                      controller.getDataKendaraan(
                                          dataKendaraan['kendaraan']),
                                  keteranganParkir: 'keluar',
                                  dataWaktu: dataKendaraan['keluar'],
                                  keteranganParkirColor: Colors.red);
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
