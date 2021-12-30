import 'package:flutter/material.dart';
import 'package:macro/screens/day_summary/day_summary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DaySummaryScreen(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.purple,
  //     ),
  //     // home: AuthScreen(),
  //     // home: DaySummaryScreen(),
  //     home: JogoDaBela(),
  //   );
  // }
}
