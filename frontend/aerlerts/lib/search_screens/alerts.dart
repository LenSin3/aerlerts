// lib/search_screens/alerts.dart
import 'package:aerlerts/components/bottom_nav_bar.dart';
import 'package:aerlerts/components/rounded_button.dart';
import 'package:aerlerts/search_screens/create_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class AlertScreen extends StatefulWidget {
  static const id = 'alert_screen';

  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  int _selectedIndex = 2; // Alerts tab selected by default
  bool _isLoading = true;
  List<Map<String, dynamic>> _alerts = [];

  @override
  void initState() {
    super.initState();
    // Simulate loading data
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _alerts = _getMockAlerts();
      });
    });
  }

  List<Map<String, dynamic>> _getMockAlerts() {
    return [
      {
        'id': '1',
        'origin': 'LHR',
        'originCity': 'London',
        'destination': 'JFK',
        'destinationCity': 'New York',
        'date': DateTime.now().add(Duration(days: 30)),
        'price': 350.0,
        'active': true,
        'priceChange': -22.5,
        'lastUpdated': DateTime.now().subtract(Duration(hours: 6)),
      },
      {
        'id': '2',
        'origin': 'SFO',
        'originCity': 'San Francisco',
        'destination': 'LAX',
        'destinationCity': 'Los Angeles',
        'date': DateTime.now().add(Duration(days: 14)),
        'price': 120.0,
        'active': true,
        'priceChange': 5.0,
        'lastUpdated': DateTime.now().subtract(Duration(hours: 2)),
      },
      {
        'id': '3',
        'origin': 'LHR',
        'originCity': 'London',
        'destination': 'CDG',
        'destinationCity': 'Paris',
        'date': DateTime.now().add(Duration(days: 60)),
        'price': 180.0,
        'active': false,
        'priceChange': -10.0,
        'lastUpdated': DateTime.now().subtract(Duration(days: 1)),
      },
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'search_landing');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, 'bookings_screen');
        break;
      case 2:
        // Already on Alerts
        break;
      case 3:
        Navigator.pushReplacementNamed(context, 'profile_screen');
        break;
    }
  }

  void _createNewAlert() async {
    // Navigate to create alert screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAlertScreen()),
    );

    if (result == true) {
      // If alert was created successfully
      setState(() {
        // Add a new mock alert to the beginning of the list
        _alerts.insert(0, {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'origin': 'NEW',
          'originCity': 'New Alert',
          'destination': 'DST',
          'destinationCity': 'Destination',
          'date': DateTime.now().add(Duration(days: 45)),
          'price': 299.99,
          'active': true,
          'priceChange': 0.0,
          'lastUpdated': DateTime.now(),
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Alert created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
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
                'Aerlerts - Price Alerts',
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            )
          : _alerts.isEmpty
              ? _buildEmptyState()
              : _buildAlertsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewAlert,
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
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
            Icons.notifications_off,
            size: 80,
            color: Colors.grey,
          ).animate().shake(delay: 500.ms),
          SizedBox(height: 20),
          Text(
            'No alerts yet',
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
              'Create your first price alert to get notified when flight prices drop!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 30),
          RoundedButton(
            color: Colors.orangeAccent,
            text: 'Create Alert',
            onPressed: _createNewAlert,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _alerts.length,
      itemBuilder: (context, index) {
        final alert = _alerts[index];
        final isPositiveChange = alert['priceChange'] > 0;
        final priceChangeColor = isPositiveChange ? Colors.red : Colors.green;
        final priceChangeIcon = isPositiveChange
            ? Icons.arrow_upward_rounded
            : Icons.arrow_downward_rounded;

        return Card(
          elevation: 4,
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${alert['origin']} → ${alert['destination']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: alert['active'],
                      activeColor: Colors.orangeAccent,
                      onChanged: (value) {
                        setState(() {
                          _alerts[index]['active'] = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '${alert['originCity']} to ${alert['destinationCity']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target Date',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          DateFormat('MMM dd, yyyy').format(alert['date']),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Current Price',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '\$${alert['price'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: priceChangeColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    priceChangeIcon,
                                    color: priceChangeColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '\$${alert['priceChange'].abs().toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: priceChangeColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last updated: ${_getTimeAgo(alert['lastUpdated'])}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Delete alert
                        setState(() {
                          _alerts.removeAt(index);
                          if (_alerts.isEmpty) {
                            // If no alerts left, show empty state
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.red[300],
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red[300],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate().fade(duration: 300.ms, delay: (index * 100).ms).slideY(
            begin: 0.2, end: 0, duration: 300.ms, delay: (index * 100).ms);
      },
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}
