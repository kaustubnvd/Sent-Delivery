import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home_screen.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/14/20 
*/

final _usersRef = Firestore.instance.collection("users"); // User's collection in Firestore

// First time users enter their info (Name, card details, etc.)
class UserInfoScreen extends StatefulWidget {
  static const routeName = "/user-info";
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _form = GlobalKey<FormState>();
  String _uid; // User ID
  String _name;

  bool _saveForm() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      _usersRef.document("$_uid").get().then((doc) {
        var _userData = doc.data;
        _userData["name"] = _name;
        _usersRef.document("$_uid").setData(_userData);
      }).catchError((error) => print(error.toString()));
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _uid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Center(
                child: Text(
                  "Registration",
                  style: TextStyle(
                      fontFamily: "SFProDisplay",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "Enter your first and last name. You can skip the card details, but they are required to properly use the app.",
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.length < 5) {
                            return "Please provide a valid full name.";
                          }
                          return null;
                        },
                        onSaved: (text) {
                          _name = text;
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(),
                    SizedBox(height: 5),
                    /*
                     Card detail inputs are dummy fields at the moment
                    */
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Card Number",
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Expiry Date",
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).accentColor,
                child: Text(
                  "Register",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  if (_saveForm()) {
                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
