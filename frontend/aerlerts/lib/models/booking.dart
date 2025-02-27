// lib/models/booking.dart

class Booking {
  final String id;
  final String airline;
  final String flightNumber;
  final String origin;
  final String originCode;
  final String destination;
  final String destinationCode;
  final DateTime departureDate;
  final String departureTime;
  final String arrivalTime;
  final double price;
  final int stops;
  final String duration;
  final String status; // "Confirmed", "Pending", "Cancelled"
  final bool hasAlert;
  final String? alertId;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.origin,
    required this.originCode,
    required this.destination,
    required this.destinationCode,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.stops,
    required this.duration,
    required this.status,
    this.hasAlert = false,
    this.alertId,
    required this.bookingDate,
  });
}
