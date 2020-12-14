import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:badges/badges.dart';
import 'package:inventory/screens/cart_screen.dart';
import 'package:inventory/screens/profile_page.dart';
import 'package:inventory/screens/scanner_page.dart';
import 'package:inventory/screens/transaction_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
      ScannerPage(),
      TransactionPage(),
      ProfilePage(),
  ];
  int cartValue = 5;

  final _pageController = PageController();
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        centerTitle: true,
        elevation: 5.0,
        actions: [
          Badge(
            badgeContent: Text('$cartValue'),
            toAnimate: true,
            position: BadgePosition.bottomLeft(bottom: 25,left: 1),
            shape: BadgeShape.circle,
            padding: EdgeInsets.all(7.0),
            badgeColor: Colors.blue,
            child: IconButton(
//            icon: Icon(Icons.exit_to_app),
              icon: Icon(Icons.shopping_cart),
              onPressed:() => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CartScreen())),
            ),
          ),
        ],
      ),
      body: PageView(
        pageSnapping: true,
        controller: _pageController,
        children: _children,
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
//        height: 75,
        index: _selectedIndex,
        items: [
            Icon(
            MdiIcons.qrcodeScan,
            size: 30,
            color: Colors.white
          ),
          Icon(
            Icons.library_books,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 30,
          ),
        ],
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}


