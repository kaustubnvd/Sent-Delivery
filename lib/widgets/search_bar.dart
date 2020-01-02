import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class SearchBar extends StatefulWidget {
  final _textEditingController = TextEditingController();
  final _panelController;
  final String _headingText;

  SearchBar(this._panelController, this._headingText);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          widget._headingText,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
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
            onSubmitted: (String name) {
              Provider.of<Tabs>(context, listen: false).setReceiverName(name);
              Provider.of<Tabs>(context, listen: false).setReceiverChosen(true);
            },
          ),
        ),
      ],
    );
  }
}
