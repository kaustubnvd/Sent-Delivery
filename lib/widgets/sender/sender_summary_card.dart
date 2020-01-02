import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sent/widgets/chosen_user.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../providers/tabs.dart';
import '../../providers/orders.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class SenderSummaryCard extends StatefulWidget {
  final PanelController panelController;

  SenderSummaryCard(this.panelController);

  @override
  _SenderSummaryCardState createState() => _SenderSummaryCardState();
}

class _SenderSummaryCardState extends State<SenderSummaryCard> {
  bool valid;

  bool validateForm(BuildContext context) {
    if (Provider.of<Tabs>(context, listen: false)
            .titleController
            .text
            .isEmpty ||
        Provider.of<Tabs>(context, listen: false).descController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void saveForm() {
    Provider.of<Orders>(context, listen: false).addOrder(
      Order(
          orderId: DateTime.now().toString(), // provided by firebase so remove
          senderId: "Current User Id",
          receiverId: Provider.of<Tabs>(context, listen: false)
              .receiverName, // change name to ID
          packageTitle:
              Provider.of<Tabs>(context, listen: false).titleController.text,
          packageDesc:
              Provider.of<Tabs>(context, listen: false).descController.text,
          pickupLocation: "Current Location",
          packageImage: true),
    );
  }

  Widget makeRequestButton() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        width: 250,
        child: RaisedButton(
            child: Text("Make Request"),
            textColor: Theme.of(context).primaryColor,
            color: Theme.of(context).accentColor,
            onPressed: valid
                ? () {
                    saveForm();
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
                : null),
      ),
    );
  }

  @override
  void initState() {
    valid = validateForm(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var titleText = Provider.of<Tabs>(context).titleController.text;
    var subtitleText = Provider.of<Tabs>(context).descController.text;
    return InkWell(
      // Extract in the future
      onLongPress: () {
        setState(() {
          widget.panelController.open();
        });
      },
      splashColor: Theme.of(context).accentColor,
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ChosenUser(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                elevation: 6,
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Theme.of(context).primaryColor,
                    child: FittedBox(child: Text("Photo")),
                    radius: 50,
                  ),
                  title: Text(
                    titleText == "" ? "Title" : titleText,
                  ),
                  subtitle: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 10, maxHeight: 50),
                    child: SingleChildScrollView(
                      child: Text(
                          subtitleText == "" ? "Description" : subtitleText),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.location_on,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            makeRequestButton(),
          ],
        ),
      ),
    );
  }
}
