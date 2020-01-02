import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class Panel with ChangeNotifier {
  final _panelController = PanelController();
  var _panelOpen = false;

  PanelController get panelController {
    return _panelController;
  }

  bool get panelOpen {
    return _panelOpen;
  }

  void setPanelOpen(bool open) {
    _panelOpen = open;
    notifyListeners();
  }
}
