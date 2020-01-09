import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import './sender_form.dart';
import './sender_summary.dart';
import '../../providers/panel.dart';
import '../../providers/tabs.dart';
import '../../widgets/search_bar.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20 (Minor name changes)
*/

class SenderTab extends StatelessWidget {
  final PanelController _panelController;

  SenderTab(this._panelController);

  @override
  Widget build(BuildContext context) {
    if (!Provider.of<Tabs>(context).receiverChosen) {
      return SearchBar(_panelController, "Who will be receiving the package?", sender: false,);
    } else {
      if (Provider.of<Panel>(context).panelOpen) {
        return SenderForm();
      } else {
        return SenderSummary(_panelController);
      }
    }
  }
}
