// lib/search_screens/bookings.dart
import 'package:aerlerts/components/bottom_nav_bar.dart';
import 'package:aerlerts/search_screens/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  static const id = 'bookings_screen';

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1; // Bookings tab selected by default
  bool _isLoading = true;
  List<Map<String, dynamic>> _bookings = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Simulate loading data
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _bookings = _getMockBookings();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getMockBookings() {
    return [
      {
        'id': '1',
        'airline': 'Oceanic Air',
        'flightNumber': 'OA815',
        'origin': 'London',
        'originCode': 'LHR',
        'destination': 'New York',
        'destinationCode': 'JFK',
        'departureDate': DateTime.now().add(Duration(days: 15)),
        'departureTime': '08:15',
        'arrivalTime': '11:30',
        'price': 299.99,
        'stops': 0,
        'duration': '3h 15m',
        'status': 'Confirmed',
        'hasAlert': true,
        'alertId': '1',
        'bookingDate': DateTime.now().subtract(Duration(days: 3)),
      },
      {
        'id': '2',
        'airline': 'Ajira Airways',
        'flightNumber': 'AJ316',
        'origin': 'San Francisco',
        'originCode': 'SFO',
        'destination': 'Los Angeles',
        'destinationCode': 'LAX',
        'departureDate': DateTime.now().add(Duration(days: 5)),
        'departureTime': '12:45',
        'arrivalTime': '14:20',
        'price': 145.50,
        'stops': 0,
        'duration': '1h 35m',
        'status': 'Confirmed',
        'hasAlert': false,
        'alertId': null,
        'bookingDate': DateTime.now().subtract(Duration(days: 7)),
      },
      {
        'id': '3',
        'airline': 'Pan Atlantic',
        'flightNumber': 'PA423',
        'origin': 'London',
        'originCode': 'LHR',
        'destination': 'Paris',
        'destinationCode': 'CDG',
        'departureDate': DateTime.now().subtract(Duration(days: 10)),
        'departureTime': '16:30',
        'arrivalTime': '18:45',
        'price': 120.75,
        'stops': 0,
        'duration': '2h 15m',
        'status': 'Completed',
        'hasAlert': false,
        'alertId': null,
        'bookingDate': DateTime.now().subtract(Duration(days: 30)),
      },
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle Navigation
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'search_landing');
        break;
      case 1:
        // Already on Bookings
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AlertScreen.id);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, 'profile_screen');
        break;
    }
  }

  void _createAlertForBooking(Map<String, dynamic> booking) {
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
                    controller: TextEditingController(
                        text: (booking['price'] * 0.9).toStringAsFixed(2)),
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

              // Update the booking to have an alert
              setState(() {
                _bookings.firstWhere(
                    (b) => b['id'] == booking['id'])['hasAlert'] = true;
                _bookings.firstWhere(
                        (b) => b['id'] == booking['id'])['alertId'] =
                    'alert_${booking['id']}';
              });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.airplane_ticket,
                color: Colors.orangeAccent,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Your Bookings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0057B8),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.orangeAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orangeAccent,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            )
          : _bookings.isEmpty
              ? _buildEmptyState()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBookingsList(_bookings),
                    _buildBookingsList(_bookings
                        .where((booking) =>
                            booking['departureDate'].isAfter(DateTime.now()))
                        .toList()),
                    _buildBookingsList(_bookings
                        .where((booking) =>
                            booking['departureDate'].isBefore(DateTime.now()))
                        .toList()),
                  ],
                ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flight_takeoff,
            size: 80,
            color: Colors.grey,
          ).animate().scale(
                duration: 600.ms,
                curve: Curves.easeOut,
              ),
          SizedBox(height: 20),
          Text(
            'No bookings yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0057B8),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Search for flights and book your next adventure!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            icon: Icon(Icons.search),
            label: Text('Find Flights'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'search_landing');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(List<Map<String, dynamic>> bookings) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No bookings in this category',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        final isPast = booking['departureDate'].isBefore(DateTime.now());

        return Card(
          elevation: 3,
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Airline and Status banner
              Container(
                decoration: BoxDecoration(
                  color: _getStatusColor(booking['status']).withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      booking['airline'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking['status']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        booking['status'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Flight details
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Flight number and date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Flight ${booking['flightNumber']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          DateFormat('E, MMM d, yyyy')
                              .format(booking['departureDate']),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Route details
                    Row(
                      children: [
                        // Origin
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking['departureTime'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                booking['originCode'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                booking['origin'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Flight path
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                booking['duration'],
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
                                  Icon(
                                    Icons.flight,
                                    color: Colors.orangeAccent,
                                    size: 20,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                booking['stops'] > 0
                                    ? '${booking['stops']} stop'
                                    : 'Direct',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: booking['stops'] > 0
                                      ? Colors.grey[600]
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Destination
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                booking['arrivalTime'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                booking['destinationCode'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                booking['destination'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Price and actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '\$${booking['price'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0057B8),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if (!isPast && !booking['hasAlert'])
                              OutlinedButton.icon(
                                onPressed: () =>
                                    _createAlertForBooking(booking),
                                icon:
                                    Icon(Icons.notifications_active, size: 16),
                                label: Text('Set Alert'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.orangeAccent,
                                ),
                              )
                            else if (!isPast && booking['hasAlert'])
                              OutlinedButton.icon(
                                onPressed: null,
                                icon:
                                    Icon(Icons.notifications_active, size: 16),
                                label: Text('Alert Set'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.green,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    // Booking details
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booked on: ${DateFormat('MMM d, yyyy').format(booking['bookingDate'])}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Booking ID: ${booking['id']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fade(duration: 300.ms, delay: (index * 100).ms).slideY(
            begin: 0.2, end: 0, duration: 300.ms, delay: (index * 100).ms);
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orangeAccent;
      case 'Cancelled':
        return Colors.red;
      case 'Completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
