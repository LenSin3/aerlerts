import 'package:aerlerts/access_screens/login_screen.dart';
import 'package:aerlerts/components/rounded_button.dart';
import 'package:aerlerts/components/text_field_form.dart';
import 'package:aerlerts/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'signup_screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? email;
  String? password;
  final String title = "Aerlerts"; // Text for Typewriter Effect

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
                                begin: -0.5,
                                end: 0.0,
                                duration: 1.seconds), // Flight animation
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Sign-Up Button
                    RoundedButton(
                      color: Colors.orangeAccent,
                      text: 'Sign Up',
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
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
