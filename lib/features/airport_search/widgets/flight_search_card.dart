import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';

import '../controller/airport_controller.dart';
import 'flight_airport_route_selector.dart';
import 'flight_date_selector.dart';
import 'flight_search_action.dart';
import 'flight_search_button.dart';
import 'traveler_class_selector.dart';
import 'trip_type_radio_option.dart';

class FlightSearchCard extends StatelessWidget {
  FlightSearchCard({super.key});

  final AirportController controller = Get.find<AirportController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 24),
            padding: const EdgeInsets.fromLTRB(16, 42, 16, 36),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final selectedTripType = controller.selectedTripType.value;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TripTypeRadioOption(
                        label: "One Way",
                        selectedTripType: selectedTripType,
                        onSelected: controller.selectTripType,
                      ),
                      const SizedBox(width: 16),
                      TripTypeRadioOption(
                        label: "Round Way",
                        selectedTripType: selectedTripType,
                        onSelected: controller.selectTripType,
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                FlightAirportRouteSelector(controller: controller),
                const SizedBox(height: 12),
                FlightDateSelector(controller: controller),
                const SizedBox(height: 12),
                TravelerClassSelector(controller: controller),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: FlightSearchButton(
              onPressed: () => FlightSearchAction.onSearchPressed(controller),
            ),
          ),
        ],
      ),
    );
  }
}
