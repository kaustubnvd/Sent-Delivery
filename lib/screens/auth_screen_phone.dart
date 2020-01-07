import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/verification_dialog.dart';

// Screen not used currently. Can be used for phone authentication. 
// Dialog Screen bug - no dialog screen being shown to user
// Code reception bug - code is not being sent from firebase to the users cell.

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static const routeName = '/auth-login';

  String phoneNum;
  String smsCode;
  String verificationId;

  Future<void> verifyPhoneNum() async {
    // Waits for auto retrieval. If time expires, manual code entry occurs.
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    // manual code entry check
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('sign in');
      });
    };

    // successful verification scenario
    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) {
      print('verified');
    };

    // failed verification scenario. prints error.
    final PhoneVerificationFailed verifiedFail = (AuthException exception) {
      print('${exception.message}');
    };

    // sends the 6 digit verification id to the phone number
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNum,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(
          seconds:
              2), // the duration needs to be changed based on testing how fast auto login works.
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFail,
    );
  }

  // This code dialog is popped up once the user enters their phone number.
  // in the dialog the user can input their OTP and validate their phone number.
  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Please Enter The Texted Code'),
          content: TextField(
            onChanged: ((value) {
              this.smsCode = value;
            }),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text('Enter'),
              onPressed: () {
                FirebaseAuth.instance.currentUser().then((onValue) {
                  if (onValue != null) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                  } else {
                    Navigator.of(context).pop();
                    signIn();
                  }
                });
              },
            )
          ],
        );
      },
    );
  }

  // this sign in method checks the user's input.
  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user =
        await _auth.signInWithCredential(credential).then((user) {
      Navigator.of(context).pushReplacementNamed('/');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sent Logo',
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        onSaved: (input) => phoneNum = input,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 250.0,
                      child: RaisedButton(
                        onPressed: () {
                          verifyPhoneNum();
                        },
                        color: Colors.blue,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'done',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
