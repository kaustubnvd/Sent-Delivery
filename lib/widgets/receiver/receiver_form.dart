import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sent/models/user.dart';

import '../../providers/tabs.dart';
import '../../providers/orders.dart';
import '../../widgets/chosen_user.dart';
import '../../widgets/package_title_field.dart';
import '../../widgets/make_request_button.dart';
import '../../helpers/new_order.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 02/03/20 (Added functionality to initialize phase 0 order)
*/

class ReceiverForm extends StatefulWidget {
  @override
  _ReceiverFormState createState() => _ReceiverFormState();
}

class _ReceiverFormState extends State<ReceiverForm> {
  User currentUser;
  LocationData location;
  final _nextFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _schoolChosen = false;
  var _newOrderData = NewOrder.receiverNewOrderData;

  bool otherFieldsValidate() {
    if (_newOrderData["school"] == null ||
        _newOrderData["school"] == null ||
        _newOrderData["time"] == null) {
      showDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("Missing Input"),
              ),
              content: Text(
                  "Please make sure to complete all the fields before making a request."),
            );
          });
      return false;
    }
    return true;
  }

  // Adds an order
  bool _saveForm() {
    final isValid = _form.currentState.validate() && otherFieldsValidate();
    if (isValid) {
      _form.currentState.save();
      Provider.of<Orders>(context, listen: false).addOrder(
        Order(
          orderId: _newOrderData["id"], // Will be provided by FireBase later
          senderId: Provider.of<Tabs>(context, listen: false)
              .senderId, // change name to ID
          receiverId: currentUser.uid,
          packageTitle: _newOrderData["title"],
          schoolName: _newOrderData["school"],
          dropoffLocation: _newOrderData["location"],
          dropoffTime: DateTime.parse(_newOrderData["time"]),
        ),
      );
      return true;
    }
    return false;
  }

  // Gray colored background container styled to look like a read-only, filled textField
  Widget fieldResult(String title, String body, Function onEdit) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: double.infinity,
      height: 58,
      color: Color.fromRGBO(245, 245, 245, 1),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              SizedBox(height: 2),
              Text(
                body,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
          Spacer(),
          FlatButton(
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.black45),
            ),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }

  // Shows the school picker
  void showSchoolPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                CupertinoPicker(
                  onSelectedItemChanged: (item) {
                    if (item == 1) {
                      _newOrderData["school"] = "University of Texas at Austin";
                    }
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  itemExtent: 45,
                  diameterRatio: 3 / 2,
                  children: <Widget>[
                    null,
                    Center(
                      child: Text(
                        "University of Texas at Austin",
                        style: TextStyle(fontFamily: "SFProText"),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CupertinoButton(
                      child: Text("Done"),
                      onPressed: () {
                        if (_newOrderData["school"] != null) {
                          _schoolChosen = true;
                        }
                        setState(() {});
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
          );
        });
  }

  // Widget to choose the school
  Widget schoolField(BuildContext context) {
    if (_newOrderData["school"] == null) {
      return FlatButton(
          child: Text(
            "Choose School",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            showSchoolPicker();
          });
    } else {
      return fieldResult("School", _newOrderData["school"], showSchoolPicker);
    }
  }

  // Shows location picker
  void showDropoffLocationPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                CupertinoPicker(
                  onSelectedItemChanged: (item) {
                    if (item == 0) {
                      _newOrderData["location"] = "Gregory Gym Plaza";
                    } else if (item == 1) {
                      _newOrderData["location"] = "In Front of PCL";
                    } else if (item == 2) {
                      _newOrderData["location"] = "Honors Quad Yard";
                    } else {
                      _newOrderData["location"] =
                          "Outside Starbucks in West Campus";
                    }
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  itemExtent: 45,
                  diameterRatio: 1,
                  children: <Widget>[
                    Center(
                        child: Text(
                      "Gregory Gym Plaza",
                      style: TextStyle(fontFamily: "SFProText"),
                    )),
                    Center(
                        child: Text("In Front of PCL",
                            style: TextStyle(fontFamily: "SFProText"))),
                    Center(
                        child: Text("Honors Quad Yard",
                            style: TextStyle(fontFamily: "SFProText"))),
                    Center(
                        child: Text("Outside Starbucks in West Campus",
                            style: TextStyle(fontFamily: "SFProText"))),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CupertinoButton(
                      child: Text("Done"),
                      onPressed: () {
                        setState(() {});
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
          );
        });
  }

  // Widget to pick dropoff location
  Widget hotspotField(BuildContext context) {
    if (_newOrderData["location"] == null) {
      return FlatButton(
          child: Text(
            "Choose Dropoff Location",
            style: TextStyle(
                color: !_schoolChosen
                    ? Colors.grey
                    : Theme.of(context).accentColor),
          ),
          onPressed: !_schoolChosen
              ? null
              : () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDropoffLocationPicker();
                });
    } else {
      return fieldResult("Dropoff Location", _newOrderData["location"],
          showDropoffLocationPicker);
    }
  }

  // Shows DatePicker
  void showDatePicker() {
    final minDate = DateTime.now().subtract(Duration(days: 1));
    final difference = 30 - minDate.minute % 30;
    final initialDate = minDate.add(Duration(minutes: difference));
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: <Widget>[
                CupertinoDatePicker(
                  minimumDate: minDate,
                  maximumDate: minDate.add(Duration(days: 7)),
                  initialDateTime: initialDate,
                  minuteInterval: 30,
                  onDateTimeChanged: (dateTime) {
                    if (dateTime.isAfter(minDate.add(Duration(days: 1)))) {
                      _newOrderData["time"] = dateTime.toIso8601String();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CupertinoButton(
                      child: Text("Done"),
                      onPressed: () {
                        setState(() {});
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
          );
        });
  }

  // Widget to pick the Dropoff time
  Widget timeField(BuildContext context) {
    if (_newOrderData['time'] == null) {
      return FlatButton(
        child: Text(
          "Choose Date",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          showDatePicker();
        },
      );
    } else {
      return fieldResult(
          "Estimated Dropoff Time",
          DateFormat.yMd().add_jm().format(
                DateTime.parse(_newOrderData["time"]),
              ),
          showDatePicker);
    }
  }

  Future<void> _getUser() async {
    final user = await User.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  void initState() {
    if (NewOrder.receiverNewOrderData["school"] != null) {
      _schoolChosen = true;
    }
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _titleController = Provider.of<Tabs>(context).receiverTitleController;
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
              ChosenUser(sender: true),
              SizedBox(height: 20),
              PackageTitleField(
                  _nextFocusNode, _newOrderData, _titleController, false),
              SizedBox(height: 20),
              schoolField(context),
              SizedBox(height: 20),
              hotspotField(context),
              SizedBox(height: 20),
              timeField(context),
              SizedBox(height: 20),
              MakeRequestButton(_saveForm, false),
            ],
          ),
        ),
      ),
    );
  }
}
