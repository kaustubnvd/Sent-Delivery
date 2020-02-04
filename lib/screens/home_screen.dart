import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/bottom_panel.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/15/20 (Outsourced App Drawer widget)
*/

// Bugs:
// Form Text Disappearing
// Cursor not moving where intended
// setState being called during build (provider calls)

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents soft-keyboard from resizing content
      resizeToAvoidBottomPadding: false,
      drawer: AppDrawer(),
      backgroundColor: Colors.transparent,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode()); // Click anywhere to get out of the form
          },
          child: BottomPanel()),
    );
  }
}
