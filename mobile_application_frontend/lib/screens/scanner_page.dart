import 'dart:convert';
import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:inventory/JsonData/cartItems.dart';
import 'package:inventory/JsonData/productDetail.dart';
import 'package:inventory/JsonData/profile.dart';
import 'package:inventory/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/screens/cart_screen.dart';
// import 'package:inventory/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScanResult scanResult;
  String errorName;
  var url;
  var jsonData;
  var response;
  ProductDetails productDetails = new ProductDetails();
  CartItems cartItems = new CartItems();
  var token;
  CartScreen cartScreen = new CartScreen();
  int cartValue;

  @override
  void didChangeDependencies() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Profile profile = new Profile();
    profile.retrieveInfo();
    token = sharedPreferences.getString("token");
  }

  Future _scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      print(qrResult.type); // The result type (barcode, cancelled, failed)
      //fake
      if (qrResult.type.toString() != "Cancelled") {
        if(qrResult.rawContent != null){
          productDetails.name = "Mango";
          productDetails.productId = 143;
          productDetails.category = "Fruits";
          productDetails.address = "Shop No 10,Sec-10";
          productDetails.price = 50;
          productDetails.shop = "KMart";
          productDetails.stockAvailable = 5;
          productDetails.sellerId = 43;
          productDialog();
        }

        else{
          showAlertDialog(context, "Invalid QR Code");
        }
        // });
      } else {
        showAlertDialog(context, "You pressed back button without Scanning");
      }
      /*  Original Code
      if (qrResult.type.toString() != "Cancelled") {
        print(qrResult.rawContent); // The barcode content
        print(qrResult.format); // The barcode format (as enum)
        print(qrResult
            .formatNote); // If a unknown format was scanned this field contains a note
        setState(() {
          scanResult = qrResult;
        });
        var content = scanResult.rawContent.replaceAll("/\n", "");
        retrieveInfo(scanResult.rawContent).whenComplete(() {
          // if (response != null && response.statusCode == 200) {
          if (response != null) {
            productDialog();
            response = null;
          } else{
            showAlertDialog(context, "Invalid QR Code");
          }
        // });
      } else {
        showAlertDialog(context, "You pressed back button without Scanning");
      }*/
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
        showAlertDialog(context, "Error");
      });
    }
  }

  showAlertDialog(BuildContext context, var msg) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$msg !"),
      content: Text("Please try again."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> retrieveInfo(var encrypted) async {
    url = decryptAESCryptoJS(encrypted, "secret");
    log('$url');
    response = await http.get(Uri.encodeFull(url), headers: {
      "x-auth-token": token,
    });
    log('${response.statusCode}');
    log('${response.body}');
    jsonData = json.decode(response.body);
    log('${response.body}');

    productDetails.name = jsonData['name'];
    productDetails.productId = jsonData['id'];
    productDetails.category = jsonData['category'];
    productDetails.address = jsonData['address'];
    productDetails.price = jsonData['price'];
    productDetails.shop = jsonData['shop'];
    productDetails.stockAvailable = jsonData['quantity'];
    productDetails.sellerId = jsonData['sellerid'];
    scanResult = null;
  }

  Future<void> productDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          title: Text(
            'Product Details',
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Item   :   ${productDetails.name}',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Price  :   ${productDetails.price}',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Category :   ${productDetails.category}',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Shop Name  :   ${productDetails.shop}',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Items Available  :  ${productDetails.stockAvailable}',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Shop Address  :   ${productDetails.address}',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      color: Colors.blueAccent,
                      onPressed: () {
//                        productDetails.cartItems.add(productDetails);
                        CartItems.cart.add(productDetails);
                        setState(() {
                          cartValue = CartItems.cart.length;
                        });
                        print("Added->  ${CartItems.cart[0].name}");
                        scanResult = null;
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      color: Colors.redAccent,
                      onPressed: () {
                        scanResult = null;
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  build(BuildContext context) {
    cartValue = cartValue = CartItems.cart == null ? 0 : CartItems.cart.length;
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Checkout'),
          centerTitle: true,
          elevation: 5.0,
          actions: [
            Badge(
              badgeContent: Text('$cartValue'),
              toAnimate: true,
              position: BadgePosition.bottomLeft(bottom: 25, left: 1),
              shape: BadgeShape.circle,
              padding: EdgeInsets.all(7.0),
              badgeColor: Colors.blue,
              child: IconButton(
//            icon: Icon(Icons.exit_to_app),
                icon: Icon(Icons.shopping_cart),

                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) => CartScreen())),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Scan To Purchase',
//            $url $jsonData ${productDetails.name}
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.4,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  elevation: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Scan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      Opacity(opacity: 0.0, child: Icon(Icons.camera_alt))
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  )),
                  onPressed: _scanQR,
                ),
              ),
            ),
          ],
        ));
  }
}
