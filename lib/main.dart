import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:duidku/pages/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Duidku',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff121212),
        primarySwatch: Colors.grey,
      ),
      home: const SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
