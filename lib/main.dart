import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:threee_d_button/page/home_page.dart';


void main() =>runApp( MyApp());

class MyApp extends StatelessWidget{
  static const String title = "Todo App";



  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,

    ),
    home: HomePage(),
  );
}