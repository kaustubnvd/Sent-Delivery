import 'package:flutter/foundation.dart';

/*
    Authors: Kaustub Navalady, Last Edit: 01/01/20
*/

class Order {
  final String orderId;
  final String senderId;
  final String receiverId;
  final String packageTitle;
  final String packageDesc;
  final String pickupLocation;
  final bool packageImage;
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

  void addOrder(Order order) {
    _items.insert(0, order);
    notifyListeners();
  }
}
