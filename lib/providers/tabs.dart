import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 12/28/19
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

  List<TabItem> get tabItems {
    return [..._tabItems];
  }

}