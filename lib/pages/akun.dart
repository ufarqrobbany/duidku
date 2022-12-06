import 'package:flutter/material.dart';
import 'package:duidku/pages/ubah_akun.dart';
import 'package:duidku/pages/tambah_akun.dart';
import 'package:duidku/pages/home.dart';
import 'package:intl/intl.dart';

import '../globals.dart' as globals;

class Akun extends StatefulWidget {
  const Akun({super.key});

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  final formatter = NumberFormat.simpleCurrency(
      locale: 'id_ID', decimalDigits: 0, name: 'Rp ');
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
        title: const Text('Akun'),
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
              children: List<Widget>.generate(globals.akun.length, (int index) {
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
                        showPopUpMenu(context, details.globalPosition, index,
                            globals.akun[index].idJenisAkun);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(globals.akun[index].iconAkun),
                            Container(width: 10),
                            Row(
                              children: [
                                Text(globals.akun[index].namaAkun),
                                Container(width: 10),
                                const Text('-'),
                                Container(width: 10),
                                Text(formatter
                                    .format(globals.akun[index].saldoAkun)
                                    .toString()),
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
        label: const Text('Tambah Akun'),
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
              builder: (BuildContext context) => const TambahAkun()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
