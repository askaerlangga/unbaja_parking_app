import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';

import '../controllers/data_kendaraan_controller.dart';

class DataKendaraanView extends GetView<DataKendaraanController> {
  const DataKendaraanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Kendaraan'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                onEditingComplete: () {
                  controller.searchKeyword.value =
                      controller.searchController.text;
                },
                textCapitalization: TextCapitalization.characters,
                controller: controller.searchController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Masukan Nomor Plat Kendaraan',
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        controller.searchKeyword.value =
                            controller.searchController.text;
                      },
                    ),
                    labelText: 'Cari Kendaraan',
                    border: const OutlineInputBorder()),
              ),
            ),
            Obx(
              () => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: (controller.searchKeyword.value != null &&
                        controller.searchKeyword.value != '')
                    ? controller.searchListKendaraan()
                    : controller.getListKendaraan(),
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
                    var listPengendara = snapshot.data!.docs;
                    print('LIST $listPengendara');
                    return Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: listPengendara.length,
                          itemBuilder: (context, index) {
                            var dataPengendara = listPengendara[index];
                            return GestureDetector(
                              onTap: () => Get.toNamed(
                                  Routes.DATA_KENDARAAN_DETAIL,
                                  arguments:
                                      listPengendara[index].reference.id),
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
                                            '${dataPengendara['nomor_plat']}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${dataPengendara['merek_kendaraan']}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.navigate_next),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return const Center(
                    child: Text('Tidak ada data pengendara'),
                  );
                },
              ),
            )
          ],
        ));
  }
}
