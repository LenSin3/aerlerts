// lib/search_screens/create_alert.dart
import 'package:aerlerts/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAlertScreen extends StatefulWidget {
  static const id = 'create_alert_screen';

  @override
  _CreateAlertScreenState createState() => _CreateAlertScreenState();
}

class _CreateAlertScreenState extends State<CreateAlertScreen> {
  String? origin;
  String? destination;
  DateTime? selectedDate;
  double? targetPrice;
  bool isFlexible = false;

  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now().add(Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orangeAccent,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Create New Price Alert',
            style: TextStyle(
              color: Color(0xFF0057B8),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF0057B8)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We\'ll notify you when a flight matches your criteria and price target.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 24),

              // Origin Input
              Text(
                'From',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: originController,
                decoration: InputDecoration(
                  hintText: 'Airport or city',
                  prefixIcon:
                      Icon(Icons.flight_takeoff, color: Colors.orangeAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
              ),
              SizedBox(height: 16),

              // Destination Input
              Text(
                'To',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  hintText: 'Airport or city',
                  prefixIcon:
                      Icon(Icons.flight_land, color: Colors.orangeAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
              ),
              SizedBox(height: 16),

              // Date Selection
              Text(
                'When',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  hintText: 'Select a date',
                  prefixIcon:
                      Icon(Icons.calendar_today, color: Colors.orangeAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
              ),

              // Flexible Dates Option
              Row(
                children: [
                  Checkbox(
                    value: isFlexible,
                    activeColor: Colors.orangeAccent,
                    onChanged: (value) {
                      setState(() {
                        isFlexible = value ?? false;
                      });
                    },
                  ),
                  Text('Flexible dates (+/- 3 days)'),
                ],
              ),
              SizedBox(height: 16),

              // Price Target
              Text(
                'Target Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Your maximum price',
                  prefixIcon:
                      Icon(Icons.attach_money, color: Colors.orangeAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
              ),
              SizedBox(height: 30),

              Center(
                child: RoundedButton(
                  color: Colors.orangeAccent,
                  text: 'Create Alert',
                  onPressed: () {
                    // Validate inputs
                    if (originController.text.isEmpty ||
                        destinationController.text.isEmpty ||
                        dateController.text.isEmpty ||
                        priceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Return to alerts screen with success message
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
