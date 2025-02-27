// lib/search_screens/profile_screen.dart
import 'package:aerlerts/components/bottom_nav_bar.dart';
import 'package:aerlerts/search_screens/alerts.dart';
import 'package:aerlerts/search_screens/bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 3; // Profile tab selected by default
  bool _isLoading = true;
  Map<String, dynamic> _userData = {};
  List<Map<String, dynamic>> _travelPreferences = [];
  List<Map<String, dynamic>> _recentActivity = [];

  @override
  void initState() {
    super.initState();
    // Simulate loading data
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _userData = _getMockUserData();
        _travelPreferences = _getMockTravelPreferences();
        _recentActivity = _getMockRecentActivity();
      });
    });
  }

  Map<String, dynamic> _getMockUserData() {
    return {
      'name': 'Alex Johnson',
      'email': 'alex.johnson@example.com',
      'phoneNumber': '+1 (555) 123-4567',
      'address':
          '123 Skyview Apartments, 456 Aviation Blvd, San Francisco, CA 94016',
      'dateOfBirth': DateTime(1985, 6, 15),
      'nationality': 'United States',
      'passportNumber': 'US123456789',
      'passportExpiry': DateTime(2028, 8, 22),
      'profilePicture': null, // Could be a network image URL
      'memberSince': DateTime(2023, 3, 15),
      'tier': 'Gold',
      'points': 2850,
      'homeAirport': 'SFO',
      'emergencyContact': {
        'name': 'Sarah Johnson',
        'relationship': 'Spouse',
        'phoneNumber': '+1 (555) 987-6543',
      },
    };
  }

  List<Map<String, dynamic>> _getMockTravelPreferences() {
    return [
      {
        'icon': Icons.airline_seat_recline_extra,
        'title': 'Seat Preference',
        'value': 'Window',
      },
      {
        'icon': Icons.restaurant_menu,
        'title': 'Meal Preference',
        'value': 'Vegetarian',
      },
      {
        'icon': Icons.airline_seat_legroom_extra,
        'title': 'Cabin Class',
        'value': 'Economy Plus',
      },
      {
        'icon': Icons.language,
        'title': 'Language',
        'value': 'English',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockRecentActivity() {
    return [
      {
        'type': 'booking',
        'title': 'Booked flight to Paris',
        'description': 'London (LHR) → Paris (CDG)',
        'date': DateTime.now().subtract(Duration(days: 5)),
      },
      {
        'type': 'alert',
        'title': 'Created price alert',
        'description': 'London (LHR) → New York (JFK)',
        'date': DateTime.now().subtract(Duration(days: 8)),
      },
      {
        'type': 'search',
        'title': 'Searched for flights',
        'description': 'San Francisco (SFO) → Los Angeles (LAX)',
        'date': DateTime.now().subtract(Duration(days: 12)),
      },
      {
        'type': 'login',
        'title': 'Account login',
        'description': 'Via mobile app',
        'date': DateTime.now().subtract(Duration(days: 15)),
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
        Navigator.pushReplacementNamed(context, BookingsScreen.id);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AlertScreen.id);
        break;
      case 3:
        // Already on Profile
        break;
    }
  }

  void _editProfile() {
    // Show a dialog or navigate to edit profile page
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile'),
        content:
            Text('Profile editing will be implemented in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), // Dismiss keyboard when tapping outside
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
                ),
              )
            : CustomScrollView(
                slivers: [
                  // App Bar with Profile Header
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    backgroundColor: Color(0xFF0057B8),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(_userData['name']),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF0057B8),
                              Colors.orangeAccent,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 70, left: 16, right: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      _userData['email'],
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${_userData['tier']} Member',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: _editProfile,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Loyalty Points
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Points',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _userData['points'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: _userData['points'] /
                              5000, // Progress to next tier
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orangeAccent),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_userData['tier']} Level',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '${5000 - _userData['points']} points to Platinum',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0)),

                  // Personal Information
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0057B8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _buildInfoRow('Full Name', _userData['name']),
                                SizedBox(height: 12),
                                _buildInfoRow('Email', _userData['email']),
                                SizedBox(height: 12),
                                _buildInfoRow(
                                    'Phone', _userData['phoneNumber']),
                                SizedBox(height: 12),
                                _buildInfoRow('Address', _userData['address']),
                                SizedBox(height: 12),
                                _buildInfoRow(
                                    'Date of Birth',
                                    DateFormat('MMMM d, yyyy')
                                        .format(_userData['dateOfBirth'])),
                                SizedBox(height: 12),
                                _buildInfoRow(
                                    'Nationality', _userData['nationality']),
                                SizedBox(height: 12),
                                _buildInfoRow(
                                    'Home Airport', _userData['homeAirport']),
                                SizedBox(height: 16),
                                OutlinedButton(
                                  onPressed: _editProfile,
                                  child: Text('Edit Personal Information'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Color(0xFF0057B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 150.ms)
                          .slideY(begin: 0.2, end: 0)),

                  // Travel Documents
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Travel Documents',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0057B8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.credit_card,
                                        color: Colors.orangeAccent, size: 36),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Passport',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          SizedBox(height: 4),
                                          Text('United States',
                                              style: TextStyle(
                                                  color: Colors.grey[600])),
                                          SizedBox(height: 4),
                                          Text(
                                              'Number: ${_userData['passportNumber']}',
                                              style: TextStyle(
                                                  color: Colors.grey[600])),
                                          SizedBox(height: 4),
                                          Text(
                                              'Expires: ${DateFormat('MMMM d, yyyy').format(_userData['passportExpiry'])}',
                                              style: TextStyle(
                                                  color: Colors.grey[600])),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton.icon(
                                      icon: Icon(Icons.edit, size: 16),
                                      label: Text('Edit'),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Edit passport coming soon')));
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Color(0xFF0057B8),
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      icon: Icon(Icons.add, size: 16),
                                      label: Text('Add Document'),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Add document coming soon')));
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.orangeAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 250.ms)
                          .slideY(begin: 0.2, end: 0)),

                  // Emergency Contact
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Contact',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0057B8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _buildInfoRow('Name',
                                    _userData['emergencyContact']['name']),
                                SizedBox(height: 12),
                                _buildInfoRow(
                                    'Relationship',
                                    _userData['emergencyContact']
                                        ['relationship']),
                                SizedBox(height: 12),
                                _buildInfoRow(
                                    'Phone',
                                    _userData['emergencyContact']
                                        ['phoneNumber']),
                                SizedBox(height: 16),
                                OutlinedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Edit emergency contact coming soon')));
                                  },
                                  child: Text('Edit Emergency Contact'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Color(0xFF0057B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 350.ms)
                          .slideY(begin: 0.2, end: 0)),

                  // Recent Activity
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Activity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0057B8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _recentActivity.length,
                            itemBuilder: (context, index) {
                              final activity = _recentActivity[index];
                              return ListTile(
                                leading: _getActivityIcon(activity['type']),
                                title: Text(activity['title']),
                                subtitle: Text(activity['description']),
                                trailing: Text(
                                  _getTimeAgo(activity['date']),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 300.ms)
                          .slideY(begin: 0.2, end: 0)),

                  // Payment Methods
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Methods',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0057B8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.credit_card,
                                  color: Colors.blue[700],
                                ),
                                title: Text('Visa ending in 4242'),
                                subtitle: Text('Expires 05/25'),
                                trailing: Text('Primary'),
                              ),
                              Divider(height: 1),
                              ListTile(
                                leading: Icon(
                                  Icons.credit_card,
                                  color: Colors.deepOrange,
                                ),
                                title: Text('MasterCard ending in 8888'),
                                subtitle: Text('Expires 12/26'),
                              ),
                              Divider(height: 1),
                              ListTile(
                                leading: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green,
                                ),
                                title: Text('Add Payment Method'),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Add payment method coming soon'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 400.ms)
                          .slideY(begin: 0.2, end: 0)),

                  // Account Settings
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0057B8),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildSettingTile(
                                Icons.notifications_outlined,
                                'Notification Settings',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Notification settings coming soon')),
                                  );
                                },
                              ),
                              Divider(height: 1),
                              _buildSettingTile(
                                Icons.security_outlined,
                                'Security Settings',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Security settings coming soon')),
                                  );
                                },
                              ),
                              Divider(height: 1),
                              _buildSettingTile(
                                Icons.language_outlined,
                                'Language & Region',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Language settings coming soon')),
                                  );
                                },
                              ),
                              Divider(height: 1),
                              _buildSettingTile(
                                Icons.help_outline,
                                'Help & Support',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Help & support coming soon')),
                                  );
                                },
                              ),
                              Divider(height: 1),
                              _buildSettingTile(
                                Icons.privacy_tip_outlined,
                                'Privacy Settings',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Privacy settings coming soon')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 500.ms)
                          .slideY(begin: 0.2, end: 0)),

                  // Logout Button
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Center(
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.logout),
                        label: Text('Logout'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red[400],
                          side: BorderSide(color: Colors.red[400]!),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {
                          // Logout logic
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Logout'),
                              content: Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                        context, 'welcome_screen');
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red[400],
                                  ),
                                  child: Text('Logout'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms)),

                  // Version information
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 32),
                      child: Center(
                        child: Text(
                          'Aerlerts v1.0.0',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title,
      {required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
      onTap: onTap,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getActivityIcon(String type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case 'booking':
        iconData = Icons.airplane_ticket;
        iconColor = Colors.green;
        break;
      case 'alert':
        iconData = Icons.notifications_active;
        iconColor = Colors.orangeAccent;
        break;
      case 'search':
        iconData = Icons.search;
        iconColor = Colors.blue;
        break;
      case 'login':
        iconData = Icons.login;
        iconColor = Colors.purple;
        break;
      default:
        iconData = Icons.access_time;
        iconColor = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.2),
      radius: 16,
      child: Icon(
        iconData,
        color: iconColor,
        size: 16,
      ),
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
