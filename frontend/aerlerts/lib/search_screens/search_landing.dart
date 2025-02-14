import 'package:aerlerts/search_screens/flight_search_box.dart';
import 'package:flutter/material.dart';

class SearchLanding extends StatefulWidget {
  static const id = 'search_landing';

  @override
  State<SearchLanding> createState() => _SearchLandingState();
}

class _SearchLandingState extends State<SearchLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), // Adjusts AppBar Height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          shadowColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_active,
                color: Colors.orangeAccent,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                'Aerlerts - Flight Search',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0057B8),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: FlightSearchBox(),
      ),
    );
  }
}
