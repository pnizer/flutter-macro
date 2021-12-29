import 'package:flutter/material.dart';
import 'package:macro/screens/auth/auth_screen.dart';
import 'package:macro/screens/day_summary/day_summary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: AuthScreen(),
      home: DaySummaryScreen(),
    );
  }
}
