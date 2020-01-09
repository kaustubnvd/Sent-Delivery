import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/08/20 (Minor variable name change)
*/

class PackageDescriptionField extends StatefulWidget {
  final FocusNode _descFocusNode;
  final Map<String, Object> _newOrderData;

  PackageDescriptionField(this._descFocusNode, this._newOrderData);

  @override
  _PackageDescriptionFieldState createState() =>
      _PackageDescriptionFieldState();
}

class _PackageDescriptionFieldState extends State<PackageDescriptionField> {
  @override
  Widget build(BuildContext context) {
    var _descController = Provider.of<Tabs>(context).senderDescController;
    return TextFormField(
      controller: _descController,
      validator: (value) {
        if (value.isEmpty) {
          return "Please provide a description.";
        }
        return null;
      },
      onChanged: (String val) {
        // Keeps track of what is currently entered
        Provider.of<Tabs>(context, listen: false).setSenderTempDesc(val);
      },
      onSaved: (value) {
        widget._newOrderData["description"] = value;
      },
      decoration: InputDecoration(
        labelText: "Package Description",
        filled: true,
        labelStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
      ),
      maxLength: 120,
      maxLines: 4,
      focusNode: widget._descFocusNode,
      keyboardType: TextInputType.multiline,
      cursorColor: Theme.of(context).cursorColor,
    );
  }
}
