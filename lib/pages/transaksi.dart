import 'package:flutter/material.dart';
import 'package:duidku/pages/tambah_transaksi.dart';

import 'package:duidku/pages/home.dart';
import 'package:intl/intl.dart';

import '../globals.dart' as globals;

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final formatter = NumberFormat.simpleCurrency(
      locale: 'id_ID', decimalDigits: 0, name: 'Rp ');

  @override
  void initState() {
    super.initState();
  }

  String tanggalIndo(String tgl) {
    List<String> tanggal = tgl.split('-');

    List<String> bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${tanggal[2]} ${bulan[int.parse(tanggal[1]) - 1]} ${tanggal[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Transaksi'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height * 1),
          decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children:
                  List<Widget>.generate(globals.transaksi.length, (int index) {
                return Container(
                  width: MediaQuery.of(context).size.width * .9,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xffffffff)),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(0, 0, 0, 0))),
                    onPressed: () {},
                    child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        showPopUpMenuTransaksi(
                            context, details.globalPosition, index);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: globals
                                            .transaksi[index].jenisTransaksi ==
                                        'Pemasukan'
                                    ? Colors.green
                                    : globals.transaksi[index].jenisTransaksi ==
                                            'Pengeluaran'
                                        ? Colors.red
                                        : Colors.blue,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                              ),
                              child: Icon(
                                globals.transaksi[index].jenisTransaksi ==
                                        'Pemasukan'
                                    ? Icons.south_rounded
                                    : globals.transaksi[index].jenisTransaksi ==
                                            'Pengeluaran'
                                        ? Icons.north_rounded
                                        : Icons.east_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(globals.transaksi[index]
                                                .jenisTransaksi ==
                                            'Pemasukan'
                                        ? globals
                                            .kategoriPemasukan[globals
                                                    .transaksi[index]
                                                    .idKategori -
                                                1]
                                            .namaKategoriPemasukan
                                        : globals.transaksi[index]
                                                    .jenisTransaksi ==
                                                'Pengeluaran'
                                            ? globals
                                                .kategoriPengeluaran[globals
                                                        .transaksi[index]
                                                        .idKategori -
                                                    1]
                                                .namaKategoriPengeluaran
                                            : 'Transfer'),
                                    const Text(' - '),
                                    Text(
                                      formatter
                                          .format(globals
                                              .transaksi[index].jumlahTransaksi)
                                          .toString(),
                                      style: TextStyle(
                                        color: globals.transaksi[index]
                                                    .jenisTransaksi ==
                                                'Pemasukan'
                                            ? Colors.green
                                            : globals.transaksi[index]
                                                        .jenisTransaksi ==
                                                    'Pengeluaran'
                                                ? Colors.red
                                                : Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      globals.transaksi[index].jenisTransaksi ==
                                              'Pemasukan'
                                          ? globals
                                              .akun[globals.transaksi[index]
                                                      .idAkunTujuan -
                                                  1]
                                              .namaAkun
                                          : globals.transaksi[index]
                                                      .jenisTransaksi ==
                                                  'Pengeluaran'
                                              ? globals
                                                  .akun[globals.transaksi[index]
                                                          .idDariAkun -
                                                      1]
                                                  .namaAkun
                                              : '${globals.akun[globals.transaksi[index].idDariAkun - 1].namaAkun} -> ${globals.akun[globals.transaksi[index].idAkunTujuan - 1].namaAkun}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Container(width: 20),
                                    Text(
                                      '(${globals.transaksi[index].keterangan})',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(height: 5),
                                Text(
                                  tanggalIndo(globals.transaksi[index].tanggal),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Tambah Transaksi'),
        backgroundColor: const Color(0xff121212),
        foregroundColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const TambahTransaksi()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
