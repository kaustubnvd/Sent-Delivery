import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';

import '../providers/tabs.dart';
import '../widgets/tab_content.dart';

/* 
    Authors: Kaustub Navalady, Last Edit: 12/28/19
*/

class CircularTabs extends StatefulWidget {
  @override
  _CircularTabsState createState() => _CircularTabsState();
}

class _CircularTabsState extends State<CircularTabs> {
  CircularBottomNavigationController
      _navigationController; // Controls the tab navigation
  var _selectedPos = 0;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(_selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    var _tabItems = Provider.of<Tabs>(context, listen: false).tabItems;
    return Column(
      children: <Widget>[
        CircularBottomNavigation(
          _tabItems,
          controller: _navigationController,
          barBackgroundColor: Theme.of(context).primaryColor,
          animationDuration: Duration(milliseconds: 300),
          selectedCallback: (int selectedPos) {
            setState(() {
              this._selectedPos = selectedPos;
            });
          },
        ),
        TabContent(_selectedPos), // Content of each tab item
      ],
    );
  }
}
