import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/menu_button.dart';
import '../widgets/panel_body.dart';
import '../providers/panel.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  // Controls the sizing of the panel
  PanelController _panelController;

  // Adjusts the margins in the panel to avoid clipping
  void adjustPanel(double val) {
    if (0 <= val && val <= .90) {
      setState(() {
        Provider.of<Panel>(context, listen: false).setPanelOpen(false);
        SystemChannels.textInput
            .invokeMethod('TextInput.hide'); // Hides soft-keyboard
      });
    } else {
      setState(() {
        Provider.of<Panel>(context, listen: false).setPanelOpen(true);
        SystemChannels.textInput
            .invokeMethod('TextInput.show'); // Shows soft-keyboard
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _panelController =
        Provider.of<Panel>(context, listen: false).panelController;
  }

  @override
  Widget build(BuildContext context) {
    var _panelOpen = Provider.of<Panel>(context).panelOpen;
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
      minHeight: .45 * MediaQuery.of(context).size.height,
      maxHeight: MediaQuery.of(context).size.height, // Device Height
    );
  }
}
