import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/tabs.dart';
import './providers/panel.dart';
import './providers/orders.dart';
import './screens/root_screen.dart';
import './screens/auth_screen.dart';
import './screens/otp_screen.dart';
import './screens/user_info_screen.dart';
import './screens/home_screen.dart';
import './screens/settings_screen.dart';

/*
  Authors: Kaustub Navalady,  Last Edit: 01/15/20 (Added Settings to routes table)
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
            accentColor: Color.fromRGBO(0, 191, 219, 1),
            cursorColor: Colors.black),
        home: RootScreen(),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          OTPScreen.routeName: (ctx) => OTPScreen(),
          UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
        },
      ),
    );
  }
}
