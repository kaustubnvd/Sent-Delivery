import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

/*
  Authors: Suket Shah, Last Edit: 01/06/20
*/

// https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
// possible future styling idea for the dialog.

// This widget is not being used. Originally planned to be used for phone auth. 

class VerificationDialog extends StatelessWidget {
  var _smsCode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Code'),
      content: TextField(
        onChanged: (value) => this._smsCode = value,
      ),
      contentPadding: EdgeInsets.all(12),
      actions: <Widget>[
        FlatButton(
          child: Text('Done'),
          onPressed: () {
            FirebaseAuth.instance.currentUser().then((user) {
              if (user != null) {
                Navigator.of(context).pushReplacementNamed(
                  '/',
                ); // change this to home screen once route table has been established.
              } else {
                Navigator.of(context).pop();
              }
            });
          },
        )
      ],
    );
  }
}
