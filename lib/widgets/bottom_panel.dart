import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/menu_button.dart';
import '../widgets/panel_body.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 12/28/19
*/

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  var _panelController = PanelController(); // Controls the sizing of the panel
  var _panelOpen = false;

  // Adjusts the margins in the panel to avoid clipping
  void adjustPanel(double val) {
    if (0 <= val && val <= .90) {
      setState(() {
        _panelOpen = false;
      });
    } else {
      setState(() {
        _panelOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      // Body == Content behind the panel
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MenuButton(), // Opens Side Drawer
          SizedBox(
            height: 300,
          ),
          Center(child: Text("Google Maps")), // Placeholder
        ],
      ),
      controller: _panelController,
      onPanelSlide: (double val) => adjustPanel(val),
      panel: PanelBody(_panelController, _panelOpen), // Content of panel
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      color: Theme.of(context).primaryColor,
      minHeight: 400,
      maxHeight: MediaQuery.of(context).size.height,
    );
  }
}
