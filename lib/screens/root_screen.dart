import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../screens/landing_screen.dart';
import '../screens/home_screen.dart';


/*
  Authors: Kaustub Navalady, Last Edit: 01/14/20 
*/

// This class displays the respective page depending on whether
// the user is already logged in or not
class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

enum AuthStatus { notSignedIn, signedIn, loading }

class _RootScreenState extends State<RootScreen> {
  var _authStatus = AuthStatus.loading;

  @override
  void initState() {
    super.initState();
    // If the user token is present
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _authStatus =
            user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return LandingScreen();
        break;
      case AuthStatus.signedIn:
        return HomeScreen();
        break;
      default:
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
    }
  }
}
