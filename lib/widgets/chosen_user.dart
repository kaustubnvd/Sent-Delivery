import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class ChosenUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).accentColor,
        ),
        width: double.infinity,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Receiver:",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).primaryColor),
                ),
                Text(
                  "${Provider.of<Tabs>(context).receiverName}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Spacer(),
            FlatButton(
              child: Text(
                "Edit",
                style: TextStyle(color: Colors.black45),
              ),
              onPressed: () {
                Provider.of<Tabs>(context, listen: false)
                    .setReceiverChosen(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
