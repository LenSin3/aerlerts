import 'package:aerlerts/components/rounded_button.dart';
import 'package:aerlerts/screens/login_screen.dart';
import 'package:aerlerts/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image(image: Image.asset('images/Aerlerts.png').image),
            ),
            SizedBox(height: 20),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ), // Placeholder for the login button
            SizedBox(height: 20),
            RoundedButton(
              color: Colors.orangeAccent,
              text: 'Sign Up',
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
            ),
            // Placeholder for the signup button
          ],
        ),
      ),
    );
  }
}
