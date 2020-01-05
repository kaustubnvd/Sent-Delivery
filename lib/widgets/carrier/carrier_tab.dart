import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/04/20
*/

// TODO:
// Make widget more lean

class CarrierTab extends StatefulWidget {
  @override
  _CarrierTabState createState() => _CarrierTabState();
}

class _CarrierTabState extends State<CarrierTab> {
  var init = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 160,
                height: 160,
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: CircleAvatar(
                          child: Icon(Icons.list,
                              color: Theme.of(context).primaryColor),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Current Listings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 160,
                height: 160,
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: CircleAvatar(
                          child: Icon(Icons.event,
                              color: Theme.of(context).primaryColor),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Active Orders",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          FlatButton.icon(
            icon: Provider.of<Tabs>(context).notified
                ? Icon(
                    Icons.notifications_active,
                    color: Theme.of(context).accentColor,
                  )
                : Icon(Icons.notifications_paused),
            label: Text("Notifications"),
            onPressed: () {
              Provider.of<Tabs>(context, listen: false).toggleNotified();
            },
          )
        ],
      ),
    );
  }
}
