import 'dart:async';
import 'package:duidku/pages/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Duidku',
              style: TextStyle(
                fontFamily: 'Aqua',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xffaaaaaa),
              ),
            ),
            Text(
              'Manajemen Keuangan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(0xffcccccc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
