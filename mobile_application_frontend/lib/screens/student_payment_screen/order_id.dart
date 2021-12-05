import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';

class OrderId {
  final double amount;
  final String userName;
  final String userId;

  const OrderId({
    this.amount: 2000,
    this.userName: 'Alexa',
    this.userId: '1337',
  });

  Future<String> generateOrderId() async {
    String keyId = Constants.keyId;
    String keyValue = Constants.keyValue;
    String orderId;
    String apiUrl = 'https://$keyId:$keyValue@api.razorpay.com/v1/orders';
    final http.Response response2 = await http.post(
      apiUrl,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<dynamic, dynamic>{
        "amount": amount,
        "currency": "INR",
        "notes": {"mentorName": userName, "mentorId": userId}
      }),
    );
    var extractData = jsonDecode(response2.body);
    orderId = extractData['id'];
    return orderId;
  }
}
