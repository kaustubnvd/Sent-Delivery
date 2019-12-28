import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (context) => Tabs(),
      child: Scaffold(
        drawer: null,
        backgroundColor: Colors.lightGreen,
        body: null,
      ),
    );
  }
}