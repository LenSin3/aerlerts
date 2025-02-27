// lib/search_screens/flight_search_box.dart
import 'package:aerlerts/components/bottom_nav_bar.dart';
import 'package:aerlerts/components/rounded_button.dart';
import 'package:aerlerts/models/flight_routes.dart';
import 'package:aerlerts/search_screens/alerts.dart';
import 'package:aerlerts/search_screens/bookings.dart';
import 'package:aerlerts/search_screens/profile_screen.dart';
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
  int adultCount = 1;
  int childCount = 0;
  String cabinClass = "Economy";
  int _selectedIndex = 0; // Track selected tab index
  bool _showSearchResults = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle Navigation
    switch (index) {
      case 0:
        // Already on Home
        break;
      case 1:
        Navigator.pushReplacementNamed(context, BookingsScreen.id);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AlertScreen.id);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, ProfileScreen.id);
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

  void _openPassengerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Select Passengers",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Adults"),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (adultCount > 1) {
                                  adultCount--;
                                }
                              });
                            },
                          ),
                          Text(adultCount.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                adultCount++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Children"),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (childCount > 0) {
                                  childCount--;
                                }
                              });
                            },
                          ),
                          Text(childCount.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                childCount++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  RoundedButton(
                    color: Colors.orangeAccent,
                    text: 'Done',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      setState(() {}); // Update the UI with the new passenger count
    });
  }

  void _searchFlights() {
    // Validate inputs
    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        selectedDateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show search results
    setState(() {
      _showSearchResults = true;
    });
  }

  void _createPriceAlert(Map<String, dynamic> flight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Price Alert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We\'ll notify you when this flight price drops below:',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text('\$',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Target price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
            ),
            onPressed: () {
              Navigator.pop(context);

              // Success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Price alert created successfully!'),
                  backgroundColor: Colors.green,
                  action: SnackBarAction(
                    label: 'VIEW ALERTS',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AlertScreen.id);
                    },
                  ),
                ),
              );
            },
            child: Text('Create Alert'),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSearchResults() {
    // Use our flight routes data model to search flights
    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        selectedDateRange == null) {
      return [];
    }

    return FlightRoutesData.searchFlights(
      origin: fromController.text,
      destination: toController.text,
      date: selectedDateRange!.start,
      cabinClass: cabinClass,
    );
  }

  Widget _buildSearchResults() {
    final results = _getSearchResults();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search Results',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0057B8),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showSearchResults = false;
                      });
                    },
                    child: Text('New Search'),
                  ),
                ],
              ),
              Text(
                '${fromController.text} → ${toController.text}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Date: ${selectedDateRange?.start.toString().substring(0, 10)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final flight = results[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            flight['airline'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Flight ${flight['flightNo']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                flight['departureTime'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                flight['origin'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  flight['duration'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 2,
                                      color: Colors.grey[300],
                                    ),
                                    flight['stops'] > 0
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey[300]!),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              '${flight['stops']} stop',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey[300]!),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              'Direct',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                flight['arrivalTime'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                flight['destination'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${flight['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0057B8),
                            ),
                          ),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () => _createPriceAlert(flight),
                                icon: Icon(Icons.notifications_active),
                                label: Text('Alert'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.orangeAccent,
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Book flight
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Booking functionality coming soon!'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                ),
                                child: Text('Book'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showSearchResults) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _buildSearchResults(),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }

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
                    color: Colors.white,
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
                    color: Colors.white,
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
                            controller: TextEditingController(
                              text: selectedDateRange != null
                                  ? "${selectedDateRange!.start.toString().substring(0, 10)} to ${selectedDateRange!.end.toString().substring(0, 10)}"
                                  : "",
                            ),
                            onTap: () => _selectDateRange(context),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            readOnly: true,
                            decoration: customInputDecoration(
                              "Passengers",
                              Icon(Icons.people, color: Colors.orangeAccent),
                            ),
                            onTap: () => _openPassengerModal(context),
                            controller: TextEditingController(
                              text:
                                  "$adultCount Adult${adultCount > 1 ? 's' : ''}${childCount > 0 ? ', $childCount Child${childCount > 1 ? 'ren' : ''}' : ''}",
                            ),
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
                    onPressed: _searchFlights,
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
