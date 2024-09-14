import 'package:flutter/material.dart';
import 'package:news_now/landing_page.dart';
import 'package:news_now/screens/bookmark_page.dart';
import 'package:news_now/screens/home_page.dart';
import 'package:news_now/screens/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Now',
      debugShowCheckedModeBanner: false,
      home: Land(),
    );
  }
}
