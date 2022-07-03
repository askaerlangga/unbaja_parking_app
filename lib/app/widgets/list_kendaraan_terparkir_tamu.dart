import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListKendaraanTerparkirTamu extends StatelessWidget {
  final void Function()? onTap;

  /// isi dengan : `parkir`,`masuk`, atau `keluar`
  final String keteranganParkir;
  final Timestamp dataWaktu;
  final Color keteranganParkirColor;
  final String jenisKendaraan;
  final String nomorPlat;
  final String merekKendaraan;

  const ListKendaraanTerparkirTamu(
      {Key? key,
      this.onTap,
      required this.keteranganParkir,
      required this.dataWaktu,
      required this.keteranganParkirColor,
      required this.jenisKendaraan,
      required this.nomorPlat,
      required this.merekKendaraan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(50)),

                // Icon Kendaraan
                child: Icon(
                  (jenisKendaraan == 'Sepeda Motor')
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
                    'TAMU',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.purple),
                  ),

                  // Text Plat Nomor
                  Text(
                    nomorPlat,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  // Text Merek Kendaraan
                  Text(
                    merekKendaraan,
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
                  Text(DateFormat.Hm()
                      .format(DateTime.parse((dataWaktu).toDate().toString())))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
