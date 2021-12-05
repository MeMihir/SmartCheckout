import 'dart:convert';
import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:inventory/JsonData/cartItems.dart';
import 'package:inventory/JsonData/productDetail.dart';
import 'package:inventory/JsonData/profile.dart';
import 'package:inventory/screens/qr_scanner.dart';
import 'package:inventory/screens/scanner_page.dart';
import 'package:inventory/screens/student_payment_screen/order_id.dart';
import 'package:inventory/screens/student_payment_screen/payments_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalValue = 0;
  String sellerId;
  String orderIdGenerated;
  String email = "test@test.com";
  Profile profile = new Profile();
  List<String> productsIds = new List();

  void generateTotal() {
    totalValue = 0;
    CartItems.cart.forEach((element) {
      totalValue = totalValue + element.price;
      sellerId = element.sellerId;
      productsIds.add(element.productId);
    });
    print("Seller id $sellerId");
  }

  Future<void> generateOrder() async {
    OrderId orderId = OrderId(
      amount: totalValue * 100,
      userName: email,
      userId: sellerId,
    );
    orderIdGenerated = await orderId.generateOrderId();
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
//    print(CartItems.cart[0].name);
    generateTotal();
    // await profile.retrieveInfo();
    // print(profile.name);
    // print(profile.email);
    // print(profile.mobile);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences.getString("email");
    // TODO: implement didChangeDependencies
    await generateOrder();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int cartValue = CartItems.cart == null ? 0 : CartItems.cart.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Checkout'),
        centerTitle: true,
        elevation: 5.0,
        leading: FlatButton(
          child: Icon(
            MdiIcons.arrowLeft,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => QRCodeScanner())),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Card(
                  elevation: 4.0,
                  color: Colors.grey[100],
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            // border: Border(
                            // right: BorderSide(
                            // color: Colors.black87, width: 10)),
                            ),
                        // ignore: prefer_is_not_empty
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 110.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Items',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ListView.builder(
                                    itemCount: CartItems.cart.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print("Check : ${CartItems.cart}");
                                      // if (CartItems.cart.length == 0) {
                                      //   return Text('No products in cart');
                                      // }
                                      final item = CartItems.cart[index];
                                      return ListTile(
                                        title: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${item.name}',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Text(
                                              'Rs.${item.price}',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: FlatButton(
                                          child: Icon(
                                            MdiIcons.delete,
                                            color: Colors.redAccent,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            // context.read is the easiest way to call
                                            // methods on a provided model
                                            setState(() {
                                              CartItems.cart.remove(item);
                                              generateTotal();
                                              generateOrder();
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  )
                                  // :
                                  // Center(
                                  //   child: Text("No items in the cart",
                                  //   style: TextStyle(
                                  //     fontSize: MediaQuery.of(context).size.width*0.05,
                                  //   ),),
                                  // ),
                                  ),
                            ),
                          ],
                        )
                        //     : Center(
                        //   child: Text("No Items in Cart",
                        //   style: TextStyle(
                        //     fontSize: MediaQuery.of(context).size.width*0.05,
                        //   ),),
                        // ),
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Text(
                'Total:  $totalValue',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
//                  Expanded(
//                    child: RaisedButton(
//                      child: Padding(
//                        padding: const EdgeInsets.all(12.0),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: [
//                            Text(
//                              'Cancel',
//                              style: TextStyle(fontSize: 18.0),
//                            ),
//                            Icon(
//                              MdiIcons.closeCircle,
//                            )
//                          ],
//                        ),
//                      ),
//                      color: Colors.redAccent,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.all(
//                            Radius.circular(8.0),
//                          )),
//                      onPressed: () {},
//                    ),
//                  ),
//                  SizedBox(
//                    width: 10.0,
//
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Checkout',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Icon(
                            MdiIcons.logoutVariant,
                          )
                        ],
                      ),
                    ),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    )),
                    //Fake
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => PaymentsScreen(
                                  cartTotal: totalValue * 100,
                                  email: email,
                                  sellerId: sellerId,
                                  orderId: orderIdGenerated,
                                  productList: productsIds,
                                ))),
                    /* Original
                    onPressed: orderIdGenerated != null
                        ? () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PaymentsScreen(
                                  cartTotal: totalValue * 100,
                                  email: email,
                                  sellerId: sellerId,
                                  orderId: orderIdGenerated,
                                  productList: productsIds,
                                )))
                        : null,
                        */
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
