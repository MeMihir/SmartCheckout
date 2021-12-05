import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/screens/qr_scanner.dart';
import 'package:inventory/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
  1. Login Completed(On error show alert dialog remaining)
  2. Cart Items Value to be updated on adding a new product
  3.  Cart Ready
  4. Payment Ready
  5. Profile Page Only need to get data
  6. All Transactions Only Need to Get Data
  7. Update total on deletion of items in cart page
  8. Empty Cart After Payment Completes
 */
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") != null){
      Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => QRCodeScanner())));
    }
    else{
      Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => QRCodeScanner())));

          // context, MaterialPageRoute(builder: (context) => SignInPage())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(child: Image(image: AssetImage('images/banner.png'))),
    );
  }
}

/*
TypewriterAnimatedTextKit(
          isRepeatingAnimation: true,
          speed: Duration(milliseconds: 500),
          text: ['Invento'],
          textStyle: TextStyle(
              color: Colors.white, fontSize: 75.0, fontWeight: FontWeight.bold),
        ),
 */