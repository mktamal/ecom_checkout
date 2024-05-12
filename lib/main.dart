
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'home_screen_2.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen2(),//HomeScreen(),
    );
  }
}
