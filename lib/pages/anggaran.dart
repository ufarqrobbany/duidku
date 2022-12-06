import 'package:flutter/material.dart';

class Anggaran extends StatefulWidget {
  const Anggaran({super.key});

  @override
  State<Anggaran> createState() => _AnggaranState();
}

class _AnggaranState extends State<Anggaran> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height * 1),
        decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
      ),
    );
  }
}
