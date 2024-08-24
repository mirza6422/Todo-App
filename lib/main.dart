import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:threee_d_button/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String title = "𝐷𝑎𝑖𝑙𝑦 𝑇𝑜𝑑𝑜𝑠";

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Color(0xff508D4E)),
        home: HomePage(),
      );
}
