import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sent/models/user.dart';

import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/card_auth_screen.dart';

/*
    Author: Avi Ghayalod, Minor Changes: Kaustub Navalady
    Last Edit: 01/15/2020 (Added SideDrawer Links)
*/

final usersRef = Firestore.instance.collection("users");


class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User currentUser;
  final String _mainProfilePic = "https://i.imgur.com/43HbdA7.jpg";
  final String _name = "Avi Ghayalod";
  final String _phoneNumber = "651-555-1234";

  Widget listItem(BuildContext context,
      {@required IconData icon,
      @required String text,
      @required Function onTap}) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      onTap: onTap,
    );
  }

  getUser() async {
    final user = await User.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  void initState(){
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(currentUser == null ? "Account Name" : currentUser.displayName),
            accountEmail: Text(currentUser == null ? "@user-name" : currentUser.username),
            decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
            currentAccountPicture: GestureDetector(
              onTap: () => print('This is the current user'),
              child: CircleAvatar(
                backgroundImage: NetworkImage(_mainProfilePic),
              ),
            ),
          ),
          listItem(context, text: 'Home', icon: Icons.home, onTap: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }),
          listItem(context,
              text: 'Notifications', icon: Icons.notifications, onTap: () {}),
          listItem(context, text: 'Orders', icon: Icons.inbox, onTap: () {}),
          listItem(context, text: 'Payment', icon: Icons.payment, onTap: () {
            Navigator.of(context).pushNamed(CardAuthScreen.routeName);
          }),
          listItem(context,
              text: 'How This Works', icon: Icons.info, onTap: () {}),
          listItem(context,
              text: 'Help', icon: Icons.help_outline, onTap: () {}),
          listItem(context, text: 'Settings', icon: Icons.settings, onTap: () {
            Navigator.of(context)
                .pushNamed(SettingsScreen.routeName, arguments: {
              "name": _name,
              "phoneNumber": _phoneNumber,
              "imageUrl": _mainProfilePic,
            });
          }),
          Divider(),
          listItem(context, text: 'Logout', icon: Icons.exit_to_app, onTap: () {
            Navigator.of(context).pop();
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed('/');
          }),
        ],
      ),
    );
  }
}
