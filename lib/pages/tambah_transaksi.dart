import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:duidku/pages/home.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../globals.dart' as globals;

TextEditingController kategoriin = TextEditingController();
TextEditingController kategoriout = TextEditingController();

class TambahTransaksi extends StatefulWidget {
  const TambahTransaksi({super.key});

  @override
  State<TambahTransaksi> createState() => _TambahTransaksiState();
}

class _TambahTransaksiState extends State<TambahTransaksi> {
  final formatter = NumberFormat.simpleCurrency(
      locale: 'id_ID', decimalDigits: 0, name: 'Rp ');
  final _formKeyPemasukan = GlobalKey<FormState>();
  final _formKeyPengeluaran = GlobalKey<FormState>();
  final _formKeyTransfer = GlobalKey<FormState>();
  int tabSelectedIndex = 1;
  late int SelectedDariAkunTF;
  late int SelectedAkunTujuanTF;
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController jumlahinput = TextEditingController();
  TextEditingController dariakun = TextEditingController();
  TextEditingController akuntujuan = TextEditingController();
  TextEditingController dariakuntf = TextEditingController();
  TextEditingController akuntujuantf = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  Widget buildTab(int index, String title) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: tabSelectedIndex == index
              ? const Color(0xff121212)
              : Colors.white,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.grey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: tabSelectedIndex == index
                    ? const TextStyle(
                        color: Colors.white,
                      )
                    : const TextStyle(
                        color: Colors.black,
                      ),
              ),
            ),
            onTap: () => tabSelect(index),
          ),
        ),
      ),
    );
  }

  Widget buildInputSaldo() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.black,
      textAlign: TextAlign.start,
      style: const TextStyle(fontSize: 26),
      decoration: const InputDecoration(
        hintText: 'Rp 0',
        border: InputBorder.none,
        counterText: "",
      ),
      controller: jumlahinput,
      inputFormatters: [
        CurrencyTextInputFormatter(
          decimalDigits: 0,
          locale: 'in',
          symbol: 'Rp ',
          enableNegative: false,
        ),
      ],
      maxLength: 24,
      validator: (value) {
        if (value == null || value.isEmpty || value == 'Rp 0') {
          return 'Mohon untuk diisi';
        }
        return null;
      },
    );
  }

  Widget buildFormContainer(children) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: children),
    );
  }

  Widget buildInputKategori(bool out) {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.category),
        labelText: 'Kategori',
        border: InputBorder.none,
      ),
      readOnly: true,
      controller: out ? kategoriout : kategoriin,
      onTap: () {
        out
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const KategoriPengeluaran()))
            : Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const KategoriPemasukan()));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap pilih kategori';
        }
        return null;
      },
    );
  }

  Widget buildInputAkun(bool to, bool isInTF) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(to ? Icons.input : Icons.output),
        labelText: to ? 'Akun Tujuan' : 'Dari Akun',
        border: InputBorder.none,
      ),
      readOnly: true,
      controller: isTransfer(to, isInTF),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(15),
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(to ? 'Akun Tujuan' : 'Dari Akun',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  Container(height: 15),
                  SizedBox(
                    height: 139,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List<Widget>.generate(globals.akun.length,
                            (int index) {
                          return Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    if (to) {
                                      if (isInTF) {
                                        SelectedAkunTujuanTF = index;
                                        globals.AkunTujuanSelectedTF = index;
                                        akuntujuantf.text =
                                            globals.akun[index].namaAkun;
                                      } else {
                                        globals.AkunTujuanSelected = index;
                                        akuntujuan.text =
                                            globals.akun[index].namaAkun;
                                      }
                                    } else {
                                      if (isInTF) {
                                        globals.dariAkunSelectedTF = index;
                                        SelectedDariAkunTF = index;
                                        dariakuntf.text =
                                            globals.akun[index].namaAkun;
                                      } else {
                                        globals.dariAkunSelected = index;
                                        dariakun.text =
                                            globals.akun[index].namaAkun;
                                      }
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(globals.akun[index].iconAkun),
                                    Container(width: 10),
                                    Text(
                                        '${globals.akun[index].namaAkun} - ${formatter.format(globals.akun[index].saldoAkun).toString()}'),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap pilih Akun';
        }
        if (tabSelectedIndex == 2) {
          if (SelectedAkunTujuanTF == SelectedDariAkunTF) {
            return 'Akun Tidak Boleh Sama';
          }
        }
        return null;
      },
    );
  }

  Widget buildInputTanggal() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_month),
        labelText: 'Tanggal',
        border: InputBorder.none,
      ),
      controller: dateinput,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          print(pickedDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate);

          setState(() {
            dateinput.text = formattedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  Widget buildInputWaktu() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.schedule),
        labelText: 'Waktu',
        border: InputBorder.none,
      ),
      controller: timeinput,
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if (pickedTime != null) {
          print(pickedTime.format(context));
          DateTime parsedTime =
              DateFormat.jm().parse(pickedTime.format(context).toString());
          print(parsedTime);
          String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
          print(formattedTime);

          setState(() {
            timeinput.text = formattedTime;
          });
        } else {
          print("Time is not selected");
        }
      },
    );
  }

  Widget buildInputKeterangan() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.edit),
        labelText: 'Keterangan',
        border: InputBorder.none,
      ),
      controller: keterangan,
    );
  }

  Widget formPemasukan() {
    return Form(
      key: _formKeyPemasukan,
      child: Column(children: [
        buildInputSaldo(),
        Container(height: 15),
        buildFormContainer([
          buildInputKategori(false),
          buildInputAkun(true, false),
          buildInputTanggal(),
          buildInputWaktu(),
          buildInputKeterangan()
        ]),
      ]),
    );
  }

  Widget formPengeluaran() {
    return Form(
      key: _formKeyPengeluaran,
      child: Column(children: [
        buildInputSaldo(),
        Container(height: 15),
        buildFormContainer([
          buildInputKategori(true),
          buildInputAkun(false, false),
          buildInputTanggal(),
          buildInputWaktu(),
          buildInputKeterangan()
        ]),
      ]),
    );
  }

  Widget formTransfer() {
    return Form(
      key: _formKeyTransfer,
      child: Column(children: [
        buildInputSaldo(),
        Container(height: 15),
        buildFormContainer([
          buildInputAkun(false, true),
          buildInputAkun(true, true),
          buildInputTanggal(),
          buildInputWaktu(),
          buildInputKeterangan()
        ]),
      ]),
    );
  }

  @override
  void initState() {
    dateinput.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    timeinput.text = DateFormat.Hms().format(DateTime.now());
    super.initState();
  }

  void tabSelect(int index) {
    setState(() {
      tabSelectedIndex = index;
    });
  }

  selectForm(int index) {
    switch (index) {
      case 0:
        return formPemasukan();
      case 1:
        return formPengeluaran();
      case 2:
        return formTransfer();
      default:
        return formPemasukan();
    }
  }

  isTransfer(bool to, bool isInTF) {
    if (to) {
      if (isInTF) {
        return akuntujuantf;
      } else {
        return akuntujuan;
      }
    } else {
      if (isInTF) {
        return dariakuntf;
      } else {
        return dariakun;
      }
    }
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
        title: const Text('Tambah Transaksi'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height * 1),
          decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: Row(
                  children: [
                    buildTab(0, 'Pemasukan'),
                    buildTab(1, 'Pengeluaran'),
                    buildTab(2, 'Transfer'),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                // child: tabSelectedIndex == 0 ? formPemasukan() : Text('asu'),
                child: selectForm(tabSelectedIndex),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.save),
        label: const Text('Simpan'),
        backgroundColor: const Color(0xff121212),
        foregroundColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          if (tabSelectedIndex == 0) {
            if (_formKeyPemasukan.currentState!.validate()) {
              var saldosplit = jumlahinput.text.split(' ');
              var saldosplit2 = saldosplit[1].split('.');
              int saldoint = int.parse(saldosplit2.join());

              globals.transaksi.add(globals.DataTransaksiObject(
                idTransaksi: globals.transaksi.length + 1,
                jenisTransaksi: 'Pemasukan',
                jumlahTransaksi: saldoint,
                idKategori: globals.kategoriPemasukanSelected + 1,
                idDariAkun: 0,
                idAkunTujuan: globals.AkunTujuanSelected + 1,
                tanggal: dateinput.text,
                waktu: timeinput.text,
                keterangan: keterangan.text != '' ? keterangan.text : '-',
              ));

              globals.pemasukan += saldoint;

              final tile = globals.akun.firstWhere((item) =>
                  item.idAkun ==
                  globals.akun[globals.AkunTujuanSelected].idAkun);
              setState(() {
                tile.saldoAkun += saldoint;
              });

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()));
            }
          } else if (tabSelectedIndex == 1) {
            if (_formKeyPengeluaran.currentState!.validate()) {
              var saldosplit = jumlahinput.text.split(' ');
              var saldosplit2 = saldosplit[1].split('.');
              int saldoint = int.parse(saldosplit2.join());

              if (globals.akun[globals.dariAkunSelected].saldoAkun >=
                  saldoint) {
                globals.transaksi.add(globals.DataTransaksiObject(
                  idTransaksi: globals.transaksi.length + 1,
                  jenisTransaksi: 'Pengeluaran',
                  jumlahTransaksi: saldoint,
                  idKategori: globals.kategoriPengeluaranSelected + 1,
                  idDariAkun: globals.dariAkunSelected + 1,
                  idAkunTujuan: 0,
                  tanggal: dateinput.text,
                  waktu: timeinput.text,
                  keterangan: keterangan.text != '' ? keterangan.text : '-',
                ));

                globals.pengeluaran += saldoint;

                final tile = globals.akun.firstWhere((item) =>
                    item.idAkun ==
                    globals.akun[globals.dariAkunSelected].idAkun);
                setState(() {
                  tile.saldoAkun -= saldoint;
                });

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Saldo Akun Kurang'),
                ));
              }
            }
          } else if (tabSelectedIndex == 2) {
            if (_formKeyTransfer.currentState!.validate()) {
              var saldosplit = jumlahinput.text.split(' ');
              var saldosplit2 = saldosplit[1].split('.');
              int saldoint = int.parse(saldosplit2.join());

              if (globals.akun[globals.dariAkunSelectedTF].saldoAkun >=
                  saldoint) {
                globals.transaksi.add(globals.DataTransaksiObject(
                  idTransaksi: globals.transaksi.length + 1,
                  jenisTransaksi: 'Transfer',
                  jumlahTransaksi: saldoint,
                  idKategori: 0,
                  idDariAkun: globals.dariAkunSelectedTF + 1,
                  idAkunTujuan: globals.AkunTujuanSelectedTF + 1,
                  tanggal: dateinput.text,
                  waktu: timeinput.text,
                  keterangan: keterangan.text != '' ? keterangan.text : '-',
                ));

                final dariakuntile = globals.akun.firstWhere((item) =>
                    item.idAkun ==
                    globals.akun[globals.dariAkunSelectedTF].idAkun);
                final akuntujuantile = globals.akun.firstWhere((item) =>
                    item.idAkun ==
                    globals.akun[globals.AkunTujuanSelectedTF].idAkun);
                setState(() {
                  dariakuntile.saldoAkun -= saldoint;
                  akuntujuantile.saldoAkun += saldoint;
                });

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Saldo Akun Kurang'),
                ));
              }
              ;
            }
          }
        },
      ),
    );
  }
}

// Kategori Pemasukan
class KategoriPemasukan extends StatefulWidget {
  const KategoriPemasukan({super.key});

  @override
  State<KategoriPemasukan> createState() => _KategoriPemasukanState();
}

class _KategoriPemasukanState extends State<KategoriPemasukan> {
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
        title: const Text('Kategori Pemasukan'),
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
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List<Widget>.generate(globals.kategoriPemasukan.length,
                  (int index) {
                return Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          globals.kategoriPemasukanSelected = index;
                          kategoriin.text = globals
                              .kategoriPemasukan[index].namaKategoriPemasukan;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Icon(globals.kategoriPemasukan[index]
                                  .iconKategoriPemasukan),
                              Container(width: 10),
                              Text(globals.kategoriPemasukan[index]
                                  .namaKategoriPemasukan),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// Kategori Pengeluaran
class KategoriPengeluaran extends StatefulWidget {
  const KategoriPengeluaran({super.key});

  @override
  State<KategoriPengeluaran> createState() => _KategoriPengeluaranState();
}

class _KategoriPengeluaranState extends State<KategoriPengeluaran> {
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
        title: const Text('Kategori Pengeluaran'),
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
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List<Widget>.generate(
                  globals.kategoriPengeluaran.length, (int index) {
                return Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          globals.kategoriPengeluaranSelected = index;
                          kategoriout.text = globals.kategoriPengeluaran[index]
                              .namaKategoriPengeluaran;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Icon(globals.kategoriPengeluaran[index]
                                  .iconKategoriPengeluaran),
                              Container(width: 10),
                              Text(globals.kategoriPengeluaran[index]
                                  .namaKategoriPengeluaran),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
