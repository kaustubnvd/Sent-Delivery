import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/auth_screen_login.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen_signup.dart';
import './providers/tabs.dart';
import './providers/panel.dart';
import './providers/orders.dart';
import './providers/auth.dart';

/*
  Authors: Kaustub Navalady,  Last Edit: 01/12/20 (Changed Theme accent color to cyan)
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
          value: Auth(),
        ),
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
child: Consumer<Auth>(
       builder: (ctx, auth, child) => MaterialApp(
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
             brightness: Brightness.light,
             primaryColor: Colors.white,
             accentColor: Color.fromRGBO(0, 191, 219, 1),
             cursorColor: Colors.black),
         home: auth.isAuth
             ? HomeScreen()
             : FutureBuilder(
                 future: auth.tryAutoLogin(),
                 builder: (ctx, authResultSnapshot) =>
                     authResultSnapshot.connectionState ==
                             ConnectionState.waiting
                         ? SplashScreen()
                         : AuthScreenSignup()),
         routes: {
           AuthScreenLogin.routeName: (ctx) => AuthScreenLogin(),
           AuthScreenSignup.routeName: (ctx) => AuthScreenSignup(),
           HomeScreen.routeName: (ctx) => HomeScreen(),
         },
       ),
     ),

    );
  }
}
