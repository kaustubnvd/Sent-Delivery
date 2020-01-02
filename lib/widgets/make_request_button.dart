import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class MakeRequestButton extends StatefulWidget {
  final Function _saveForm;

  MakeRequestButton(this._saveForm);

  @override
  _MakeRequestButtonState createState() => _MakeRequestButtonState();
}

class _MakeRequestButtonState extends State<MakeRequestButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        child: RaisedButton(
          child: Text("Make Request"),
          textColor: Theme.of(context).primaryColor,
          color: Theme.of(context).accentColor,
          onPressed: () {
            if (widget._saveForm()) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Request Made"),
                    ),
                    content: Text(
                        "Congratulations! Your request has been initialized and will be posted once your receiver confirms it."),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: Text("Okay"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Provider.of<Tabs>(context, listen: false)
                              .setReceiverChosen(false);
                          Provider.of<Tabs>(context, listen: false)
                              .setSenderTempTitle("");
                          Provider.of<Tabs>(context, listen: false)
                              .setSenderTempDesc("");
                          Navigator.pushReplacementNamed(context, '/');
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
