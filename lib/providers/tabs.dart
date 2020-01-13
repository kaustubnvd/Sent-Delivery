import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/09/20 (Added Receiver Tab Data, minor name changes)
*/

class Tabs with ChangeNotifier {
  // List of the tab items (content of the circular tabs)
  static const tabColor = Colors.black;
  final _tabItems = [
    TabItem(
      Icons.arrow_forward_ios,
      "Send",
      tabColor,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.airport_shuttle,
      "Carry",
      tabColor,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.person_pin_circle,
      "Receive",
      tabColor,
    ),
  ];

  /*
    Sender Tab
  */

  var _receiverChosen = false;
  String _receiverName;
  var _senderTitleController = TextEditingController();
  var _senderDescController = TextEditingController();
  
  List<TabItem> get tabItems {
    return [..._tabItems];
  }

  void setReceiverChosen(bool chosen) {
    _receiverChosen = chosen;
    notifyListeners();
  }

  bool get receiverChosen {
    return _receiverChosen;
  }

  void setReceiverName(String name) {
    _receiverName = name;
    notifyListeners();
  }

  String get receiverName {
    return _receiverName;
  }

  void setSenderTempTitle(String title) {
    _saveFieldState(title, _senderTitleController);
  }

  void setSenderTempDesc(String desc) {
    _saveFieldState(desc, _senderDescController);
  }

  TextEditingController get senderTitleController {
    return _senderTitleController;
  }

  TextEditingController get senderDescController {
    return _senderDescController;
  }

  // Helper Method
  void _saveFieldState(String state, TextEditingController controller) {
    controller.value = TextEditingValue(
      text: state,
      selection: TextSelection.fromPosition( // Moves cursor to end
        TextPosition(offset: state.length),
      ),
    );
    notifyListeners();
  }

/*
  Carrier Tab
*/

var _notified = false;
var _carrierTab = true;

bool get notified {
  return _notified;
}

void toggleNotified() {
  _notified = !_notified;
  notifyListeners();
}

bool get carrierTab {
  return _carrierTab;
}

void setCarrierTab (bool carrier) {
  _carrierTab = carrier;
  notifyListeners();
}

/*
  Receiver Tab
*/

  var _senderChosen = false;
  String _senderName;
  var _receiverTitleController = TextEditingController();

   void setSenderChosen(bool chosen) {
    _senderChosen = chosen;
    notifyListeners();
  }

  bool get senderChosen {
    return _senderChosen;
  }

  void setSenderName(String name) {
    _senderName = name;
    notifyListeners();
  }

  String get senderName {
    return _senderName;
  }
  
  TextEditingController get receiverTitleController {
    return _receiverTitleController;
  }

  void setReceiverTempTitle(String title) {
    _saveFieldState(title, _receiverTitleController);
  }

}
