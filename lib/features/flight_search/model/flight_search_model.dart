class FlightSearchResponse {
  final List<FlightRoute> bestFlights;
  final List<FlightRoute> otherFlights;
  final PriceInsights? priceInsights;

  FlightSearchResponse({
    required this.bestFlights,
    required this.otherFlights,
    this.priceInsights,
  });

  factory FlightSearchResponse.fromJson(Map<String, dynamic> json) {
    var bestList = json['best_flights'] as List? ?? [];
    List<FlightRoute> bestFlights = bestList
        .map((e) => FlightRoute.fromJson(e))
        .toList();

    var otherList = json['other_flights'] as List? ?? [];
    List<FlightRoute> otherFlights = otherList
        .map((e) => FlightRoute.fromJson(e))
        .toList();

    PriceInsights? priceInsights = json['price_insights'] != null
        ? PriceInsights.fromJson(json['price_insights'])
        : null;

    return FlightSearchResponse(
      bestFlights: bestFlights,
      otherFlights: otherFlights,
      priceInsights: priceInsights,
    );
  }
}

class FlightRoute {
  final List<FlightSegment> flights;
  final List<Layover> layovers;
  final int totalDuration;
  final CarbonEmissions? carbonEmissions;
  final int price;
  final String type;
  final String airlineLogo;
  final String bookingToken;

  FlightRoute({
    required this.flights,
    required this.layovers,
    required this.totalDuration,
    this.carbonEmissions,
    required this.price,
    required this.type,
    required this.airlineLogo,
    required this.bookingToken,
  });

  factory FlightRoute.fromJson(Map<String, dynamic> json) {
    var flightsList = json['flights'] as List? ?? [];
    List<FlightSegment> flights = flightsList
        .map((e) => FlightSegment.fromJson(e))
        .toList();

    var layoversList = json['layovers'] as List? ?? [];
    List<Layover> layovers = layoversList
        .map((e) => Layover.fromJson(e))
        .toList();

    CarbonEmissions? carbonEmissions = json['carbon_emissions'] != null
        ? CarbonEmissions.fromJson(json['carbon_emissions'])
        : null;

    return FlightRoute(
      flights: flights,
      layovers: layovers,
      totalDuration: json['total_duration'] ?? 0,
      carbonEmissions: carbonEmissions,
      price: json['price'] ?? 0,
      type: json['type'] ?? '',
      airlineLogo: json['airline_logo'] ?? '',
      bookingToken: json['booking_token'] ?? '',
    );
  }

  String get stopsText {
    if (flights.length <= 1) {
      return "Nonstop";
    } else {
      int stops = flights.length - 1;
      return "$stops stop${stops > 1 ? 's' : ''}";
    }
  }

  String get durationFormatted {
    int hours = totalDuration ~/ 60;
    int minutes = totalDuration % 60;
    if (hours > 0) {
      return "$hours hr $minutes min";
    }
    return "$minutes min";
  }
}

class FlightSegment {
  final AirportDetail departureAirport;
  final AirportDetail arrivalAirport;
  final int duration;
  final String airplane;
  final String airline;
  final String airlineLogo;
  final String travelClass;
  final String flightNumber;
  final String legroom;
  final List<String> extensions;
  final bool overnight;

  FlightSegment({
    required this.departureAirport,
    required this.arrivalAirport,
    required this.duration,
    required this.airplane,
    required this.airline,
    required this.airlineLogo,
    required this.travelClass,
    required this.flightNumber,
    required this.legroom,
    required this.extensions,
    required this.overnight,
  });

  factory FlightSegment.fromJson(Map<String, dynamic> json) {
    var extList = json['extensions'] as List? ?? [];
    List<String> extensions = extList.map((e) => e.toString()).toList();

    return FlightSegment(
      departureAirport: AirportDetail.fromJson(json['departure_airport'] ?? {}),
      arrivalAirport: AirportDetail.fromJson(json['arrival_airport'] ?? {}),
      duration: json['duration'] ?? 0,
      airplane: json['airplane'] ?? '',
      airline: json['airline'] ?? '',
      airlineLogo: json['airline_logo'] ?? '',
      travelClass: json['travel_class'] ?? '',
      flightNumber: json['flight_number'] ?? '',
      legroom: json['legroom'] ?? '',
      extensions: extensions,
      overnight: json['overnight'] ?? false,
    );
  }

  String get durationFormatted {
    int hours = duration ~/ 60;
    int minutes = duration % 60;
    if (hours > 0) {
      return "$hours hr $minutes min";
    }
    return "$minutes min";
  }
}

class AirportDetail {
  final String name;
  final String id;
  final String time;

  AirportDetail({required this.name, required this.id, required this.time});

  factory AirportDetail.fromJson(Map<String, dynamic> json) {
    return AirportDetail(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      time: json['time'] ?? '',
    );
  }

  DateTime? get parsedTime {
    if (time.isEmpty) return null;
    return DateTime.tryParse(time.replaceAll(' ', 'T'));
  }
}

class CarbonEmissions {
  final int thisFlight;
  final int typicalForThisRoute;
  final int differencePercent;

  CarbonEmissions({
    required this.thisFlight,
    required this.typicalForThisRoute,
    required this.differencePercent,
  });

  factory CarbonEmissions.fromJson(Map<String, dynamic> json) {
    return CarbonEmissions(
      thisFlight: json['this_flight'] ?? 0,
      typicalForThisRoute: json['typical_for_this_route'] ?? 0,
      differencePercent: json['difference_percent'] ?? 0,
    );
  }

  String get label => "${(thisFlight / 1000).toStringAsFixed(0)} kg CO₂";
}

class Layover {
  final int duration;
  final String name;
  final String id;

  Layover({required this.duration, required this.name, required this.id});

  factory Layover.fromJson(Map<String, dynamic> json) {
    return Layover(
      duration: json['duration'] ?? 0,
      name: json['name'] ?? '',
      id: json['id'] ?? '',
    );
  }

  String get durationFormatted {
    int hours = duration ~/ 60;
    int minutes = duration % 60;
    if (hours > 0) {
      return "$hours hr $minutes min";
    }
    return "$minutes min";
  }
}

class PriceInsights {
  final int lowestPrice;
  final String priceLevel;
  final List<int> typicalPriceRange;

  PriceInsights({
    required this.lowestPrice,
    required this.priceLevel,
    required this.typicalPriceRange,
  });

  factory PriceInsights.fromJson(Map<String, dynamic> json) {
    var rangeList = json['typical_price_range'] as List? ?? [];
    List<int> typicalPriceRange = rangeList
        .map((e) => (e as num).toInt())
        .toList();

    return PriceInsights(
      lowestPrice: json['lowest_price'] ?? 0,
      priceLevel: json['price_level'] ?? '',
      typicalPriceRange: typicalPriceRange,
    );
  }
}
