import 'package:aerlerts/screens/login_screen.dart';
import 'package:aerlerts/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Aerlerts());
}

class Aerlerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
  }
}
