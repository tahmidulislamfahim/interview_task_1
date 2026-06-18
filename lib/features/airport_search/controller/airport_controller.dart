import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/features/airport_search/model/airport_model.dart';
import 'package:interview_task_1/features/airport_search/service/airport_service.dart';

class AirportController extends GetxController {
  var airports = <Airport>[].obs;
  final AirportService _airportService = AirportService();
  var filtered = <Airport>[].obs;

  var departure = Rxn<Airport>();
  var arrival = Rxn<Airport>();

  var isLoading = false.obs;

  @override
  void onInit() {
    fetchAirports();
    super.onInit();
  }

  Future<void> fetchAirports() async {
    try {
      isLoading.value = true;

      final data = await _airportService.fetchAirports();
      airports.value = data;
      filtered.value = data;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching airports: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      filtered.value = airports;
    } else {
      filtered.value = airports.where((a) {
        return a.name!.toLowerCase().contains(query.toLowerCase()) ||
            a.code!.toLowerCase().contains(query.toLowerCase()) ||
            a.city!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void setDeparture(Airport airport) {
    departure.value = airport;
  }

  void setArrival(Airport airport) {
    arrival.value = airport;
  }

  void swapAirports() {
    final temp = departure.value;
    departure.value = arrival.value;
    arrival.value = temp;
  }
}
