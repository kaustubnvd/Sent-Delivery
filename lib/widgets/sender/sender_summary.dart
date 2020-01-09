import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../helpers/new_order.dart';
import '../../providers/tabs.dart';
import '../../providers/orders.dart';
import '../../widgets/chosen_user.dart';
import '../../widgets/summary_card.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20 (File refactored and renamed)
*/

class SenderSummary extends StatefulWidget {
  final PanelController panelController;

  SenderSummary(this.panelController);

  @override
  _SenderSummaryState createState() => _SenderSummaryState();
}

class _SenderSummaryState extends State<SenderSummary> {
  bool valid;

  bool validateForm(BuildContext context) {
    if (Provider.of<Tabs>(context, listen: false)
            .senderTitleController
            .text
            .isEmpty ||
        Provider.of<Tabs>(context, listen: false)
            .senderDescController
            .text
            .isEmpty) {
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
          packageTitle: Provider.of<Tabs>(context, listen: false)
              .senderTitleController
              .text,
          packageDesc: Provider.of<Tabs>(context, listen: false)
              .senderDescController
              .text,
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
                              "Congratulations! Your request has been initialized and will be posted once your receiver confirms it."),
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

  @override
  void initState() {
    valid = validateForm(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var titleText = Provider.of<Tabs>(context).senderTitleController.text;
    var subtitleText = Provider.of<Tabs>(context).senderDescController.text;
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ChosenUser(sender: false),
          ),
          SummaryCard(
            panelController: widget.panelController,
            titleText: titleText,
            subtitleText: subtitleText,
            sender: true,
          ),
          makeRequestButton(),
        ],
      ),
    );
  }
}
