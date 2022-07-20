import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class LaporanController extends GetxController {
  final db = FirebaseFirestore.instance;
  var selectedMonth = DateTime.now().obs;
  List<List<dynamic>> tableDataRiwayatParkir = [];

  Future<QuerySnapshot<Map<String, dynamic>>> getDateRange() {
    var list = db.collection('parking').orderBy('keluar').get();
    return list;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getListParkir() {
    var timeNow = DateFormat('yyyy-MM-dd').format(selectedMonth.value);
    var endMonth = DateFormat('yyyy-MM-dd').format(
        DateTime(selectedMonth.value.year, selectedMonth.value.month + 1));

    var firstTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$timeNow 00:00:00').millisecondsSinceEpoch);
    var lastTime = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('$endMonth 23:59:00').millisecondsSinceEpoch);
    print(endMonth);

    var listKendaraan = db
        .collection('parking')
        .where('active', isEqualTo: false)
        .where('keluar', isLessThan: lastTime)
        .where('keluar', isGreaterThan: firstTime)
        .orderBy('keluar', descending: true)
        .snapshots();

    return listKendaraan;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataKendaraan(
      String idKendaraaan) {
    var docRef = db.collection('vehicles').doc(idKendaraaan);
    return docRef.get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPetugas(
      String idPetugas) {
    var dataPetugas = db.collection('users').doc(idPetugas);
    return dataPetugas.get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataPengendara(String uid) {
    var dataPengendara = db.collection('users').doc(uid);
    return dataPengendara.get();
  }

  Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/example.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  Future<File> generate(int motor, int mobil) async {
    final pdf = pw.Document();
    var timeNow =
        DateFormat('dd MMMM yyyy', 'id_ID').format(selectedMonth.value);
    var endMonth = DateFormat('dd MMMM yyyy', 'id_ID').format(
        DateTime(selectedMonth.value.year, selectedMonth.value.month + 1));

    final tableHeaderRiwayatParkir = [
      'Nomor Plat',
      'Jenis Kendaraan',
      'Merek',
      'Nama',
      'Jam Masuk',
      'Petugas Masuk',
      'Jam Keluar',
      'Petugas Keluar',
      'Lama Parkir'
    ];

    pdf.addPage(
      pw.Page(
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(children: [
                          pw.Text('UNBAJA PARKING APP',
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('Laporan bulanan riwayat kendaraan parkir'),
                        ]),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text('Menampilkan riwayat parkir dari'),
                              pw.Text('$timeNow - $endMonth',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Text('Ringkasan',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Row(children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Sepeda Motor'),
                          pw.Text('Mobil'),
                          pw.Text('Jumlah'),
                        ]),
                    pw.SizedBox(width: 10),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(motor.toString()),
                          pw.Text(mobil.toString()),
                          pw.Text((motor + mobil).toString()),
                        ])
                  ]),
                  pw.SizedBox(height: 10),
                  pw.Table.fromTextArray(
                    headers: tableHeaderRiwayatParkir,
                    data: tableDataRiwayatParkir,
                  )
                ]);
          }),
    );

    return saveDocument(name: 'example.pdf', pdf: pdf);
  }
}
