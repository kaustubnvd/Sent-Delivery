import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../screens/home_screen.dart';
import '../screens/otp_screen.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/14/20 
*/

final usersRef = Firestore.instance.collection("users");

// Users enter their phone number for verification
class AuthScreen extends StatefulWidget {
  static const routeName = "/auth-screen";
  // Adds the dashes between the numbers (dependency)
  final _phoneNumController = MaskedTextController(mask: "000-000-0000");
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _verificationId; // Serves as a validation token when signing in manually
  var codeSent = false;
  bool login; // Get Started | Login to Account 
  var _validate = false; // Text Field Validator

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    String phoneNumber = "+1${widget._phoneNumController.text}";
    final _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      // auto-retreival timeout
      timeout: Duration(seconds: 0), // (Disabled auto-retreival as it rarely works)
      verificationCompleted: (authCredential) =>
          _verificationComplete(authCredential, context),
      verificationFailed: (authException) =>
          _verificationFailed(authException, context),
      // called after auto-retrieval timeout
      codeAutoRetrievalTimeout: (verificationId) =>
          _codeAutoRetrievalTimeout(verificationId),
      // called when the SMS code is sent
      codeSent: (verificationId, [code]) =>
          _smsCodeSent(verificationId, [code]),
    );
  }

  // Call-back Function
  _verificationComplete(AuthCredential authCredential, BuildContext context) {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((result) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }

  // Call-back Function
  _verificationFailed(AuthException authException, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Verification Failed"),
          ),
          content: Text(authException.message.toString()),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  // called when the SMS code is sent
  _smsCodeSent(String verificationId, List<int> code) {
    // set the verification code to log the user in
    _verificationId = verificationId;
  }
  
  // called after auto-retrieval timeout
  _codeAutoRetrievalTimeout(String verificationId) {
    // set the verification code to log the user in
    _verificationId = verificationId;
  }

  _phoneAuthentication(BuildContext context) async {
    _verifyPhoneNumber(context);
    codeSent = true;
    // Can't find an alternative to this hack. Perhaps improvable with Apple Developer Account ($100) to enable 
    // silent push notifications (in order to bypass reCaptcha)
    // If I don't do this, the Navigator will be called immediately, causing a null '_verificationId' to be sent
    Future.delayed(Duration(seconds: 6, milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          OTPScreen.routeName, (Route<dynamic> route) => false, arguments: {
        'code': _verificationId,
        'phoneNumber': widget._phoneNumController.text
      });
      widget._phoneNumController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    login = ModalRoute.of(context).settings.arguments;
    return Scaffold(
       // Prevents soft-keyboard from resizing content
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 40),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed:
                        codeSent ? null : () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  "assets/images/sent_logo.png",
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 80),
              Center(
                  child: Text(
                "Mobile Authentication",
                style: TextStyle(
                    fontFamily: "SFProDisplay",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "Enter your phone number to verify your account.",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: widget._phoneNumController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          prefixText: "+1 ",
                          errorText: _validate ? "Please provide a valid phone number." : null,
                          errorBorder: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      codeSent
                          ? CupertinoActivityIndicator()
                          : RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Theme.of(context).accentColor,
                              child: Text(
                                "Send Code",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () async {
                                // Basic text field error validation
                                if(widget._phoneNumController.text.length < 12) {
                                  setState(() {
                                    _validate = true;
                                  });
                                  return;
                                } else {
                                    _validate = false;
                                }
                                // Gets a snapshot of the documents + metadata
                                // Checking whether the phone number the user entered is already in firestore
                                final QuerySnapshot snapshot = await usersRef
                                    .where(
                                      "phoneNumber",
                                      isEqualTo:
                                          widget._phoneNumController.text,
                                    )
                                    .getDocuments();
                                // If there are no such users
                                if (snapshot.documents.isEmpty) {
                                  // And if we are trying to create an account
                                  if (!login) {
                                    _phoneAuthentication(context);
                                  } else { // And if we are trying to login
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return CupertinoAlertDialog(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text("Account Not Found"),
                                            ),
                                            content: Text(
                                                "No account with this number was found. Please try creating an account."),
                                          );
                                        });
                                  }
                                } else { // If there is a user with the entered phone number in firestore
                                // And if we are trying to create an account
                                  if (!login) {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return CupertinoAlertDialog(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text("Existing Account"),
                                            ),
                                            content: Text(
                                                "An account with this number already exists. Please try logging in."),
                                          );
                                        });
                                  } else { // And if we are trying to login
                                    _phoneAuthentication(context);
                                  }
                                }
                              }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
