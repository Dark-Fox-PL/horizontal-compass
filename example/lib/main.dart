import 'package:flutter/material.dart';

import 'package:horizontal_compass/horizontal_compass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _value = 10;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: HorizontalCompass(
          type: HorizontalCompassType.infinite,
          value: _value,
          spacing: 10,
          height: 20,
          start: 0,
          end: 360,
          segments: {
            'segmentA': 30,
            'segmentB': 50,
            'segmentC': 120,
            'segmentD': 160,
          },
          colors: [
            Colors.blueAccent,
            Colors.deepPurpleAccent,
            Colors.orangeAccent,
            Colors.greenAccent,
          ],
        ),
      )),
    );
  }
}
