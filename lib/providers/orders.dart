import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 02/03/20 (Added Order phase field)
*/

// Phase Completion:
// Phase 0: Sender and Receiver Confirm
// Phase 1: Carrier (and maybe Sender) confirms to start pickup
// Phase 2: Carrier Picks up Package
// Phase 3: Carrier Drops off Package

final ordersRef = Firestore.instance.collection("orders");

class Order {
  final String orderId;
  final String senderId;
  final String receiverId;
  final String packageTitle;
  final String packageDesc;
  final GeoPoint pickupLocation;
  final String packageImage;
  final String schoolName;
  final String dropoffLocation;
  final DateTime dropoffTime;

  Order({
    @required this.orderId,
    this.senderId,
    this.receiverId,
    this.packageTitle,
    this.packageDesc,
    this.pickupLocation,
    this.packageImage,
    this.schoolName,
    this.dropoffLocation,
    this.dropoffTime,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get orders {
    return [..._items];
  }

  void addOrder(Order order) async {
    _items.insert(0, order);
    await ordersRef.add({
      "orderID": order.orderId,
      "senderID": order.senderId,
      "receiverID": order.receiverId,
      "packageTitle": order.packageTitle,
      "description": order.packageDesc,
      "photoUrl": order.packageImage,
      "pickupLocation": order.pickupLocation,
      "schoolName": order.schoolName,
      "dropoffLocation": order.dropoffLocation,
      "dropoffTime": order.dropoffTime,
      "timestamp": DateTime.now().toIso8601String(),
      "phase": 0
    });
    notifyListeners();
  }
}
