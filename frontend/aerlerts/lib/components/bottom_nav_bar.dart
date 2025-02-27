// lib/components/bottom_nav_bar.dart
import 'package:aerlerts/search_screens/alerts.dart';
import 'package:aerlerts/search_screens/search_landing.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.blueAccent,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            onTap(index);

            // Handle navigation
            if (index == 0 && currentIndex != 0) {
              Navigator.pushReplacementNamed(context, SearchLanding.id);
            } else if (index == 2 && currentIndex != 2) {
              Navigator.pushReplacementNamed(context, AlertScreen.id);
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Alerts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
