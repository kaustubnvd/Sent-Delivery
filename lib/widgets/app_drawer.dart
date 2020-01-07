import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

// TODO: Make the SideDrawer Links and their respective page routes (Avi Ghayalod)

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 10),
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text(
                'Sent',
              ),
            ),
            // adds logout functionality  
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(
                  '/',
                ); // this is used to pop off the drawer so there is no error.
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
