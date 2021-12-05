import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:badges/badges.dart';
import 'package:inventory/JsonData/cartItems.dart';
import 'package:inventory/JsonData/productDetail.dart';
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
  final _pageController = PageController();
  Color color = Colors.black;
  final List<Widget> _children = [
    ScannerPage(),
    TransactionPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


