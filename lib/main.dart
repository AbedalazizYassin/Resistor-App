import 'package:flutter/material.dart';

import 'welcome_screen.dart';
import 'product.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'csci410 week 11-Assignment',
      home: Welcome(),
    );
  }
}
