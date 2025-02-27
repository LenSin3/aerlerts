// lib/models/flight_alert.dart

class FlightAlert {
  final String id;
  final String origin;
  final String destination;
  final DateTime startDate;
  final DateTime? endDate;
  final double targetPrice;
  final bool isActive;
  final DateTime createdAt;

  FlightAlert({
    required this.id,
    required this.origin,
    required this.destination,
    required this.startDate,
    this.endDate,
    required this.targetPrice,
    this.isActive = true,
    required this.createdAt,
  });

  FlightAlert copyWith({
    String? id,
    String? origin,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    double? targetPrice,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return FlightAlert(
      id: id ?? this.id,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      targetPrice: targetPrice ?? this.targetPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
