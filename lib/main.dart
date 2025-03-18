import 'package:flutter/material.dart';
import 'package:my_spirit/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFDCDCDC),
          titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20),
        ),
      ),
    );
  }
}
