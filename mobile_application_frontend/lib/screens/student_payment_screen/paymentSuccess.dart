import 'package:flutter/material.dart';
import 'package:inventory/screens/qr_scanner.dart';
import 'razorpay_flutter.dart';


class SuccessPage extends StatelessWidget {

  final PaymentSuccessResponse response;
  SuccessPage({
    @required this.response,
  });




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Success"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your payment is successful and the response is\n\n PaymentId:    ${response.paymentId}  \n\n OrderId:          ${response.orderId} \n\n Signature: ${response.signature}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
//              onPressed: (){
////                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
//              },
              onPressed:() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => QRCodeScanner())),
              color: Colors.green,
              textColor: Colors.white,
              child: Text('OK'),
            )
          ],
        ),
      ),
    );
  }
}
