import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../helpers/new_order.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20
*/

class SummaryCard extends StatefulWidget {
  final PanelController panelController;
  final String titleText;
  final String subtitleText;
  final bool sender;

  SummaryCard({this.panelController, this.titleText, this.subtitleText, this.sender});

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    var _newOrderData = NewOrder.receiverNewOrderData;
    return InkWell(
      onLongPress: () {
        setState(() {
          widget.panelController.open();
        });
      },
      splashColor: Theme.of(context).accentColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Card(
          elevation: 6,
          child: ListTile(
            contentPadding: EdgeInsets.all(5),
            leading: widget.sender
                ? CircleAvatar( // If Sender Tab
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Theme.of(context).primaryColor,
                    child: FittedBox(child: Text("Photo")),
                    radius: 50,
                  )
                : CircleAvatar( // If Receiver Tab
                    radius: 50,
                    child: 
                      Image.network( // Temporary Image
                          "https://upload.wikimedia.org/wikipedia/en/thumb/e/e1/University_of_Texas_at_Austin_seal.svg/1200px-University_of_Texas_at_Austin_seal.svg.png"),
                  ),
            title: Text(
                widget.titleText == "" ? "Title" : widget.titleText,
              ),
            subtitle: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 10, maxHeight: 50),
              child: widget.sender
                  ? SingleChildScrollView(
                      child: Text(
                        widget.subtitleText == ""
                            ? "Description"
                            : widget.subtitleText,
                      ),
                    )
                  : SingleChildScrollView(child: (_newOrderData["location"] == null ||
                          _newOrderData["time"] == null)
                      ? Text("Details")
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(child: Text("${_newOrderData["location"]}")),
                            Text(
                                "${DateFormat.yMd().add_jm().format(DateTime.parse(_newOrderData["time"]))}"),
                          ],
                        ),
                  ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                widget.sender ? Icons.location_on : Icons.transit_enterexit,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
