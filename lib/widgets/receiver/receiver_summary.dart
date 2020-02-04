import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sent/models/user.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../summary_card.dart';
import '../../helpers/new_order.dart';
import '../../providers/tabs.dart';
import '../../providers/orders.dart';
import '../../widgets/chosen_user.dart';


/*
    Authors: Kaustub Navalady, Last Edit: 02/03/20 (Added functionality to initialize phase 0 order)
*/

class ReceiverSummary extends StatefulWidget {
  final PanelController panelController;

  ReceiverSummary(this.panelController);

  @override
  _ReceiverSummaryState createState() => _ReceiverSummaryState();
}

// Note: There is redundant code very similar to the Sender Summary

class _ReceiverSummaryState extends State<ReceiverSummary> {
  User currentUser;
  bool valid;
  var _newOrderData = NewOrder.receiverNewOrderData;

  bool validateForm(BuildContext context) {
    if (Provider.of<Tabs>(context, listen: false)
            .receiverTitleController
            .text
            .isEmpty ||
        !NewOrder.validate()) {
      return false;
    }
    return true;
  }

  void saveForm() {
    Provider.of<Orders>(context, listen: false).addOrder(
      Order(
        orderId: _newOrderData["id"], // Will be provided by FireBase later
        senderId: Provider.of<Tabs>(context, listen: false)
            .senderId, // change name to ID
        receiverId: currentUser.uid,
        packageTitle: Provider.of<Tabs>(context, listen: false)
              .receiverTitleController
              .text,
        schoolName: _newOrderData["school"],
        dropoffLocation: _newOrderData["location"],
        dropoffTime: DateTime.parse(_newOrderData["time"]),
      ),
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
                    Provider.of<Tabs>(context, listen: false)
                        .setReceiverChosen(false);
                    Provider.of<Tabs>(context, listen: false)
                        .setSenderTempTitle("");
                    Provider.of<Tabs>(context, listen: false)
                        .setSenderTempDesc("");
                    Provider.of<Tabs>(context, listen: false)
                        .setSenderChosen(false);
                    Provider.of<Tabs>(context, listen: false)
                        .setReceiverTempTitle("");
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
                          content: Text(
                              "Congratulations! Your request has been initialized and will be posted once your sender confirms it."),
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
                : null),
      ),
    );
  }

    Future<void> _getUser() async {
    final user = await User.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  void initState() {
    valid = validateForm(context);
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var titleText = Provider.of<Tabs>(context).receiverTitleController.text;
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ChosenUser(sender: true),
          ),
          SummaryCard(
            panelController: widget.panelController,
            titleText: titleText,
            sender: false,
          ),
          makeRequestButton(),
        ],
      ),
    );
  }
}
