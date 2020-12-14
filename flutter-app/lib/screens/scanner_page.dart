import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScanResult result;
  String errorName;
  Future _scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      print(qrResult.type); // The result type (barcode, cancelled, failed)
      print(qrResult.rawContent); // The barcode content
      print(qrResult.format); // The barcode format (as enum)
      print(qrResult
          .formatNote); // If a unknown format was scanned this field contains a note
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        errorName = "Camera Permission was denied";
      } else {
        setState(() {
          errorName = "Unknown error: $e";
        });
      }
    } on FormatException {
      setState(() {
        errorName = "You pressed the back button before scanning anything";
      });
    }catch(e){
      setState(() {
        errorName = "Unknown error: $e";
      });
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Scan To Purchase',
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
