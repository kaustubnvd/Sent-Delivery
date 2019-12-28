import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/expand_button.dart';
import '../widgets/circular_tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 12/28/19
*/

class PanelBody extends StatelessWidget {
  final bool panelOpen;
  final PanelController panelController;

  PanelBody(this.panelController, this.panelOpen); // TODO: Create a provider for these instance variables

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpandButton(panelController),
        SizedBox(
          height: panelOpen ? 30 : 5,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CircularTabs(),
        ),
      ],
    );
  }
}
