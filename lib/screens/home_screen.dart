import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/bottom_panel.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

// Bugs:
// Form Text Disappearing
// Keyboard not closing properly
// Cursor not moving where intended

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents soft-keyboard from resizing content
      resizeToAvoidBottomPadding: false,
      drawer: AppDrawer(),
      backgroundColor: Colors.lightGreen,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(
                new FocusNode()); // Click anywhere to get out of the form
          },
          child: BottomPanel()),
    );
  }
}
