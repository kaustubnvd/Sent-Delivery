import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(SentApp());

class SentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: Change status bar color to black
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: null, 
      routes: {},
    );
  }
}
