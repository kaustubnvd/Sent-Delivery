import 'package:flutter/material.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

import '../widgets/app_drawer.dart';

// current cost hard coded. eventually with pricing model this will be a dynamic value
final int shippingCost = 100; // cost in cents not dollars.

String getShippingCost() => (shippingCost / 100).toStringAsFixed(2);

class CardAuthScreen extends StatefulWidget {
  static const routeName = '/card-auth-screen';

  @override
  _CardAuthScreenState createState() => _CardAuthScreenState();
}

class _CardAuthScreenState extends State<CardAuthScreen> {
  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId('sq0idp-oBOagWWCwQ34Oc9bDwRNpA');
    await InAppPayments.startCardEntryFlow(
      onCardEntryCancel: _cardEntryCancel,
      onCardNonceRequestSuccess: (CardDetails result) {
        // for IOS styling refer to this https://github.com/square/in-app-payments-flutter-plugin/blob/master/example/lib/main.dart
        try {
          InAppPayments.completeCardEntry(
              onCardEntryComplete: () => print('success!'));
          // print('success');
          // var chargeResult =
          //     PaymentsRepository.actuallyMakeTheCharge(result.nonce);
          // if (chargeResult != 'Success!') throw new StateError(chargeResult);
          // InAppPayments.completeCardEntry(onCardEntryComplete: model.clearCart);
        } catch (ex) {
          InAppPayments.showCardNonceProcessingError(ex.toString());
        }
      },
    );
  }

  void _cardEntryCancel() {
    // canceled.
  }
// resources to config backend
//https://github.com/square/in-app-payments-server-quickstart
//https://github.com/square/in-app-payments-flutter-plugin/blob/master/example/take_a_payment.md

  void _cardNonceRequestSuccess(CardDetails results) {
    print(results.nonce);

    InAppPayments.completeCardEntry(
      onCardEntryComplete: _cardEntryComplete,
    );
  }

  void _cardEntryComplete() {
    print('success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
      ),
      drawer: AppDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 100,
              child: RaisedButton(
                onPressed: _initSquarePayment,
                textColor: Theme.of(context).accentColor,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.payment),
                    const Text(
                      'Pay',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}






