import 'package:flutter/material.dart';
// Import file welcome_page.dart
import 'package:jalan2kuy/screens/welcome_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jalan2Kuy.id',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E5649),
        scaffoldBackgroundColor: Colors.white,
      ),
      // UBAH BAGIAN INI: Jadikan WelcomePage sebagai halaman utama
      home: const WelcomePage(), 
    );
  }
}