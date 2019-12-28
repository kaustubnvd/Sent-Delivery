import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {
  static const Send = 0;
  static const Carry = 1;
  static const Receive = 2;
  final int selectedPos;
  
  TabContent(this.selectedPos);

  @override
  Widget build(BuildContext context) {
    // Dummy Containers
    switch (selectedPos) {
      case Send:
        return Container(
            height: 300,
            width: double.infinity,
            child: null,
            color: Colors.transparent);
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