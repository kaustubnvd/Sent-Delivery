import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


// TODO: Make the SideDrawer Links and their respective page routes (Avi Ghayalod)

/*
    Last Edit: 01/14/2020 (Removed unnecessary authentication logic)
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
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pop(); // this is used to pop off the drawer so there is no error.
                  Navigator.of(context).pushReplacementNamed(
                    '/',
                  ); 
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
