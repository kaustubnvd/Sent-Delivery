import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import './receiver_form.dart';
import './receiver_summary.dart';
import '../../providers/tabs.dart';
import '../../providers/panel.dart';
import '../../widgets/search_bar.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20
*/

class ReceiverTab extends StatelessWidget {
  final PanelController _panelController;

  ReceiverTab(this._panelController);

  @override
  Widget build(BuildContext context) {
    if (!Provider.of<Tabs>(context).senderChosen) {
      return SearchBar(_panelController, "Who will be sending the package?", sender: true,);
    } else {
      if (Provider.of<Panel>(context).panelOpen) {
        return ReceiverForm();
      } else {
        return ReceiverSummary(_panelController);
      }
    }
  }
}
