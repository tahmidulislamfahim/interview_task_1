import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/features/airport_search/model/airport_model.dart';
import 'package:interview_task_1/features/airport_search/service/airport_service.dart';

class AirportController extends GetxController {
  var airports = <Airport>[].obs;
  final AirportService _airportService = AirportService();
  var filtered = <Airport>[].obs;
  final airportSearchTextController = TextEditingController();

  var departure = Rxn<Airport>();
  var arrival = Rxn<Airport>();

  var selectedTripType = "One Way".obs;
  var departureDate = DateTime.now().obs;
  var returnDate = Rxn<DateTime>();
  var travelers = 1.obs;
  var cabinClass = "Economy".obs;

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

  void resetAirportSearch() {
    airportSearchTextController.clear();
    search('');
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

  void selectTripType(String tripType) {
    selectedTripType.value = tripType;
    if (tripType == "One Way") {
      returnDate.value = null;
    }
  }

  void setDepartureDate(DateTime date) {
    departureDate.value = date;
    final currentReturnDate = returnDate.value;
    if (currentReturnDate != null && currentReturnDate.isBefore(date)) {
      returnDate.value = date.add(const Duration(days: 1));
    }
  }

  void setReturnDate(DateTime date) {
    returnDate.value = date;
  }

  void enableRoundTrip() {
    if (selectedTripType.value == "One Way") {
      selectedTripType.value = "Round Way";
    }
  }

  @override
  void onClose() {
    airportSearchTextController.dispose();
    super.onClose();
  }
}
