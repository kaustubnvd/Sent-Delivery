import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './providers/tabs.dart';
import './providers/panel.dart';
import './providers/orders.dart';

/*
  Authors: Kaustub Navalady,  Last Edit: 01/01/20
*/

void main() {
  runApp(SentApp());
}

// TODO:
// App needs to be made adaptive (current testing on iPhone 11 / 11 Pro Max)
// Change status bar color to black

class SentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Tabs(),
        ),
        ChangeNotifierProvider.value(
          value: Panel(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            accentColor: Colors.deepPurpleAccent,
            cursorColor: Colors.black),
        home: HomeScreen(),
        routes: {},
      ),
    );
  }
}
