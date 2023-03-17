import 'package:currency_convertor_app/screens/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => const HomePage(),
      },
    ),
  );
}
