import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class PackageTitleField extends StatefulWidget {
  final FocusNode _descFocusNode;
  final Map<String, Object> _newOrderData;

  PackageTitleField(this._descFocusNode, this._newOrderData);

  @override
  _PackageTitleFieldState createState() => _PackageTitleFieldState();
}

class _PackageTitleFieldState extends State<PackageTitleField> {

  @override
  Widget build(BuildContext context) {
    var _titleController = Provider.of<Tabs>(context).titleController;
    return TextFormField(
      controller: _titleController,
      textInputAction: TextInputAction.next,
      onChanged: (String val) {
        Provider.of<Tabs>(context, listen: false).setSenderTempTitle(val);
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(
            widget._descFocusNode); // Moves cursor to description field
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Please provide a title.";
        }
        return null;
      },
      onSaved: (value) {
        widget._newOrderData['title'] = value;
      },
      decoration: InputDecoration(
        labelText: "Package Title",
        filled: true,
        labelStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
      ),
      cursorColor: Theme.of(context).cursorColor,
    );
  }
}
