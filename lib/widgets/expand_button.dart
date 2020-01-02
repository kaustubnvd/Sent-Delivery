import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../providers/panel.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

// The small gray button on top of the panel
class ExpandButton extends StatefulWidget {
  @override
  _ExpandButtonState createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> {
  PanelController
      _panelController; // Since state doesn't change, I can use the provider

  @override
  void initState() {
    super.initState();
    _panelController =
        Provider.of<Panel>(context, listen: false).panelController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: 55,
      height: 4,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(250)),
      child: RaisedButton(
        elevation: 0,
        color: Color.fromRGBO(220, 220, 220, 1),
        splashColor: Colors.transparent,
        onPressed: () {
          setState(
            () {
              _panelController.open();
            },
          );
        },
      ),
    );
  }
}
