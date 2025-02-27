// lib/models/flight_routes.dart

class Airport {
  final String code;
  final String name;
  final String city;
  final String country;
  final double latitude;
  final double longitude;

  Airport({
    required this.code,
    required this.name,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
  });
}

class Airline {
  final String code;
  final String name;
  final String logo;
  final String country;

  Airline({
    required this.code,
    required this.name,
    required this.logo,
    required this.country,
  });
}

class Route {
  final String id;
  final String airlineCode;
  final String sourceAirportCode;
  final String destinationAirportCode;
  final List<String> flightDays; // 0-6 representing Sun-Sat
  final String flightNumber;
  final bool isActive;

  Route({
    required this.id,
    required this.airlineCode,
    required this.sourceAirportCode,
    required this.destinationAirportCode,
    required this.flightDays,
    required this.flightNumber,
    this.isActive = true,
  });
}

class FlightPrice {
  final String routeId;
  final DateTime date;
  final double economyPrice;
  final double? businessPrice;
  final double? firstClassPrice;
  final int availableSeats;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final int stops;

  FlightPrice({
    required this.routeId,
    required this.date,
    required this.economyPrice,
    this.businessPrice,
    this.firstClassPrice,
    required this.availableSeats,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    this.stops = 0,
  });
}

// Mock data provider
class FlightRoutesData {
  static final List<Airport> airports = [
    Airport(
      code: 'LHR',
      name: 'Heathrow Airport',
      city: 'London',
      country: 'United Kingdom',
      latitude: 51.4700,
      longitude: -0.4543,
    ),
    Airport(
      code: 'JFK',
      name: 'John F. Kennedy International Airport',
      city: 'New York',
      country: 'United States',
      latitude: 40.6413,
      longitude: -73.7781,
    ),
    Airport(
      code: 'CDG',
      name: 'Charles de Gaulle Airport',
      city: 'Paris',
      country: 'France',
      latitude: 49.0097,
      longitude: 2.5479,
    ),
    Airport(
      code: 'SFO',
      name: 'San Francisco International Airport',
      city: 'San Francisco',
      country: 'United States',
      latitude: 37.6213,
      longitude: -122.3790,
    ),
    Airport(
      code: 'LAX',
      name: 'Los Angeles International Airport',
      city: 'Los Angeles',
      country: 'United States',
      latitude: 33.9416,
      longitude: -118.4085,
    ),
    Airport(
      code: 'DXB',
      name: 'Dubai International Airport',
      city: 'Dubai',
      country: 'United Arab Emirates',
      latitude: 25.2532,
      longitude: 55.3657,
    ),
    Airport(
      code: 'HKG',
      name: 'Hong Kong International Airport',
      city: 'Hong Kong',
      country: 'China',
      latitude: 22.3080,
      longitude: 113.9185,
    ),
    Airport(
      code: 'SYD',
      name: 'Sydney Airport',
      city: 'Sydney',
      country: 'Australia',
      latitude: -33.9399,
      longitude: 151.1753,
    ),
  ];

  static final List<Airline> airlines = [
    Airline(
      code: 'OA',
      name: 'Oceanic Air',
      logo: 'oceanic_logo.png',
      country: 'United States',
    ),
    Airline(
      code: 'AJ',
      name: 'Ajira Airways',
      logo: 'ajira_logo.png',
      country: 'Australia',
    ),
    Airline(
      code: 'PA',
      name: 'Pan Atlantic',
      logo: 'pan_atlantic_logo.png',
      country: 'United Kingdom',
    ),
    Airline(
      code: 'EM',
      name: 'Emirates',
      logo: 'emirates_logo.png',
      country: 'United Arab Emirates',
    ),
    Airline(
      code: 'BA',
      name: 'British Airways',
      logo: 'ba_logo.png',
      country: 'United Kingdom',
    ),
  ];

  static final List<Route> routes = [
    Route(
      id: 'r1',
      airlineCode: 'OA',
      sourceAirportCode: 'LHR',
      destinationAirportCode: 'JFK',
      flightDays: ['1', '3', '5', '6'], // Mon, Wed, Fri, Sat
      flightNumber: 'OA815',
    ),
    Route(
      id: 'r2',
      airlineCode: 'AJ',
      sourceAirportCode: 'SFO',
      destinationAirportCode: 'LAX',
      flightDays: ['0', '1', '2', '3', '4', '5', '6'], // Every day
      flightNumber: 'AJ316',
    ),
    Route(
      id: 'r3',
      airlineCode: 'PA',
      sourceAirportCode: 'LHR',
      destinationAirportCode: 'CDG',
      flightDays: ['1', '2', '4', '6'], // Mon, Tue, Thu, Sat
      flightNumber: 'PA423',
    ),
    Route(
      id: 'r4',
      airlineCode: 'EM',
      sourceAirportCode: 'LHR',
      destinationAirportCode: 'DXB',
      flightDays: ['0', '1', '3', '5'], // Sun, Mon, Wed, Fri
      flightNumber: 'EM241',
    ),
    Route(
      id: 'r5',
      airlineCode: 'BA',
      sourceAirportCode: 'LHR',
      destinationAirportCode: 'SYD',
      flightDays: ['0', '3', '6'], // Sun, Wed, Sat
      flightNumber: 'BA117',
    ),
    Route(
      id: 'r6',
      airlineCode: 'OA',
      sourceAirportCode: 'JFK',
      destinationAirportCode: 'LAX',
      flightDays: ['0', '1', '2', '3', '4', '5', '6'], // Every day
      flightNumber: 'OA345',
    ),
    Route(
      id: 'r7',
      airlineCode: 'AJ',
      sourceAirportCode: 'HKG',
      destinationAirportCode: 'SYD',
      flightDays: ['1', '3', '5'], // Mon, Wed, Fri
      flightNumber: 'AJ789',
    ),
    Route(
      id: 'r8',
      airlineCode: 'PA',
      sourceAirportCode: 'CDG',
      destinationAirportCode: 'DXB',
      flightDays: ['0', '2', '4', '6'], // Sun, Tue, Thu, Sat
      flightNumber: 'PA511',
    ),
  ];

  // Generate random flight prices for routes over the next 90 days
  static List<FlightPrice> generateFlightPrices() {
    final List<FlightPrice> prices = [];
    final now = DateTime.now();

    for (var route in routes) {
      for (int i = 0; i < 90; i++) {
        final date = now.add(Duration(days: i));
        final dayOfWeek = date.weekday % 7; // 0 = Sunday, 6 = Saturday

        // Check if flight operates on this day
        if (route.flightDays.contains(dayOfWeek.toString())) {
          // Base price with some randomness
          double basePrice = 0;

          // Set different base prices for different routes
          if (route.id == 'r1')
            basePrice = 450; // LHR-JFK
          else if (route.id == 'r2')
            basePrice = 150; // SFO-LAX
          else if (route.id == 'r3')
            basePrice = 180; // LHR-CDG
          else if (route.id == 'r4')
            basePrice = 550; // LHR-DXB
          else if (route.id == 'r5')
            basePrice = 1200; // LHR-SYD
          else if (route.id == 'r6')
            basePrice = 350; // JFK-LAX
          else if (route.id == 'r7')
            basePrice = 600; // HKG-SYD
          else if (route.id == 'r8') basePrice = 450; // CDG-DXB

          // Add price variation based on how far in advance
          double priceMultiplier = 1.0;
          if (i < 7)
            priceMultiplier = 1.5; // Last minute = expensive
          else if (i < 14)
            priceMultiplier = 1.3;
          else if (i < 30)
            priceMultiplier = 1.0;
          else if (i < 60)
            priceMultiplier = 0.9; // Sweet spot
          else
            priceMultiplier = 1.1; // Too far ahead = more expensive again

          // Weekend premium
          if (dayOfWeek == 5 || dayOfWeek == 6) {
            // Friday or Saturday
            priceMultiplier *= 1.1;
          }

          final economyPrice = (basePrice *
                  priceMultiplier *
                  (0.9 + 0.2 * DateTime.now().millisecondsSinceEpoch % 10 / 10))
              .roundToDouble();
          final businessPrice = economyPrice * 2.5;
          final firstClassPrice = route.id == 'r2' || route.id == 'r3'
              ? null
              : economyPrice * 4; // Some routes don't have first class

          // Generate departure and arrival times
          String departureTime;
          String arrivalTime;
          String duration;

          if (route.id == 'r1') {
            departureTime = '08:15';
            arrivalTime = '11:30';
            duration = '7h 15m';
          } else if (route.id == 'r2') {
            departureTime = '12:45';
            arrivalTime = '14:20';
            duration = '1h 35m';
          } else if (route.id == 'r3') {
            departureTime = '16:30';
            arrivalTime = '18:45';
            duration = '2h 15m';
          } else if (route.id == 'r4') {
            departureTime = '22:15';
            arrivalTime = '08:30';
            duration = '7h 15m';
          } else if (route.id == 'r5') {
            departureTime = '21:30';
            arrivalTime = '17:45';
            duration = '23h 15m';
          } else if (route.id == 'r6') {
            departureTime = '10:00';
            arrivalTime = '13:30';
            duration = '6h 30m';
          } else if (route.id == 'r7') {
            departureTime = '09:45';
            arrivalTime = '21:15';
            duration = '9h 30m';
          } else {
            departureTime = '14:20';
            arrivalTime = '23:50';
            duration = '6h 30m';
          }

          // Some routes have stops
          int stops = 0;
          if (route.id == 'r5') stops = 1; // LHR-SYD has a stop
          if (route.id == 'r7') stops = 1; // HKG-SYD has a stop
          if (route.id == 'r8' && dayOfWeek % 2 == 0)
            stops = 1; // Some CDG-DXB flights have a stop

          prices.add(FlightPrice(
            routeId: route.id,
            date: date,
            economyPrice: economyPrice,
            businessPrice: businessPrice,
            firstClassPrice: firstClassPrice,
            availableSeats:
                20 + (DateTime.now().millisecondsSinceEpoch % 60).toInt(),
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            duration: duration,
            stops: stops,
          ));
        }
      }
    }

    return prices;
  }

  // Search flights by origin, destination, and date
  static List<Map<String, dynamic>> searchFlights({
    required String origin,
    required String destination,
    required DateTime date,
    String? cabinClass,
  }) {
    // Normalize input
    origin = origin.toUpperCase().trim();
    destination = destination.toUpperCase().trim();
    cabinClass = cabinClass ?? 'Economy';

    // Find matching airports (exact code or partial city/name match)
    List<String> originAirportCodes = _findMatchingAirports(origin);
    List<String> destAirportCodes = _findMatchingAirports(destination);

    if (originAirportCodes.isEmpty || destAirportCodes.isEmpty) {
      return [];
    }

    // Find matching routes
    List<Route> matchingRoutes = routes.where((route) {
      return originAirportCodes.contains(route.sourceAirportCode) &&
          destAirportCodes.contains(route.destinationAirportCode) &&
          route.isActive;
    }).toList();

    if (matchingRoutes.isEmpty) {
      return [];
    }

    // Get prices for these routes on the specified date
    List<FlightPrice> prices = generateFlightPrices();
    List<FlightPrice> matchingPrices = prices.where((price) {
      return matchingRoutes.any((route) => route.id == price.routeId) &&
          _isSameDay(price.date, date);
    }).toList();

    if (matchingPrices.isEmpty) {
      return [];
    }

    // Build result objects with all needed details
    List<Map<String, dynamic>> results = [];

    for (var price in matchingPrices) {
      final route = routes.firstWhere((r) => r.id == price.routeId);
      final airline = airlines.firstWhere((a) => a.code == route.airlineCode);
      final sourceAirport =
          airports.firstWhere((a) => a.code == route.sourceAirportCode);
      final destAirport =
          airports.firstWhere((a) => a.code == route.destinationAirportCode);

      double flightPrice;
      switch (cabinClass) {
        case 'Business':
          flightPrice = price.businessPrice ?? price.economyPrice * 2.5;
          break;
        case 'First Class':
          flightPrice = price.firstClassPrice ?? price.economyPrice * 4;
          break;
        default: // Economy
          flightPrice = price.economyPrice;
      }

      results.add({
        'routeId': route.id,
        'flightNumber': route.flightNumber,
        'airline': airline.name,
        'airlineCode': airline.code,
        'origin': sourceAirport.city,
        'originCode': sourceAirport.code,
        'originAirport': sourceAirport.name,
        'destination': destAirport.city,
        'destinationCode': destAirport.code,
        'destinationAirport': destAirport.name,
        'departureDate': price.date,
        'departureTime': price.departureTime,
        'arrivalTime': price.arrivalTime,
        'duration': price.duration,
        'price': flightPrice,
        'cabinClass': cabinClass,
        'availableSeats': price.availableSeats,
        'stops': price.stops,
      });
    }

    // Sort by price
    results
        .sort((a, b) => (a['price'] as double).compareTo(b['price'] as double));

    return results;
  }

  // Helper method to find airports by code or partial city/name match
  static List<String> _findMatchingAirports(String query) {
    // First try exact code match
    final exactMatches =
        airports.where((airport) => airport.code == query).toList();
    if (exactMatches.isNotEmpty) {
      return exactMatches.map((a) => a.code).toList();
    }

    // Then try partial city or name match
    final partialMatches = airports.where((airport) {
      return airport.city.toUpperCase().contains(query) ||
          airport.name.toUpperCase().contains(query);
    }).toList();

    return partialMatches.map((a) => a.code).toList();
  }

  // Helper method to check if two dates are the same day
  static bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
