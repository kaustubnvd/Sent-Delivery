import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/menu_button.dart';
import '../widgets/panel_body.dart';
import '../providers/panel.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/15/20 (Fixed Keyboard Bug)
*/

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  // Controls the sizing of the panel
  PanelController _panelController;
  double screenSize;
  var init = false;

  // Adjusts the margins in the panel to avoid clipping
  void adjustPanel(double val) {
    if (0 <= val && val <= .90) {
      setState(() {
        Provider.of<Panel>(context, listen: false).setPanelOpen(false);
      });
    } else {
      setState(() {
        Provider.of<Panel>(context, listen: false).setPanelOpen(true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    adjustPanel(0); // weird bug appeared
    _panelController =
        Provider.of<Panel>(context, listen: false).panelController;
  }

  @override
  void didChangeDependencies() {
    if (!init) {
      init = true;
      screenSize = MediaQuery.of(context).size.height;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _panelOpen = Provider.of<Panel>(context).panelOpen;
    return SlidingUpPanel(
      // Body == Content behind the panel
      body: Stack(
        children: <Widget>[
          Container(
            height: (.60 * screenSize).toInt().toDouble(),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(30.2849, -97.7341),
                zoom: 15,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              padding: EdgeInsets.only(bottom: 45),
            ),
          ),
          MenuButton(),
        ],
      ),
      controller: _panelController,
      onPanelSlide: (double val) => adjustPanel(val),
      onPanelClosed: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      panel: PanelBody(_panelController, _panelOpen), // Content of panel
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      color: Theme.of(context).primaryColor,
      minHeight: (.45 * screenSize).toInt().toDouble(),
      maxHeight: screenSize, // Device Height
    );
  }
}
