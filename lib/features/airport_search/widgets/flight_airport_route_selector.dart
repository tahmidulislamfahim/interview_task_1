import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';

import '../controller/airport_controller.dart';
import '../model/airport_model.dart';
import 'airport_select_widget.dart';
import 'airport_selector.dart';

class FlightAirportRouteSelector extends StatelessWidget {
  const FlightAirportRouteSelector({super.key, required this.controller});

  final AirportController controller;

  Future<void> _selectDepartureAirport() async {
    controller.resetAirportSearch();
    final selected = await Get.to<Airport>(
      () => const AirportSelectPage(title: "Select Departure Airport"),
    );
    if (selected != null) {
      controller.setDeparture(selected);
    }
  }

  Future<void> _selectArrivalAirport() async {
    controller.resetAirportSearch();
    final selected = await Get.to<Airport>(
      () => const AirportSelectPage(title: "Select Arrival Airport"),
    );
    if (selected != null) {
      controller.setArrival(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Obx(() {
                final dep = controller.departure.value;
                return AirportSelector(
                  label: "FROM",
                  title: dep != null ? (dep.city ?? "Select") : "Select",
                  subtitle: dep != null
                      ? "${dep.code}, ${dep.name}"
                      : "Departure Airport",
                  onTap: _selectDepartureAirport,
                  alignRight: false,
                );
              }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Obx(() {
                final arr = controller.arrival.value;
                return AirportSelector(
                  label: "TO",
                  title: arr != null ? (arr.city ?? "Select") : "Select",
                  subtitle: arr != null
                      ? "${arr.code}, ${arr.name}"
                      : "Arrival Airport",
                  onTap: _selectArrivalAirport,
                  alignRight: true,
                );
              }),
            ),
          ],
        ),
        GestureDetector(
          onTap: controller.swapAirports,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.swap_horiz_rounded,
              color: AppColors.primaryBlue,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
