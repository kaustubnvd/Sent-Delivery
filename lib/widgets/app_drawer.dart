import 'package:flutter/material.dart';

// TODO: Make the SideDrawer Links and their respective page routes (Avi Ghayalod)

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 10),
        child: Text(
          "Sent",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}