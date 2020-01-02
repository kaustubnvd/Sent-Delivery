import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sent/widgets/sender/sender_summary_card.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import './sender_form.dart';
import '../../providers/panel.dart';
import '../../providers/tabs.dart';
import '../../widgets/search_bar.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

// TODO:
// Focus node search
// bugs (See HomeScreen)
// Provider & Server + loading indicator
// User link + Search users list // (Photo)
// Animations (dialog, panel)

class SenderTab extends StatelessWidget {
  final PanelController _panelController;

  SenderTab(this._panelController);

  @override
  Widget build(BuildContext context) {
    if (!Provider.of<Tabs>(context).receiverChosen) {
      return SearchBar(_panelController, "Who will be receiving the package?");
    } else {
      if (Provider.of<Panel>(context).panelOpen) {
        return SenderForm();
      } else {
        return SenderSummaryCard(_panelController);
      }
    }
  }
}
