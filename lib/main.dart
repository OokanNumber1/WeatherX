import 'package:flutter/material.dart';
import 'package:weather_x/src/views/check_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather-X',
      debugShowCheckedModeBanner: false,
      home: CheckView(),
    );
  }
}
