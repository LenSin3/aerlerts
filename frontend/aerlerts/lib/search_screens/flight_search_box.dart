import 'package:aerlerts/components/bottom_nav_bar.dart';
import 'package:aerlerts/components/rounded_button.dart';
import 'package:flutter/material.dart';

class FlightSearchBox extends StatefulWidget {
  @override
  _FlightSearchBoxState createState() => _FlightSearchBoxState();
}

class _FlightSearchBoxState extends State<FlightSearchBox> {
  String tripType = "Round Trip"; // Default selection
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  DateTimeRange? selectedDateRange;
  String passengerCount = "1 Adult";
  String cabinClass = "Economy";
  int _selectedIndex = 0; // Track selected tab index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle Navigation - Replace with actual navigation logic
    switch (index) {
      case 0:
        print("Navigate to Home");
        break;
      case 1:
        print("Navigate to Bookings");
        break;
      case 2:
        print("Navigate to Alerts");
        break;
      case 3:
        print("Navigate to Profile");
        break;
    }
  }

  void _selectDateRange(BuildContext context) async {
    DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 1)),
          ),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: Colors.orangeAccent,
            colorScheme: ColorScheme.light(primary: Colors.orangeAccent),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        selectedDateRange = pickedRange;
      });
    }
  }

  InputDecoration customInputDecoration(String hintText, Icon icon) {
    return InputDecoration(
      hintText: hintText,
      labelText: hintText,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0057B8), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0057B8), width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      prefixIcon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), // Dismiss keyboard when tapping outside
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset:
            true, // Prevents layout shift when keyboard opens
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 6, top: 1), // Extra padding to keep button visible
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Trip Selector (Centered with Elevation)
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ToggleButtons(
                        isSelected: [
                          tripType == "One Way",
                          tripType == "Round Trip",
                          tripType == "Multi-City"
                        ],
                        borderRadius: BorderRadius.circular(32.0),
                        selectedColor: Colors.white,
                        fillColor: Colors.orangeAccent,
                        borderColor: Color(0xFF0057B8),
                        color: Colors.black,
                        constraints: BoxConstraints(minHeight: 50),
                        onPressed: (int index) {
                          setState(() {
                            tripType =
                                ["One Way", "Round Trip", "Multi-City"][index];
                            if (tripType == "One Way") {
                              selectedDateRange = DateTimeRange(
                                start: DateTime.now(),
                                end: DateTime.now(),
                              );
                            }
                          });
                        },
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("One Way")),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Round Trip")),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Multi-City")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Elevated Container for Form Fields
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: fromController,
                            decoration: customInputDecoration(
                                "From",
                                Icon(Icons.flight_takeoff,
                                    color: Colors.orangeAccent)),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: toController,
                            decoration: customInputDecoration(
                                "To",
                                Icon(Icons.flight_land,
                                    color: Colors.orangeAccent)),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            readOnly: true,
                            decoration: customInputDecoration(
                              "Select Date Range",
                              Icon(Icons.calendar_today,
                                  color: Colors.orangeAccent),
                            ),
                            onTap: () => _selectDateRange(context),
                          ),
                          SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: passengerCount,
                            decoration: customInputDecoration("Passengers",
                                Icon(Icons.people, color: Colors.orangeAccent)),
                            items: ["1 Adult", "2 Adults", "1 Adult, 1 Child"]
                                .map((option) => DropdownMenuItem(
                                    value: option, child: Text(option)))
                                .toList(),
                            onChanged: (value) =>
                                setState(() => passengerCount = value!),
                          ),
                          SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: cabinClass,
                            decoration: customInputDecoration(
                                "Cabin Class",
                                Icon(Icons.airline_seat_recline_extra,
                                    color: Colors.orangeAccent)),
                            items: ["Economy", "Business", "First Class"]
                                .map((option) => DropdownMenuItem(
                                    value: option, child: Text(option)))
                                .toList(),
                            onChanged: (value) =>
                                setState(() => cabinClass = value!),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Search Flights Button - Now Properly Positioned Above Bottom Nav
                  RoundedButton(
                    color: Colors.orangeAccent,
                    text: 'Search Flights',
                    onPressed: () {
                      print("Searching for flights...");
                    },
                  ),
                  SizedBox(
                      height:
                          30), // Increased padding to prevent overlap with bottom nav
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
