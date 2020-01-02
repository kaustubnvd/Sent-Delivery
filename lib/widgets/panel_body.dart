import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/expand_button.dart';
import '../widgets/circular_tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class PanelBody extends StatelessWidget {
  final bool _panelOpen;
  final PanelController _panelController;

  PanelBody(this._panelController, this._panelOpen);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpandButton(),
        SizedBox(
          height: _panelOpen ? 30 : 5,
        ),
        CircularTabs(_panelController)
      ],
    );
  }
}
