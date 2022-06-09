import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/Reg_Auth.dart';
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Этот виджет является корнем приложения.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INV',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: RegPage(),
    );
  }
}

