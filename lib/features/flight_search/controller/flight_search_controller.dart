import 'package:get/get.dart';
import 'package:interview_task_1/features/flight_search/model/flight_search_model.dart';
import 'package:interview_task_1/features/flight_search/service/flight_search_service.dart';

class FlightSearchController extends GetxController {
  final FlightSearchService _flightSearchService = FlightSearchService();

  var isLoading = false.obs;
  var bestFlights = <FlightRoute>[].obs;
  var otherFlights = <FlightRoute>[].obs;
  var priceInsights = Rxn<PriceInsights>();

  var expandedRouteTokens = <String>{}.obs;

  void searchFlights(String departureCode, String arrivalCode) {
    fetchFlights(departureCode: departureCode, arrivalCode: arrivalCode);
  }

  Future<void> fetchFlights({
    String? departureCode,
    String? arrivalCode,
  }) async {
    try {
      isLoading.value = true;
      final response = await _flightSearchService.fetchFlights();

      if (departureCode != null && arrivalCode != null) {
        final dep = departureCode.toUpperCase();
        final arr = arrivalCode.toUpperCase();

        bestFlights.value = response.bestFlights.where((route) {
          if (route.flights.isEmpty) return false;
          final first = route.flights.first;
          final last = route.flights.last;
          return first.departureAirport.id.toUpperCase() == dep &&
              last.arrivalAirport.id.toUpperCase() == arr;
        }).toList();

        otherFlights.value = response.otherFlights.where((route) {
          if (route.flights.isEmpty) return false;
          final first = route.flights.first;
          final last = route.flights.last;
          return first.departureAirport.id.toUpperCase() == dep &&
              last.arrivalAirport.id.toUpperCase() == arr;
        }).toList();
      } else {
        bestFlights.value = response.bestFlights;
        otherFlights.value = response.otherFlights;
      }

      priceInsights.value = response.priceInsights;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleExpansion(String token) {
    if (expandedRouteTokens.contains(token)) {
      expandedRouteTokens.remove(token);
    } else {
      expandedRouteTokens.add(token);
    }
  }

  bool isExpanded(String token) {
    return expandedRouteTokens.contains(token);
  }
}
