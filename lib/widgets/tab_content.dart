import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/sender/sender_tab.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
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
        return Container(
            height: 300,
            width: double.infinity,
            child: null,
            color: Colors.transparent);
        break;
      case Receive:
        return Container(
            height: 300,
            width: double.infinity,
            child: null,
            color: Colors.transparent);
        break;
      default:
        return Container(
            height: 300,
            width: double.infinity,
            child: null,
            color: Colors.transparent);
    }
  }
}
