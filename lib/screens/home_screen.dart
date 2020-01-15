import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sent/screens/settings_screen.dart';

import '../widgets/app_drawer.dart';
import '../widgets/bottom_panel.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 01/09/20 (Made background transparent)
*/

// Bugs:
// Form Text Disappearing
// Keyboard not closing properly
// Cursor not moving where intended
// setState being called during build (provider calls)

class HomeScreen extends StatelessWidget {
  String mainProfilePic = "https://i.imgur.com/43HbdA7.jpg";
  String name = 'Avi Ghayalod';
  String email = 'aghayalod@gmail.com';

  static const routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents soft-keyboard from resizing content
      resizeToAvoidBottomPadding: false,
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(name),
              accountEmail: new Text(email),
              decoration:
              new BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0) ),
              currentAccountPicture: new GestureDetector(
                onTap: () => print('This is the current user'),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(mainProfilePic),
                ),
              ),
            ),
            new ListTile(
              title: new Text('How This Works'),
              leading: new Icon(
                Icons.info,
                color: Theme.of(context).accentColor,
              ),
            ),
            new ListTile(
              title: new Text('Payment'),
              leading: new Icon(
                Icons.payment,
                color: Theme.of(context).accentColor,
              ),
            ),
            new ListTile(
              title: new Text('Orders'),
              leading: new Icon(
                Icons.inbox,
                color: Theme.of(context).accentColor,
              ),
            ),
            new ListTile(
              title: new Text('Home'),
              leading: new Icon(
                Icons.home,
                color: Theme.of(context).accentColor,
              ),
              onTap:() => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new HomeScreen())),
            ),
            new ListTile(
              title: new Text('Help'),
              leading: new Icon(
                Icons.add_comment,
                color: Theme.of(context).accentColor,
              ),
            ),
            new ListTile(
              title: new Text('Settings'),
              leading: new Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
              onTap:() => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new SettingsPage(name, email, mainProfilePic))),
            ),
            new Divider(),
            new ListTile(
              title: new Text('Logout'),
              leading: new Icon(
                Icons.exit_to_app,
                color: Theme.of(context).accentColor,
              ),
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
      ),
      backgroundColor: Colors.transparent,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(
                new FocusNode()); // Click anywhere to get out of the form
          },
          child: BottomPanel()),
    );
  }
}
