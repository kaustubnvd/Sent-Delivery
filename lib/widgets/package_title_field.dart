import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tabs.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20 (Made widget reusable for the receiver tab)
*/

class PackageTitleField extends StatefulWidget {
  final FocusNode _descFocusNode;
  final Map<String, Object> _newOrderData;
  final TextEditingController _titleController;
  final bool sender; // Variable to mark whether intended for sender or receiver tab

  PackageTitleField(this._descFocusNode, this._newOrderData,
      this._titleController, this.sender);

  @override
  _PackageTitleFieldState createState() => _PackageTitleFieldState();
}

class _PackageTitleFieldState extends State<PackageTitleField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._titleController,
      textInputAction: TextInputAction.next,
      onChanged: (String val) {
        if (widget.sender) {
          Provider.of<Tabs>(context, listen: false).setSenderTempTitle(val);
        } else {
          Provider.of<Tabs>(context, listen: false).setReceiverTempTitle(val);
        }
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
        widget._newOrderData["title"] = value;
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
