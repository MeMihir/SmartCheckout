import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/screens/facebook_button.dart';
import 'package:inventory/screens/google_button.dart';
import 'package:inventory/screens/email_sign_in.dart';

enum signInType {
  signIn,
  register
}
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  void _toogleFormType(){
    setState(() {
      _formType = _formType == signInType.signIn ? signInType.register : signInType.signIn;
    });
  }

  signInType _formType = signInType.signIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Checkout"),
        centerTitle: true,
        elevation: 3.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    final primaryText = _formType == signInType.signIn ? 'Sign in' : 'Sign Up' ;
    final secondaryText = _formType == signInType.signIn ? 'Need an account? Register' : 'Have an account? Sign in?';
    final facebookButtonText = _formType == signInType.signIn ? 'Sign in with Facebook' : 'Sign up with Facebook';
    final googleButtonText = _formType == signInType.signIn ? 'Sign in with Gooogle' : 'Sign up with Google';

    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0 ,top: 80.0,bottom: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildEmailSignIn(primaryText: primaryText),
            // SizedBox(
            //   height: 50.0,
            //   child: googleSignInButton(googleButtonText: googleButtonText),
            // ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // SizedBox(
            //   height: 50.0,
            //   child: facebookSigninButton(facebookButtonText: facebookButtonText),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            FlatButton(
              child: Text(secondaryText,
              style: TextStyle(
                fontSize: 17.0,
              ),),
              onPressed: _toogleFormType,
            )
          ],
        ),
      ),
    );
  }
}


