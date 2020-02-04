import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sent/models/user.dart';

import '../screens/home_screen.dart';
import '../screens/user_info_screen.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/21/20 (Added searchQueries field on user signup)
*/

final usersRef = Firestore.instance.collection("users");
final String timestamp = DateTime.now().toIso8601String();
User currentUser;

// Users can enter the 6-digit SMS code they receive
class OTPScreen extends StatefulWidget {
  static const routeName = "/otp-screen";
  final _smsCodeController = TextEditingController();
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _verificationId;
  String _smsCode;
  String _phoneNumber;

  _signInWithCode(BuildContext context) {
    // Gets the credentials required to sign in of the current user
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _smsCode);

    // Trys to sign in the user with the credentials
    FirebaseAuth.instance.signInWithCredential(credential).then((result) async {
      final FirebaseUser _user = await FirebaseAuth.instance.currentUser();
      if (result.additionalUserInfo.isNewUser) {
        await usersRef.document(_user.uid).setData({
          "uid": _user.uid,
          "name": "",
          "username": "",
          "phoneNumber": _phoneNumber,
          "rating": 5,
          "timestamp": timestamp,
          "searchQueries": [],
        });
        Navigator.of(context).pushReplacementNamed(UserInfoScreen.routeName,
            arguments: _user.uid);
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }

    }).catchError((error) {
      showDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("Error Occurred"),
              ),
              content: Text(
                  "Either the code is invalid, or you may have answered the reCaptcha too slowly. Please try again later."),
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
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _verificationId = routeArgs["code"];
    _phoneNumber = routeArgs["phoneNumber"];
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
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
              "Verification",
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Enter the 6 digit code sent to your mobile number.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: PinCodeTextField(
                length: 6,
                textInputType: TextInputType.number,
                obsecureText: false,
                animationType: AnimationType.fade,
                shape: PinCodeFieldShape.box,
                backgroundColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.black,
                activeColor: Theme.of(context).accentColor,
                selectedColor: Theme.of(context).accentColor,
                animationDuration: Duration(milliseconds: 300),
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                onChanged: (val) {
                  _smsCode = val;
                },
              ),
            ),
            RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).accentColor,
                child: Text(
                  "Verify Code",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  _signInWithCode(context);
                  widget._smsCodeController.clear();
                }),
          ],
        ),
      ),
    );
  }
}
