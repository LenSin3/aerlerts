import 'package:flutter/material.dart';

class TripsRoundedButton extends StatelessWidget {
  TripsRoundedButton({this.color, this.text, this.onPressed});
  final Color? color;
  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        // color: Colors.lightBlueAccent,
        color: color,
        borderRadius: BorderRadius.circular(3.0),
        borderOnForeground: true,
        shadowColor: Colors.orange[900],
        child: MaterialButton(
          onPressed: onPressed,
          // minWidth: 50.0,
          // height: 2.0,
          child: Text(
            '$text',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
