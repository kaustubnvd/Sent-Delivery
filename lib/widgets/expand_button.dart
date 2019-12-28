import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 12/28/19
*/

// The small gray button on top of the panel
class ExpandButton extends StatefulWidget {
  final PanelController panelController;

  ExpandButton(this.panelController);

  @override
  _ExpandButtonState createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> {
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
          setState(() {
            widget.panelController.open();
          });
        },
      ),
    );
  }
}
