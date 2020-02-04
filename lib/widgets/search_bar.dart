import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/user.dart';
import '../providers/tabs.dart';
import '../providers/panel.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 02/03/20 (Added searching users functionality)
*/

final usersRef = Firestore.instance.collection("users");

class SearchBar extends StatefulWidget {
  final _textEditingController = TextEditingController();
  final PanelController _panelController;
  final String _headingText;
  final bool sender;

  SearchBar(this._panelController, this._headingText, {@required this.sender});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Future<QuerySnapshot> _searchResults;

  // Gets search results based on searchQueries array in Firestore
  void handleSearch(String value) {
    Future<QuerySnapshot> users =
        usersRef.where("searchQueries", arrayContains: value).getDocuments();
    setState(() {
      _searchResults = users;
    });
  }
  
  Widget buildSearchResults() {
    return FutureBuilder(
        future: _searchResults,
        builder: (context, snapshot) {
          // Still fetching
          if (!snapshot.hasData) {
            return Center(child: CupertinoActivityIndicator());
          }
          // No Results
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text(
                "No Results Found.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          List<UserTile> users = [];
          snapshot.data.documents.forEach((DocumentSnapshot doc) {
            var user = User.fromDocument(doc);
            users.add(UserTile(
              otherUser: user,
              username: user.username,
              sender: widget.sender,
            ));
          });
          return ListView(children: users);
        });
  }

  // When the panel is closed, doesn't show search results
  Widget responsiveSearchResults(BuildContext context) {
    if (Provider.of<Panel>(context).panelOpen) {
      return Container(
        child: buildSearchResults(),
        height: 200,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Text(
          widget._headingText,
          style: TextStyle(fontSize: 20, fontFamily: "SFProDisplay"),
        ),
        SizedBox(height: 20),
        Container(
          width: 380,
          child: TextField(
            controller: widget._textEditingController,
            onTap: () {
              setState(
                () {
                  widget._panelController.open();
                },
              );
            },
            cursorColor: Theme.of(context).cursorColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              hintText: "Search Users",
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.grey,
              ),
            ),
            onChanged: handleSearch,
          ),
        ),
        responsiveSearchResults(context),
      ],
    );
  }
}

// Widget that is the tile for each search result
class UserTile extends StatelessWidget {
  final User otherUser;
  final String username;
  final bool sender;

  UserTile({this.otherUser, this.username, this.sender});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (!sender) { // Sender Tab
              Provider.of<Tabs>(context, listen: false)
                  .setReceiverName(otherUser);
              Provider.of<Tabs>(context, listen: false)
                  .setReceiverId(otherUser.uid);
              Provider.of<Tabs>(context, listen: false).setReceiverChosen(true);
            } else { // Receiver Tab
              Provider.of<Tabs>(context, listen: false)
                  .setSenderName(otherUser);
              Provider.of<Tabs>(context, listen: false)
                  .setSenderId(otherUser.uid);
              Provider.of<Tabs>(context, listen: false).setSenderChosen(true);
            }
          },
          splashColor: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                  foregroundColor: Color.fromRGBO(169, 169, 169, 1),
                  child: FittedBox(

                      child: Text(otherUser.displayName.substring(0, 1))),
                  radius: 20,
                ),
                title: Text(otherUser.displayName),
                subtitle: Text(username),
                trailing: Icon(
                  Icons.star,
                  color: Color.fromRGBO(253, 204, 13, 1),
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
