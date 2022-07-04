import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/data_pengendara_controller.dart';

class DataPengendaraView extends GetView<DataPengendaraController> {
  const DataPengendaraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Pengendara'),
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
                    hintText: 'Masukan Nama Pengguna',
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        controller.searchKeyword.value =
                            controller.searchController.text;
                      },
                    ),
                    labelText: 'Cari Pengguna',
                    border: const OutlineInputBorder()),
              ),
            ),
            Obx(
              () => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: (controller.searchKeyword.value != null &&
                        controller.searchKeyword.value != '')
                    ? controller.searchListPengendara()
                    : controller.getListPengendara(),
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
                            return Card(
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
                                          '${dataPengendara['nama']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${dataPengendara['status']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  const Icon(Icons.navigate_next)
                                ]),
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
