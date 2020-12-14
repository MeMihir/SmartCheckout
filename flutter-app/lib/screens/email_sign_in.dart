import 'package:flutter/material.dart';
import 'package:inventory/screens/qr_scanner.dart';

class buildEmailSignIn extends StatefulWidget {
  final primaryText;

  const buildEmailSignIn({Key key, this.primaryText}) : super(key: key);
  @override
  _buildEmailSignInState createState() => _buildEmailSignInState();
}

class _buildEmailSignInState extends State<buildEmailSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
 @override
  void initState() {

    super.initState();
  }
  void _submit(){
    print('email: ${_emailController.text}  , password: ${_passwordController.text}');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => QRCodeScanner()));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _passwordController.clear();
      _emailController.clear();
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'test@test.com',
              ),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocusNode),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onEditingComplete: _submit,
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
        SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width * 0.4,
          child: RaisedButton(
            child: Text(
              widget.primaryText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            )),
            onPressed: _submit,
          ),
        ),
        SizedBox(
          height: 60.0,
        )
      ],
    );
  }
}
