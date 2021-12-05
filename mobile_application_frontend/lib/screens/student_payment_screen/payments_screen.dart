import 'package:flutter/material.dart';
import 'package:inventory/JsonData/cartItems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'razorpay_flutter.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'paymentSuccess.dart';
import 'paymentFailed.dart';
import 'package:flutter/cupertino.dart';

class PaymentsScreen extends StatefulWidget {
  final double cartTotal;
  final String email;
  final String sellerId;
  final String orderId;
  final List<String> productList;
//  final UserTimeSlot userTimeSlot;

  const PaymentsScreen({
    Key key,
    this.cartTotal: 2000,
    this.email: 'test@test.com',
    this.sellerId: '1337',
    this.orderId,
    this.productList,
//    this.userTimeSlot,
  }) : super(key: key);
  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  Razorpay _razorpay = Razorpay();
  var options;
  String keyId = Constants.keyId;
  String keyValue = Constants.keyValue;
  String orderId;


  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }



  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void capturePayment(PaymentSuccessResponse response) async {
    String apiUrl =
        'https://$keyId:$keyValue@api.razorpay.com/v1/payments/${response.paymentId}/capture';
    final http.Response response2 = await http.post(
      apiUrl,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<dynamic, dynamic>{
        "amount": widget.cartTotal,
        "currency": "INR",
      }),
    );
    if (response2.statusCode == 200) {
      log('Payment is captured');
    }
  }

  void checkout() {}

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("payment has succedded");
    // Do something when payment succeeds
    buyComplete();
    capturePayment(response);
    _razorpay.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => SuccessPage(
          response: response,
        ),
      ),
    );
    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    _razorpay.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
          response: response,
        ),
      ),
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  void buyComplete() async {
    CartItems.cart.clear();
    var jsonTags = jsonEncode(widget.productList);
    var data = {
      "sellerid": widget.sellerId.toString(), //"5f8b140d49d5fe001afd1128"
      "buyeremail": widget.email,//
      "price": (widget.cartTotal ~/ 100).toString(), // int
      "products": widget.productList, //id
    };
    log('$data');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response = await http.post(
        "https://smartcheckout.tech/api/v1//transaction/add",
        body: json.encode(data),headers: {
      "x-auth-token": token,
      "Content-type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
        print("Success");
    } else {
      log("${response.body}");
      print(response.body);
    }
  }

  @override
  void initState() {
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    String stringMoney = widget.cartTotal.toString().replaceAll(regex, '');
    int totalMoney = int.parse(stringMoney);
    log('$totalMoney');
    super.initState();
    options = {
      'key': '$keyId', // Enter the Key ID generated from the Dashboard
      'amount': totalMoney, //in the smallest currency sub-unit.
      'name': 'Smart Checkout',
      'currency': "INR",
      'order_id': widget.orderId,
      'theme.color': '#000000',
      'buttontext': "Smart Checkout",
      'description': ' ',
//      'prefill': {
//        'contact': Profile().mobile,
//        'email': Profile().email,
//      }
    };
  }



  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}


