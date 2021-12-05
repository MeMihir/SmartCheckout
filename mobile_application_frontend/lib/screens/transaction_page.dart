import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:inventory/JsonData/cartItems.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'cart_screen.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var transactions;

  Future<void> retrieveInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    var userId = decodedToken['userId'];
    print('$decodedToken');
    var url =
        "https://smartcheckout.tech/api/v1/buyer/transaction/$userId";
    var response = await http.get(Uri.encodeFull(url), headers: {
      "x-auth-token": token,
    });
    print('hi2');
    print('${response.statusCode}');
    print('${response.body}');
    var jsonData = json.decode(response.body);
    transactions = jsonData['transaction'];
    print('$transactions');
////    name = userProfile['name'];
////    email = userProfile['email'];
////    mobile = userProfile['mobile'];
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await retrieveInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int cartValue = CartItems.cart == null ? 0 : CartItems.cart.length;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Transaction History',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 4.0,
                color: Colors.grey[100],
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: Container(
                    decoration: BoxDecoration(
                        // border: Border(
                            // right: BorderSide(color: Colors.black87, width: 10,)),
                    ),

                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: transactions != null
                                  ? transactions.length != 0 ?
                              ListView.builder(
                                      itemCount: transactions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final item = transactions[transactions.length -1-index];
                                        var date =
                                            item['date'].substring(0, 10);
                                        return Padding(
                                          padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Shop',
                                                        style: TextStyle(
                                                          fontSize: 11.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        item['sellerid'] != null
                                                            ? '${item['sellerid']['shop']}'
                                                            : 'shop',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
//                                                          color: Colors.deepOrangeAccent,
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'Transaction Id',
                                                        style: TextStyle(
                                                          fontSize: 11.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${item['_id']}',
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.lightBlueAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Purchased On',
                                                        style: TextStyle(
                                                          fontSize: 11.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$date',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
//                                                          color: Colors.deepOrangeAccent,
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'Total Amount',
                                                        style: TextStyle(
                                                          fontSize: 11.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Rs.${item['price']}',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.green,
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Divider(
                                                  thickness: 2.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ):
                                  Center(
                                    child: Text("No Transaction History",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width*0.05,
                                    ),),
                                  )
                                  : Center(
                                child: CircularProgressIndicator(),
                                    )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//{products: [5f8b140d49d5fe001afd1128], _id: 5f8c3472eefa7f001a29d920, sellerid: {shop: smh},
// price: 30, date: 2020-10-18T00:00:00.000Z}
/*
Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Transaction History',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
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
                            border: Border(
                                right: BorderSide(
                                    color: Colors.black87, width: 10))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Text('1    Grains    rs.900'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('1    Grains    rs.900'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('1    Grains    rs.900'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('1    Grains    rs.900'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('1    Grains    rs.900'),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ))
 */
