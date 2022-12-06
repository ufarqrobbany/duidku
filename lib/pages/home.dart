import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:duidku/widgets/simplecard.dart';
import 'package:duidku/pages/transaksi.dart';
import 'package:duidku/pages/akun.dart';
import 'package:duidku/pages/tambah_akun.dart';
import 'package:duidku/pages/ubah_akun.dart';
import 'package:duidku/pages/notifikasi.dart';
import 'package:duidku/pages/anggaran.dart';
import 'package:duidku/pages/tabungan.dart';
import 'package:duidku/pages/profil.dart';
import 'package:duidku/pages/tambah_transaksi.dart';
import 'package:duidku/widgets/appbar.dart';
import 'package:duidku/widgets/buttoncard.dart';
import 'package:duidku/widgets/cashflow.dart';

import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:core';

import '../globals.dart' as globals;

Route _createRoute(routes) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => routes,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomSelectedIndex = 0;
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(bottomSelectedIndex == 0 ? Icons.home : Icons.home_outlined),
        label: 'Beranda',
      ),
      BottomNavigationBarItem(
        icon: Icon(bottomSelectedIndex == 1
            ? Icons.assessment
            : Icons.assessment_outlined),
        label: 'Anggaran',
      ),
      BottomNavigationBarItem(
        icon: Icon(
            bottomSelectedIndex == 2 ? Icons.savings : Icons.savings_outlined),
        label: 'Tabungan',
      ),
      BottomNavigationBarItem(
        icon: Icon(bottomSelectedIndex == 3
            ? Icons.account_circle
            : Icons.account_circle_outlined),
        label: 'Profil',
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        Home(),
        Anggaran(),
        Tabungan(),
        Profil(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  selectAppBar(int index) {
    if (index == 0) {
      return buildAppBar(context, true, 'Duidku', true, Icons.notifications,
          () {
        Navigator.of(context).push(_createRoute(const Notifikasi()));
      });
    } else if (index == 1) {
      return buildAppBar(context, false, 'Anggaran', false, Icons.home, null);
    } else if (index == 2) {
      return buildAppBar(context, false, 'Tabungan', false, Icons.home, null);
    } else if (index == 3) {
      return buildAppBar(context, false, 'Profil', false, Icons.home, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectAppBar(bottomSelectedIndex),
      body: buildPageView(),
      floatingActionButton: bottomSelectedIndex == 0
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text('Catat Transaksi'),
              backgroundColor: const Color(0xff121212),
              foregroundColor: Colors.white,
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const TambahTransaksi()));
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
        elevation: 0,
        selectedFontSize: 12,
        selectedItemColor: const Color(0xff121212),
        unselectedItemColor: const Color(0xffaaaaaa),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formatter = NumberFormat.simpleCurrency(
      locale: 'id_ID', decimalDigits: 0, name: 'Rp ');

  @override
  void initState() {
    var sum = 0;
    globals.akun.forEach((e) => sum += e.saldoAkun);
    globals.jumlahSaldo = sum;
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
    return SingleChildScrollView(
      child: Stack(alignment: AlignmentDirectional.topCenter, children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xff121212),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jumlah saldo',
                          style:
                              TextStyle(color: Color(0xffaaaaaa), fontSize: 13),
                        ),
                        Container(
                          height: 2,
                        ),
                        Text(
                          formatter.format(globals.jumlahSaldo).toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Container(
              width: MediaQuery.of(context).size.width * 1,
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 1),
              decoration: const BoxDecoration(
                color: Color(0xfff3f3f3),
              ),
              child: Column(
                children: [
                  buildSimpleCard(
                    context,
                    67,
                    0,
                    'AKUN',
                    '',
                    () {
                      Navigator.of(context).push(_createRoute(const Akun()));
                    },
                    [
                      globals.akun.isNotEmpty
                          ? Expanded(
                              child: Column(
                                children: List<Widget>.generate(
                                    globals.akun.length, (int index) {
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0))),
                                      onPressed: () {},
                                      child: GestureDetector(
                                        onTapDown: (TapDownDetails details) {
                                          showPopUpMenu(
                                              context,
                                              details.globalPosition,
                                              index,
                                              globals.akun[index].idJenisAkun);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                  globals.akun[index].iconAkun),
                                              Container(width: 10),
                                              Row(
                                                children: [
                                                  Text(globals
                                                      .akun[index].namaAkun),
                                                  Container(width: 10),
                                                  const Text('-'),
                                                  Container(width: 10),
                                                  Text(formatter
                                                      .format(globals
                                                          .akun[index]
                                                          .saldoAkun)
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
                            )
                          : Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xff121212),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Tambah Akun',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const TambahAkun())),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                  buildSimpleCard(
                    context,
                    20,
                    20,
                    'TRANSAKSI',
                    '',
                    () {
                      Navigator.of(context)
                          .push(_createRoute(const Transaksi()));
                    },
                    [
                      globals.transaksi.isNotEmpty
                          ? Expanded(
                              child: Column(
                                children: List<Widget>.generate(
                                    globals.transaksi.length, (int index) {
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0))),
                                      onPressed: () {},
                                      child: GestureDetector(
                                        onTapDown: (TapDownDetails details) {
                                          showPopUpMenuTransaksi(context,
                                              details.globalPosition, index);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  color: globals
                                                              .transaksi[index]
                                                              .jenisTransaksi ==
                                                          'Pemasukan'
                                                      ? Colors.green
                                                      : globals.transaksi[index]
                                                                  .jenisTransaksi ==
                                                              'Pengeluaran'
                                                          ? Colors.red
                                                          : Colors.blue,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(100)),
                                                ),
                                                child: Icon(
                                                  globals.transaksi[index]
                                                              .jenisTransaksi ==
                                                          'Pemasukan'
                                                      ? Icons.south_rounded
                                                      : globals.transaksi[index]
                                                                  .jenisTransaksi ==
                                                              'Pengeluaran'
                                                          ? Icons.north_rounded
                                                          : Icons.east_rounded,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(globals
                                                                  .transaksi[
                                                                      index]
                                                                  .jenisTransaksi ==
                                                              'Pemasukan'
                                                          ? globals
                                                              .kategoriPemasukan[globals
                                                                      .transaksi[
                                                                          index]
                                                                      .idKategori -
                                                                  1]
                                                              .namaKategoriPemasukan
                                                          : globals
                                                                      .transaksi[
                                                                          index]
                                                                      .jenisTransaksi ==
                                                                  'Pengeluaran'
                                                              ? globals
                                                                  .kategoriPengeluaran[globals
                                                                          .transaksi[
                                                                              index]
                                                                          .idKategori -
                                                                      1]
                                                                  .namaKategoriPengeluaran
                                                              : 'Transfer'),
                                                      const Text(' - '),
                                                      Text(
                                                        formatter
                                                            .format(globals
                                                                .transaksi[
                                                                    index]
                                                                .jumlahTransaksi)
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: globals
                                                                      .transaksi[
                                                                          index]
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
                                                        globals.transaksi[index]
                                                                    .jenisTransaksi ==
                                                                'Pemasukan'
                                                            ? globals
                                                                .akun[globals
                                                                        .transaksi[
                                                                            index]
                                                                        .idAkunTujuan -
                                                                    1]
                                                                .namaAkun
                                                            : globals
                                                                        .transaksi[
                                                                            index]
                                                                        .jenisTransaksi ==
                                                                    'Pengeluaran'
                                                                ? globals
                                                                    .akun[globals
                                                                            .transaksi[index]
                                                                            .idDariAkun -
                                                                        1]
                                                                    .namaAkun
                                                                : '${globals.akun[globals.transaksi[index].idDariAkun - 1].namaAkun} -> ${globals.akun[globals.transaksi[index].idAkunTujuan - 1].namaAkun}',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Container(width: 10),
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
                                                    '${tanggalIndo(globals.transaksi[index].tanggal)}, ${globals.transaksi[index].waktu}',
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
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),

        // CASHFLOW
        Positioned(
          top: 50,
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: buildButtonCard(
              context,
              'CASH FLOW',
              'November 2022',
              () {
                Navigator.of(context).push(_createRoute(const Transaksi()));
              },
              [
                buildCashFlow(formatter.format(globals.pemasukan).toString(),
                    Icons.south_rounded, Colors.green),
                Container(width: 10),
                buildCashFlow(formatter.format(globals.pengeluaran).toString(),
                    Icons.north_rounded, Colors.red),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Future<void> showPopUpMenu(
    context, Offset globalPosition, index, int jenisAkun) async {
  double left = globalPosition.dx;
  double top = globalPosition.dy;
  await showMenu(
    color: Colors.white,
    //add your color
    context: context,
    position: RelativeRect.fromLTRB(left, top, 0, 0),
    items: [
      PopupMenuItem(
        value: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 20),
          child: Row(
            children: const [
              Text(
                "Ubah Data",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 20),
          child: Row(
            children: const [
              Text(
                "Hapus Akun",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    ],
    elevation: 1.0,
  ).then((value) {
    print(value);
    if (value == 1) {
      globals.jenisakunSelected = jenisAkun;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => UbahAkun(
                index: index,
              )));
    }
    if (value == 2) {
      globals.akun.removeAt(index);
      globals.transaksi.removeWhere((element) => element.idDariAkun == index);
      globals.transaksi.removeWhere((element) => element.idAkunTujuan == index);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const HomePage()));
    }
  });
}

Future<void> showPopUpMenuTransaksi(
    context, Offset globalPosition, index) async {
  double left = globalPosition.dx;
  double top = globalPosition.dy;
  await showMenu(
    color: Colors.white,
    //add your color
    context: context,
    position: RelativeRect.fromLTRB(left, top, 0, 0),
    items: [
      PopupMenuItem(
        value: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 20),
          child: Row(
            children: const [
              Text(
                "Hapus Transaksi",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    ],
    elevation: 1.0,
  ).then((value) {
    print(value);
    if (value == 1) {
      if (globals.transaksi[index].jenisTransaksi == 'Pemasukan') {
        globals.pemasukan -= globals.transaksi[index].jumlahTransaksi;
        globals.akun[globals.transaksi[index].idAkunTujuan - 1].saldoAkun -=
            globals.transaksi[index].jumlahTransaksi;
      } else if (globals.transaksi[index].jenisTransaksi == 'Pengeluaran') {
        globals.pengeluaran -= globals.transaksi[index].jumlahTransaksi;
        globals.akun[globals.transaksi[index].idDariAkun - 1].saldoAkun -=
            globals.transaksi[index].jumlahTransaksi;
      } else {
        globals.akun[globals.transaksi[index].idDariAkun - 1].saldoAkun +=
            globals.transaksi[index].jumlahTransaksi;
        globals.akun[globals.transaksi[index].idAkunTujuan - 1].saldoAkun -=
            globals.transaksi[index].jumlahTransaksi;
      }

      globals.transaksi.removeAt(index);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const HomePage()));
    }
  });
}
