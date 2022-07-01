import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/custom_textfield.dart';

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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextField(
            controller: controller.search,
            // enabled: enable,
            // keyboardType: keyboardType,
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            children: [
              Flexible(
                  child: Obx(
                () => SizedBox(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                          hint: Text('Filter'),
                          isExpanded: true,
                          value: controller.dropdownValue.value,
                          items: controller.dropdownItems
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? value) {
                            controller.dropdownValue.value = value!;
                            print(controller.dropdownValue);
                          }),
                    ),
                  ),
                ),
              )),
              const SizedBox(width: 20),
              Flexible(
                  child: SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  child: Text('Pilih tanggal'),
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030));
                  },
                ),
              )),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          if (controller.dropdownValue.value == 'Parkir' ||
              controller.dropdownValue.value == 'Masuk' ||
              controller.dropdownValue.value == 'Keluar') {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.getDataParkir(),
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
                            return StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: controller.getDataKendaraan(
                                    dataKendaraan['kendaraan']),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null &&
                                      snapshot.data?.data() != null) {
                                    var data = snapshot.data!.data()!;
                                    return GestureDetector(
                                      onTap: () => Get.toNamed(
                                          Routes.DETAIL_KENDARAAN_TERPARKIR),
                                      child: Card(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: SizedBox(
                                          height: 80,
                                          child: Row(children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Icon(
                                                  (data['jenis_kendaraan'] ==
                                                          'Sepeda Motor')
                                                      ? Icons.motorcycle
                                                      : Icons.directions_car,
                                                  color: Colors.white,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    data['nomor_plat'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    data['merek_kendaraan'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  (dataKendaraan['active'] == true &&
                                                          controller.dropdownValue.value ==
                                                              'Parkir')
                                                      ? const Text('PARKIR',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight: FontWeight
                                                                  .bold))
                                                      : (controller.dropdownValue.value == 'Masuk'
                                                          ? const Text('MASUK',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                          : const Text('KELUAR',
                                                              style: TextStyle(
                                                                  color: Colors.red,
                                                                  fontWeight: FontWeight.bold))),
                                                  Text(DateFormat.Hm().format(
                                                      DateTime.parse((((dataKendaraan[
                                                                      'active'] ||
                                                                  true &&
                                                                      controller
                                                                              .dropdownValue
                                                                              .value ==
                                                                          'Masuk')
                                                              ? dataKendaraan[
                                                                  'masuk']
                                                              : dataKendaraan[
                                                                  'keluar']) as Timestamp)
                                                          .toDate()
                                                          .toString())))
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    );
                                  }
                                  return Text('');
                                });
                          }),
                    );
                  }
                  return const Center(child: Text('Tidak ada kendaraan'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        })
      ]),
    );
  }
}
