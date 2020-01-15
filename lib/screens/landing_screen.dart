import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/14/20 
*/

// TODO:
// Fix navigation issue if the user goes back right after reCaptcha finishes

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 150),
              Center(
                child: Image.asset(
                  "assets/images/sent_logo.png",
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 80),
              Center(child: Text("Let's get started", style: TextStyle(fontFamily: "SFProDisplay", fontSize: 18, fontWeight: FontWeight.bold),)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Craving some home food? Is dorm food not cutting it? Send for some home-made delicacies! Or trying to make some quick cash? Sent has you covered.", textAlign: TextAlign.center,),
              ),
              SizedBox(height: 270),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: "SFProText"),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AuthScreen.routeName, arguments: false);
                },
                color: Theme.of(context).accentColor,
              ),
              FlatButton(
                child: Text(
                  "Login to Account",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AuthScreen.routeName, arguments: true);
                },
              )
            ],
          ),
        ),
      );
  }
}
