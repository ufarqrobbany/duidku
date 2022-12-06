import 'package:duidku/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';
import '../globals.dart' as globals;

class UbahAkun extends StatefulWidget {
  final int index;
  const UbahAkun({super.key, required this.index});

  @override
  State<UbahAkun> createState() => _UbahAkunState();
}

class _UbahAkunState extends State<UbahAkun> {
  final _formKeyUbahAkun = GlobalKey<FormState>();
  final formatter = NumberFormat.simpleCurrency(
      locale: 'id_ID', decimalDigits: 0, name: 'Rp ');

  TextEditingController jenisakun = TextEditingController();
  TextEditingController namaakun = TextEditingController();
  TextEditingController saldosekarang = TextEditingController();

  Widget buildFormContainer(children) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: children),
    );
  }

  Widget buildButtonJenisAkun(
      String namaJenisAkun, IconData iconJenisAkun, action) {
    return Expanded(
      child: OutlinedButton(
        onPressed: action,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            Icon(iconJenisAkun),
            Container(width: 10),
            Text(namaJenisAkun),
          ]),
        ),
      ),
    );
  }

  Widget buildInputJenisAkun() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.grid_view),
        labelText: 'Jenis',
        border: InputBorder.none,
      ),
      readOnly: true,
      controller: jenisakun,
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
                  const Text('Jenis Akun',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  Container(height: 15),
                  const Text(
                    'Akun Manual',
                    textAlign: TextAlign.left,
                  ),
                  Container(height: 15),
                  Row(
                    children: [
                      buildButtonJenisAkun(
                        globals.jenisAkun[0]['nama_jenis_akun'] as String,
                        globals.jenisAkun[0]['icon_jenis_akun'] as IconData,
                        () {
                          Navigator.pop(context);
                          setState(() {
                            jenisakun.text = globals.jenisAkun[0]
                                ['nama_jenis_akun'] as String;
                            globals.jenisakunSelected = 1;
                          });
                        },
                      ),
                      Container(width: 15),
                      buildButtonJenisAkun(
                        globals.jenisAkun[1]['nama_jenis_akun'] as String,
                        globals.jenisAkun[1]['icon_jenis_akun'] as IconData,
                        () {
                          Navigator.pop(context);
                          setState(() {
                            jenisakun.text = globals.jenisAkun[1]
                                ['nama_jenis_akun'] as String;
                            globals.jenisakunSelected = 2;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(height: 15),
                  buildButtonJenisAkun(
                    globals.jenisAkun[2]['nama_jenis_akun'] as String,
                    globals.jenisAkun[2]['icon_jenis_akun'] as IconData,
                    () {
                      Navigator.pop(context);
                      setState(() {
                        jenisakun.text =
                            globals.jenisAkun[2]['nama_jenis_akun'] as String;
                        globals.jenisakunSelected = 3;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap pilih Jenis Akun';
        }
        return null;
      },
    );
  }

  Widget buildInputNamaAkun(String label, IconData iconFiels) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(iconFiels),
        labelText: label,
        border: InputBorder.none,
      ),
      controller: namaakun,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon untuk diisi';
        }
        return null;
      },
    );
  }

  Widget buildInputSaldoSekarang() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        icon: Icon(Icons.money),
        hintText: 'Rp 0',
        labelText: 'Saldo Sekarang',
        border: InputBorder.none,
        counterText: "",
      ),
      controller: saldosekarang,
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
        if (value == null || value.isEmpty) {
          return 'Mohon untuk diisi';
        }
        return null;
      },
    );
  }

  @override
  void initState() {
    jenisakun.text = globals.jenisakunSelected == 1
        ? 'Cash'
        : globals.jenisakunSelected == 2
            ? 'E-wallet'
            : 'Akun Bank';
    namaakun.text = globals.akun[widget.index].namaAkun;
    saldosekarang.text =
        formatter.format(globals.akun[widget.index].saldoAkun).toString();
    super.initState();
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
        title: const Text('Ubah Data Akun'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height * 1),
          decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: Form(
              key: _formKeyUbahAkun,
              child: Column(children: [
                Container(height: 15),
                buildFormContainer([
                  buildInputJenisAkun(),
                  buildInputNamaAkun(
                      globals.jenisakunSelected == 1
                          ? 'Nama Akun'
                          : globals.jenisakunSelected == 2
                              ? 'Nama Akun E-Wallet'
                              : 'Nama Akun Bank',
                      globals.jenisakunSelected == 1
                          ? Icons.payments
                          : globals.jenisakunSelected == 2
                              ? Icons.account_balance_wallet
                              : Icons.account_balance),
                  globals.jenisakunSelected == 1
                      ? Container()
                      : globals.jenisakunSelected == 2
                          ? Container()
                          : Container(),
                  buildInputSaldoSekarang()
                ]),
              ]),
            ),
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
          if (_formKeyUbahAkun.currentState!.validate()) {
            Object iconakun = globals.jenisakunSelected == 1
                ? Icons.payments
                : globals.jenisakunSelected == 2
                    ? Icons.account_balance_wallet
                    : Icons.account_balance;

            var saldosplit = saldosekarang.text.split(' ');
            var saldosplit2 = saldosplit[1].split('.');
            int saldoint = int.parse(saldosplit2.join());

            final tile = globals.akun.firstWhere(
                (item) => item.idAkun == globals.akun[widget.index].idAkun);
            setState(() {
              tile.namaAkun = namaakun.text;
              tile.iconAkun = iconakun as IconData;
              tile.saldoAkun = saldoint;
              tile.idJenisAkun = globals.jenisakunSelected;
            });

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()));
          }
        },
      ),
    );
  }
}
