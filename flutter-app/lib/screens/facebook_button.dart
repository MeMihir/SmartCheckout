import 'package:flutter/material.dart';

class facebookSigninButton extends StatelessWidget {
  const facebookSigninButton({
    Key key,
    this.facebookButtonText,
  }) : super(key: key);
  final String facebookButtonText;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('images/facebook-logo.png'),
          Text(
            facebookButtonText,
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
      color: Color(0xFF334D92),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      onPressed: () {},
    );
  }
}
