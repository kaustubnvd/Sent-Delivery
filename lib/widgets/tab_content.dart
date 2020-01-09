import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/sender/sender_tab.dart';
import '../widgets/carrier/carrier_tab.dart';
import '../widgets/receiver/receiver_tab.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20 (Added receiver tab)
*/

class TabContent extends StatelessWidget {
  static const Send = 0;
  static const Carry = 1;
  static const Receive = 2;
  final int _selectedPos;
  final PanelController _panelController;

  TabContent(this._selectedPos, this._panelController);

  @override
  Widget build(BuildContext context) {
    switch (_selectedPos) {
      case Send:
        return SenderTab(_panelController);
        break;
      case Carry:
        return CarrierTab();
        break;
      case Receive:
        return ReceiverTab(_panelController);
        break;
      default:
        return Container();
    }
  }
}
