import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Padding(
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
        ));
  }
}
