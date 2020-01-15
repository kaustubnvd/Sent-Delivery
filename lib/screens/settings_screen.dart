import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
    Author: Avi Ghayalod, Minor Changes: Kaustub Navalady
*/

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings-screen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _name;
  String _phoneNumber;
  String _profilePic;

  // General List Item Widget
  Widget listItem(BuildContext context,
      {@required IconData icon,
      @required String text,
      @required Function onTap}) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        icon,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _name = routeArgs["name"];
    _phoneNumber = routeArgs["phoneNumber"];
    _profilePic = routeArgs["imageUrl"];
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Settings'),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: UserAccountsDrawerHeader(
              accountName: Text(_name),
              accountEmail: Text(_phoneNumber),
              currentAccountPicture: GestureDetector(
                onTap: () => print('This is the current user'),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_profilePic),
                ),
              ),
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
            ),
          ),
          listItem(context, text: 'Payment Info', icon: Icons.payment, onTap: () {}),
          listItem(context, text: 'Notifications', icon: Icons.notifications_none, onTap: () {}),
          listItem(context, text: 'Privacy', icon: Icons.lock, onTap: () {}),
          listItem(context, text: 'Terms and Conditions', icon: Icons.library_books, onTap: () {}),
          ListTile(
            title: Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context).pop();
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          )
        ],
      ),
    );
  }
}
