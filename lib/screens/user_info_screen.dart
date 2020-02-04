import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sent/screens/otp_screen.dart';

import '../screens/home_screen.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/14/20 
*/

final _usersRef =
    Firestore.instance.collection("users"); // User's collection in Firestore

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
  String _username;
  var _nameAvailable = false;

  List<String> setSearchParams(String name) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  bool _saveForm() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      _usersRef.document("$_uid").get().then((doc) {
        var _userData = doc.data;
        _userData["name"] = _name;
        _userData["username"] = _username;
        _userData["searchQueries"] = setSearchParams(_name);
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
                  "Set up your Profile",
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
                  "Enter your first and last name. Also enter a username so that other users can easily find you",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: CircleAvatar(
                radius: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(child: Text("Add Profile Pic")),
                ),
              )),
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            prefixText: "@",
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            suffixIcon: _nameAvailable
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_off,
                                    color: Colors.red,
                                  )),
                        onChanged: (val) async {
                          final QuerySnapshot snapshot = await usersRef
                              .where("username", isEqualTo: "@" + val)
                              .getDocuments();
                          if (snapshot.documents.isNotEmpty || val.length < 5) {
                            setState(() {
                              _nameAvailable = false;
                            });
                          } else if (val.length >= 5) {
                            setState(() {
                              _nameAvailable = true;
                            });
                          }
                        },
                        validator: (value) {
                          if (value.length < 5) {
                            return "This username is too short.";
                          }
                          return _nameAvailable
                              ? null
                              : "This username is already taken.";
                        },
                        onSaved: (text) {
                          _username = "@" + text;
                        },
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
                  "Create Account",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  if (_saveForm()) {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
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
