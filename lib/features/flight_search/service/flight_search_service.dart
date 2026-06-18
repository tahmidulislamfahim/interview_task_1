import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview_task_1/core/endpoints/endpoints.dart';
import 'package:interview_task_1/features/flight_search/model/flight_search_model.dart';

class FlightSearchService {
  Future<FlightSearchResponse> fetchFlights() async {
    final response = await http.get(Uri.parse(Endpoints.flightSearch));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return FlightSearchResponse.fromJson(data);
    } else {
      throw Exception("Failed to load flights");
    }
  }
}
