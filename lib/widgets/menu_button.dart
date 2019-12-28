import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60, left: 15),
      child: FloatingActionButton(
        child: Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}