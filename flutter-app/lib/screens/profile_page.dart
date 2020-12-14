import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Aashray";
  String email = "aashray.singal2018@vitstudent.ac.in";
  String number = "9876543210";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(number,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(email,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.6,
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Icon(
                      MdiIcons.lockOutline,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ],
                ),
                color: Color(0xFF538529),
//                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                )),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
