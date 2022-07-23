import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../widgets/custom_button.dart';
import '../controllers/laporan_controller.dart';

class LaporanView extends GetView<LaporanController> {
  const LaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cetak Laporan'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: controller.getDateRange(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  var firstDate =
                      snapshot.data?.docs.first.data()['keluar'] as Timestamp;

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomButton(
                        label: 'Pilih Bulan',
                        onPressed: () async {
                          DateTime? select = await showMonthPicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse(
                                  (firstDate).toDate().toString()),
                              lastDate: DateTime.now());
                          print(select);
                          if (select != null &&
                              select != controller.selectedMonth.value) {
                            controller.selectedMonth.value = select;
                          }
                          print(controller.selectedMonth.value);

                          controller.getListParkir().listen((event) async {
                            if (event.docs.isNotEmpty) {
                              int motor = 0;
                              int mobil = 0;
                              for (var list in event.docs) {
                                List data = [];
                                String petugasMasuk = '';
                                String petugasKeluar = '';
                                var jamMasuk =
                                    (list.data()['masuk'] as Timestamp)
                                        .toDate();
                                var jamKeluar =
                                    (list.data()['keluar'] as Timestamp)
                                        .toDate();

                                var durasi = jamKeluar
                                    .difference(jamMasuk)
                                    .toString()
                                    .split('.')[0]
                                    .split(':');
                                (list.data()['jenis_kendaraan'] ==
                                        'Sepeda Motor')
                                    ? motor++
                                    : mobil++;
                                data = [
                                  list.data()['nomor_plat'],
                                  list.data()['jenis_kendaraan'],
                                  list.data()['merek_kendaraan'],
                                  list.data()['nama_pengendara'],
                                  DateFormat('dd-MM-yyyy, HH:mm')
                                      .format(jamMasuk),
                                  list.data()['petugas_masuk'],
                                  DateFormat('dd-MM-yyyy, HH:mm')
                                      .format(jamKeluar),
                                  list.data()['petugas_keluar'],
                                  '${durasi[0]} Jam, ${durasi[1]} Menit'
                                ];
                                controller.tableDataRiwayatParkir.add(data);
                                print(list.data());
                              }
                              print(controller.tableDataRiwayatParkir);
                              final pdfFile =
                                  await controller.generate(motor, mobil);
                              controller.openFile(pdfFile);
                            } else {
                              Get.defaultDialog(middleText: 'Tidak ada data');
                            }

                            controller.tableDataRiwayatParkir.clear();
                          });
                        }),
                  );
                }
                return Text('data');
              }),
        ));
  }
}
