import 'package:aerlerts/access_screens/login_screen.dart';
import 'package:aerlerts/access_screens/signup_screen.dart';
import 'package:aerlerts/access_screens/welcome_screen.dart';
import 'package:aerlerts/search_screens/search_landing.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Aerlerts());
}

class Aerlerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        SearchLanding.id: (context) => SearchLanding(),
      },
    );
  }
}
