import 'package:flutter/material.dart';

class googleSignInButton extends StatelessWidget {
  const googleSignInButton({
    Key key,
    this.googleButtonText,
  }) : super(key: key);
  final String googleButtonText;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(1.5),
//                    color: Colors.grey[200],
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Image.asset(
              'images/google-logo.png',
            ),
          ),
          Text(
            googleButtonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          Opacity(
              opacity: 0.0,
              child: Image.asset('images/google-logo.png')),
        ],
      ),
      color: Color(0xBBD82020),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      onPressed: () {},
    );
  }
}