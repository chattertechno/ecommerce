import 'package:flutter/material.dart';
import 'package:inauzwa/pages/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inauzwa',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan[400],
        accentColor: Colors.deepOrange,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 18.0) 
        )
      ),
      home: RegisterPage(),
      
    );
  }
}

