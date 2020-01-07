/*
  Authors: Suket Shah, Last Edit: 01/06/20
*/

import 'package:flutter/material.dart';

// Splash screen is used if the users internet connection is slow the authentication screen
// is taking time to load. 
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sent Logo',
            style: TextStyle(
              color: (Colors.black),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
