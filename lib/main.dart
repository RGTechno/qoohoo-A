import 'package:flutter/material.dart';
import 'package:test_qoohoo/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qoohoo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Oswald",
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
