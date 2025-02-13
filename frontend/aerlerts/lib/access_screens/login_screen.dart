import 'package:aerlerts/components/rounded_button.dart';
import 'package:aerlerts/components/text_field_form.dart';
import 'package:aerlerts/constants.dart';
import 'package:aerlerts/search_screens/search_landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final String title = "Aerlerts";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () =>
          FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Animated Logo and Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.notifications_active,
                          size: 80,
                          color: Colors.orangeAccent,
                        )
                            .animate()
                            .shake(duration: 1.seconds), // Bounce Animation
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Typewriter Effect for "Aerlerts"
                            TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: title.length),
                              duration: Duration(seconds: 2),
                              builder: (context, value, child) {
                                return Text(
                                  title.substring(0, value),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0057B8),
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Routes for your budget',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xFF00A86B),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate().slideY(
                                begin: -0.5, end: 0.0, duration: 1.seconds),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    // Input Fields
                    TextFieldForm(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldFormDecoration.copyWith(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFieldForm(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldFormDecoration.copyWith(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20),

                    // Log In Button
                    RoundedButton(
                      color: Colors.lightBlueAccent,
                      text: 'Log In',
                      onPressed: () {
                        Navigator.pushNamed(context, SearchLanding.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
