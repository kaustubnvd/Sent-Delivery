import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

// TODO: Make the SideDrawer Links and their respective page routes (Avi Ghayalod)

/*
    Last Edit: 01/09/2020 (Removed random appbar and spaced the logout link on the drawer)
*/

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 10),
        child: Container(
          height: 600,
          child: Column(
            children: <Widget>[
              Text(
                "Sent",
                style: TextStyle(fontSize: 24),
              ),
              Spacer(),
              // adds logout functionality
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pop(); // this is used to pop off the drawer so there is no error.
                  Navigator.of(context).pushReplacementNamed(
                    '/',
                  ); 
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
