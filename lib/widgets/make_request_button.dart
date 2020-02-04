import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../helpers/new_order.dart';
import '../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20 
    (Made widget reusable for the receiver tab. Changed the final navigation pattern slightly)
*/

class MakeRequestButton extends StatefulWidget {
  final Function _saveForm;
  final bool _sender;

  MakeRequestButton(this._saveForm, this._sender);

  @override
  _MakeRequestButtonState createState() => _MakeRequestButtonState();
}

class _MakeRequestButtonState extends State<MakeRequestButton> {
  Widget formSubmitDialog() {
    var text = widget._sender ? "receiver" : "sender";
    return Text(
        "Congratulations! Your request has been initialized and will be posted once your $text confirms it.");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        child: RaisedButton(
          child: Text("Make Request"),
          textColor: Theme.of(context).primaryColor,
          color: Theme.of(context).accentColor,
          onPressed: () async {
            if (widget._saveForm()) {
              Provider.of<Tabs>(context, listen: false)
                  .setReceiverChosen(false);
              Provider.of<Tabs>(context, listen: false).setSenderTempTitle("");
              Provider.of<Tabs>(context, listen: false).setSenderTempDesc("");
              Provider.of<Tabs>(context, listen: false).setSenderChosen(false);
              Provider.of<Tabs>(context, listen: false).setReceiverTempTitle("");
              NewOrder.reset();
              Navigator.pushReplacementNamed(context, '/');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Request Made"),
                    ),
                    content: formSubmitDialog(),
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
          },
        ),
      ),
    );
  }
}
