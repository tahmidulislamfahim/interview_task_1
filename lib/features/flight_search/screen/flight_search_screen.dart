import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';
import 'package:interview_task_1/features/airport_search/model/airport_model.dart';
import 'package:interview_task_1/features/flight_search/controller/flight_search_controller.dart';
import 'package:interview_task_1/features/flight_search/widgets/flight_card.dart';
import 'package:interview_task_1/features/flight_search/widgets/price_insights_banner.dart';
import 'package:interview_task_1/features/flight_search/widgets/select_flight_sheet.dart';

class FlightSearchScreen extends StatelessWidget {
  final Airport? departure;
  final Airport? arrival;

  final FlightSearchController controller = Get.put(FlightSearchController());

  FlightSearchScreen({
    super.key,
    required this.departure,
    required this.arrival,
  }) {
    if (departure?.code != null && arrival?.code != null) {
      controller.searchFlights(departure!.code!, arrival!.code!);
    } else {
      controller.fetchFlights();
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeTitle = (departure != null && arrival != null)
        ? "${departure!.city} to ${arrival!.city}"
        : "Flight Search Results";

    const routeSubtitle = "One way • 1 traveler • Economy";

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(routeTitle),
              const SizedBox(height: 2),
              const Text(
                routeSubtitle,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                Get.snackbar(
                  "Share",
                  "Sharing flight options...",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.surface,
                  colorText: AppColors.textPrimary,
                );
              },
            ),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primaryBlue),
                  SizedBox(height: 16),
                  Text(
                    "Searching for the best flights...",
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                ],
              ),
            );
          }

          if (controller.bestFlights.isEmpty &&
              controller.otherFlights.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.flight_land_rounded,
                    size: 64,
                    color: AppColors.border,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No flights found",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Try checking your connection or selecting different airports.",
                    style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (departure?.code != null && arrival?.code != null) {
                        controller.searchFlights(
                          departure!.code!,
                          arrival!.code!,
                        );
                      } else {
                        controller.fetchFlights();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: AppColors.textDark,
                    ),
                    child: const Text("Retry Search"),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              // Best Flights Section
              if (controller.bestFlights.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                  child: Text(
                    "Best departing flights",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.bestFlights.length,
                  itemBuilder: (context, index) {
                    final route = controller.bestFlights[index];
                    return Obx(() {
                      final isExpanded = controller.isExpanded(
                        route.bookingToken,
                      );
                      return FlightCard(
                        route: route,
                        isExpanded: isExpanded,
                        onToggle: () =>
                            controller.toggleExpansion(route.bookingToken),
                        onSelect: () => SelectFlightSheet.show(context, route),
                      );
                    });
                  },
                ),
              ],

              // Price Insights Banner
              if (controller.priceInsights.value != null)
                PriceInsightsBanner(insights: controller.priceInsights.value),

              // Other Flights Section
              if (controller.otherFlights.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                  child: Text(
                    "Other departing flights",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.otherFlights.length,
                  itemBuilder: (context, index) {
                    final route = controller.otherFlights[index];
                    return Obx(() {
                      final isExpanded = controller.isExpanded(
                        route.bookingToken,
                      );
                      return FlightCard(
                        route: route,
                        isExpanded: isExpanded,
                        onToggle: () =>
                            controller.toggleExpansion(route.bookingToken),
                        onSelect: () => SelectFlightSheet.show(context, route),
                      );
                    });
                  },
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
