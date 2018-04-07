import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/HomeScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Weight Tracker',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new HomeScreen(),
    );
  }
}