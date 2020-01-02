import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class Tabs with ChangeNotifier {
  // List of the tab items (content of the circular tabs)
  final _tabItems = [
    TabItem(
      Icons.arrow_forward_ios,
      "Send",
      Colors.black,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.airport_shuttle,
      "Carry",
      Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.person_pin_circle,
      "Receive",
      Colors.black,
    ),
  ];

  /*
    Sender Tab
  */

  var _receiverChosen = false;
  var _senderTitleController = TextEditingController();
  var _senderDescController = TextEditingController();
  String _receiverName;

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

  TextEditingController get titleController {
    return _senderTitleController;
  }

  TextEditingController get descController {
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
  Receiver Tab
*/

}
