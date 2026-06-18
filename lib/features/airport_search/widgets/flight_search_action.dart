import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';

import '../../flight_search/screen/flight_search_screen.dart';
import '../controller/airport_controller.dart';

class FlightSearchAction {
  const FlightSearchAction._();

  static void onSearchPressed(AirportController controller) {
    final departure = controller.departure.value;
    final arrival = controller.arrival.value;
    final selectedTripType = controller.selectedTripType.value;
    final departureDate = controller.departureDate.value;
    final returnDate = controller.returnDate.value;

    if (departure == null || arrival == null) {
      Get.snackbar(
        "Airport Selection Required",
        "Please select both departure and arrival airports before searching.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (departure.code == arrival.code) {
      Get.snackbar(
        "Invalid Route Selection",
        "Departure and Arrival airports cannot be the same. Please choose different airports.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent.withValues(alpha: 0.9),
        colorText: AppColors.textDark,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.textDark,
        ),
        duration: const Duration(seconds: 4),
      );
      return;
    }

    if (selectedTripType == "Round Way" && returnDate == null) {
      Get.snackbar(
        "Return Date Required",
        "Please select a return date for your round trip flight.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent.withValues(alpha: 0.9),
        colorText: AppColors.textDark,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.textDark,
        ),
        duration: const Duration(seconds: 4),
      );
      return;
    }

    final depOnly = DateTime(
      departureDate.year,
      departureDate.month,
      departureDate.day,
    );

    if (depOnly.year != 2026 || depOnly.month != 6 || depOnly.day != 18) {
      Get.snackbar(
        "No Flights Available",
        "There are no flights available for your selected departure date in the mock database. Available date: June 18, 2026.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent.withValues(alpha: 0.9),
        colorText: AppColors.textDark,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.textDark,
        ),
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (returnDate != null) {
      final retOnly = DateTime(
        returnDate.year,
        returnDate.month,
        returnDate.day,
      );
      if (retOnly.isBefore(depOnly)) {
        Get.snackbar(
          "Invalid Return Date",
          "Return date cannot be before the departure date.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orangeAccent.withValues(alpha: 0.9),
          colorText: AppColors.textDark,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.textDark,
          ),
          duration: const Duration(seconds: 4),
        );
        return;
      }

      Get.snackbar(
        "No Return Flights Available",
        "The mock database does not contain any return flights on your selected return date. Only one-way flights from DAC to DXB are available.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent.withValues(alpha: 0.9),
        colorText: AppColors.textDark,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.textDark,
        ),
        duration: const Duration(seconds: 5),
      );
      return;
    }

    Get.to(() => FlightSearchScreen(departure: departure, arrival: arrival));
  }
}
