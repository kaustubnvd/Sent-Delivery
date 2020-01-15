import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class SettingsPage extends StatelessWidget {
  final name;
  final email;
  final profilePic;

  SettingsPage(this.name, this.email, this.profilePic);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CupertinoNavigationBar(
        middle: new Text('Settings'),
        leading: GestureDetector(
          child: new Icon(
            CupertinoIcons.clear,
          ),
          onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => new HomeScreen())),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(name),
            accountEmail: new Text(email),
            currentAccountPicture: new GestureDetector(
              onTap: () => print('This is the current user'),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(profilePic),
              ),
            ),
            decoration: new BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
          ),
          new ListTile(
            title: new Text('Payment Info'),
            leading: Icon(Icons.payment),
          ),
          new ListTile(
            title: new Text('Notifications'),
            leading: Icon(Icons.notifications),
          ),
          new ListTile(
            title: new Text('Privacy'),
            leading: Icon(Icons.lock),
          ),
          new ListTile(
            title: new Text('Legal'),
            leading: Icon(Icons.library_books),
          ),
          new ListTile(
            title:
                new Text('Sign Out', style: new TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context)
                  .pop(); // this is used to pop off the drawer so there is no error.
              Navigator.of(context).pushReplacementNamed(
                '/',
              );
              Provider.of(context).logout();
            },
          )
        ],
      ),
    );
  }
}
