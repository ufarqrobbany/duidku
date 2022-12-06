import 'package:flutter/material.dart';

class Tabungan extends StatefulWidget {
  const Tabungan({super.key});

  @override
  State<Tabungan> createState() => _TabunganState();
}

class _TabunganState extends State<Tabungan> {
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
