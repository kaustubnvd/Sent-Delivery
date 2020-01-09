/*
  Class created to manage state without having to call build on state changes
*/

abstract class NewOrder {
  static var receiverNewOrderData = {
    "id": DateTime.now().toString(),
    "receiver": "Current User Id",
    "title": null,
    "school": null,
    "location": null,
    "time": null
  };

  static void reset() {
    receiverNewOrderData = {
      "id": DateTime.now().toString(),
      "receiver": "Current User Id",
      "title": null,
      "school": null,
      "location": null,
      "time": null
    };
  }

  static bool validate() {
    return (receiverNewOrderData["school"] != null && receiverNewOrderData["location"] != null && receiverNewOrderData["time"] != null);
  }
}
