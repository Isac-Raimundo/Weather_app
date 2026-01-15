import 'package:flutter/material.dart';
import 'package:weather_app/pages/HomePage.dart';
import 'package:weather_app/services/weatherService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color(0xff2d2f3e)),
      ),
      home: HomePage(),
    );
  }
}