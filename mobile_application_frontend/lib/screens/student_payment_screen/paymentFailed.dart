import 'package:flutter/material.dart';
import '../qr_scanner.dart';
import 'razorpay_flutter.dart';

class FailedPage extends StatelessWidget {
  final PaymentFailureResponse response;
  FailedPage({
    @required this.response,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Failed"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your payment is Failed and the response is\nCode:           ${response.code}\nMessage:    ${response.message}",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
//              onPressed: (){
//                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
//              },
              onPressed:() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => QRCodeScanner())),
              color: Colors.redAccent,
              textColor: Colors.white,
              child: Text('OK'),
            )
          ],
        ),
      ),
    );
  }
}
