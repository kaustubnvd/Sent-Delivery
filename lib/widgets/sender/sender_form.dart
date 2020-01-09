import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/orders.dart';
import '../../providers/tabs.dart';
import '../../widgets/chosen_user.dart';
import '../../widgets/make_request_button.dart';
import '../../widgets/package_title_field.dart';
import '../../widgets/package_description_field.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/09/20 (Minor name changes and constructor parameter additions)
*/

class SenderForm extends StatefulWidget {
  @override
  _SenderFormState createState() => _SenderFormState();
}

class _SenderFormState extends State<SenderForm> {
  final _descFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var newOrderData = {
    "id": DateTime.now().toString(),
    "sender": "Current User Id",
    "title": null,
    "description": null,
    "location": "Current Location",
    "photo": true,
  };

  bool _saveForm() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      Provider.of<Orders>(context, listen: false).addOrder(
        Order(
          orderId: newOrderData["id"], // Will be provided by FireBase later
          senderId: newOrderData["sender"],
          receiverId: Provider.of<Tabs>(context, listen: false)
              .receiverName, // change name to ID
          packageTitle: newOrderData["title"],
          packageDesc: newOrderData["description"],
          pickupLocation: newOrderData["location"],
          packageImage: newOrderData["photo"],
        ),
      );
      return true;
    }
    return false;
  }

  Widget formSpacing() {
    return SizedBox(
      height: 20,
    );
  }

  Widget pickupLocationField() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Pickup Location",
        hintText: "Current Location",
        filled: true,
        labelStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
      ),
      cursorColor: Theme.of(context).cursorColor,
    );
  }

  Widget imagePreview() {
    return Center(
      child: Container(
        color: Colors.black54,
        child: Card(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text("Photo"),
          ),
          elevation: 5,
        ),
        height: 150,
        width: 200,
      ),
    );
  }

  Widget cameraIconButton() {
    return Center(
      child: IconButton(
        icon: Icon(
          Icons.camera_alt,
          size: 40,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  void dispose() {
    _descFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _titleController = Provider.of<Tabs>(context).senderTitleController;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 760,
        width: double.infinity,
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ChosenUser(sender: false),
              formSpacing(),
              PackageTitleField(_descFocusNode, newOrderData, _titleController, true),
              formSpacing(),
              PackageDescriptionField(_descFocusNode, newOrderData),
              formSpacing(),
              pickupLocationField(),
              formSpacing(),
              imagePreview(),
              formSpacing(),
              cameraIconButton(),
              formSpacing(),
              MakeRequestButton(_saveForm, true),
            ],
          ),
        ),
      ),
    );
  }
}
