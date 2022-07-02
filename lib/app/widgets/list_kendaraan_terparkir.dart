import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListKendaraanTerparkir extends StatelessWidget {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> streamDataKendaraan;
  final void Function()? onTap;

  /// isi dengan : `parkir`,`masuk`, atau `keluar`
  final String keteranganParkir;
  final Timestamp dataWaktu;
  final Color keteranganParkirColor;

  const ListKendaraanTerparkir(
      {Key? key,
      required this.streamDataKendaraan,
      this.onTap,
      required this.keteranganParkir,
      required this.dataWaktu,
      required this.keteranganParkirColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamDataKendaraan,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data?.data() != null) {
            var data = snapshot.data!.data()!;

            // Widget Card
            return GestureDetector(
              onTap: onTap,
              child: Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 80,
                  child: Row(children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50)),

                        // Icon Kendaraan
                        child: Icon(
                          (data['jenis_kendaraan'] == 'Sepeda Motor')
                              ? Icons.motorcycle
                              : Icons.directions_car,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'MEMBER',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: Colors.blue),
                          ),

                          // Text Plat Nomor
                          Text(
                            data['nomor_plat'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                          // Text Merek Kendaraan
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
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(keteranganParkir.toUpperCase(),
                              style: TextStyle(
                                  color: keteranganParkirColor,
                                  fontWeight: FontWeight.bold)),
                          Text(DateFormat.Hm().format(
                              DateTime.parse((dataWaktu).toDate().toString())))
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            );
          }
          return const Text('');
        });
  }
}
