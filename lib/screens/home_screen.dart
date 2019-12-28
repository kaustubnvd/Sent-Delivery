import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_panel.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 12/28/19
*/

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (context) => Tabs(),
      child: Scaffold(
        drawer: AppDrawer(),
        backgroundColor: Colors.lightGreen,
        body: BottomPanel(),
      ),
    );
  }
}