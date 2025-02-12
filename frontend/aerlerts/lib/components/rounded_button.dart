import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({this.color, this.text, this.onPressed});
  final Color? color;
  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      // color: Colors.lightBlueAccent,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      borderOnForeground: true,
      shadowColor: Colors.orange[900],
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          '$text',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
