import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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
