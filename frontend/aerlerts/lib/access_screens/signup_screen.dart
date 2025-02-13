import 'package:aerlerts/components/rounded_button.dart';
import 'package:aerlerts/components/text_field_form.dart';
import 'package:aerlerts/constants.dart';
import 'package:aerlerts/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'signup_screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image(image: Image.asset('images/Aerlerts.png').image),
          ),
          SizedBox(height: 20),
          TextFieldForm(
            onChanged: (value) {
              email = value;
            },
            decoration: kTextFieldFormDecoration.copyWith(
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFieldForm(
            onChanged: (value) {
              password = value;
            },
            decoration: kTextFieldFormDecoration.copyWith(
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          RoundedButton(
            color: Colors.orangeAccent,
            text: 'Sign Up',
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        ]),
      ),
    );
  }
}
