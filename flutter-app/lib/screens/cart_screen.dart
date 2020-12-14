import 'package:flutter/material.dart';
import 'package:inventory/screens/student_payment_screen/order_id.dart';
import 'package:inventory/screens/student_payment_screen/payments_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalValue = 1000;
  String userName = "Aashray";
  String userId = "1337";
  String orderIdGenerated;

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    OrderId orderId = OrderId(
      amount: totalValue,
      userName: userName,
      userId: userId,
    );
    orderIdGenerated = await orderId.generateOrderId();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        centerTitle: true,
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
                children: [
                  Expanded(
                    child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Cancel',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Icon(
                              MdiIcons.closeCircle,
                            )
                          ],
                        ),
                      ),
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      )),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PaymentsScreen(
                                    cartTotal: totalValue,
                                    mentorName: userName,
                                    mentorId: userId,
                                    orderId: orderIdGenerated,
                                  ))),
                    ),
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
