import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview_task_1/core/endpoints/endpoints.dart';
import 'package:interview_task_1/features/home/model/airport_model.dart';

class AirportService {

  Future<List<Airport>> fetchAirports() async {
    final response = await http.get(Uri.parse(Endpoints.baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as Map<String, dynamic>;

      List<Airport> airports = [];

      data.forEach((key, value) {
        airports.add(Airport.fromJson(key, value));
      });

      return airports;
    } else {
      throw Exception("Failed to load airports");
    }
  }
}