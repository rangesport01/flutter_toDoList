import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/mainScreen.dart';



void main() async {

  runApp(MaterialApp(
    theme: new ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.deepOrangeAccent,
      ),),


    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/todo': (context) => Home(),
    },

  ));
}