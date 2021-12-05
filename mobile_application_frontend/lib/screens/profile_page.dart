import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:inventory/JsonData/cartItems.dart';
import 'package:inventory/JsonData/profile.dart';
import 'package:inventory/screens/sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var name;
  var email;
  var number;
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sharedPreferences = await SharedPreferences.getInstance();
    name  = sharedPreferences.getString("name");
    email  = sharedPreferences.getString("email");
    number  = sharedPreferences.getInt("mobile");
    // Profile profile = new Profile();
    // await profile.retrieveInfo();
    // name = profile.name;
    // email = profile.email;
    // number = profile.mobile;
    // print(name);
    setState(() {});
  }

  void _logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'My Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                name != null
                    ? Card(
                        elevation: 4.0,
                        color: Colors.grey[100],
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: Container(
                            width: MediaQuery.of(context).size.width*1,
                            decoration: BoxDecoration(
                                // border: Border(
                                    // right: BorderSide(
                                        // color: Colors.black, width: 10),left: BorderSide(
                                    // color: Colors.black, width: 10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Name',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text(name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text('Mobile No.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text('$number',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text('Email',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text(email,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: 30.0,
                ),
//                 SizedBox(
//                   height: 50.0,
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   child: RaisedButton(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Change Password',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                           ),
//                         ),
//                         Icon(
//                           MdiIcons.lockOutline,
//                           size: 30.0,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                     color: Color(0xFF538529),
// //                color: Colors.black87,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                       Radius.circular(16.0),
//                     )),
//                     onPressed: () {},
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
                SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        Icon(
                          Icons.exit_to_app,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    color: Color(0xFFc33429),
//                color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    )),
                    onPressed: _logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
