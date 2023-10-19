// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mini_maomao/pages/animation_page.dart';
import 'package:mini_maomao/pages/game_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/animation_page': (context) => AnimationPage(),
        '/game_page': (context) => GamePage(),
      },
    );
  }
}
