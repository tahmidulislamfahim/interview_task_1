import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:interview_task_1/core/common/colors/app_colors.dart';
import '../controller/airport_controller.dart';
import '../widgets/flight_search_card.dart';

class AirportScreen extends StatelessWidget {
  AirportScreen({super.key});

  final AirportController controller = Get.put(AirportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              "Flight Search",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Select your airports to get started",
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(child: FlightSearchCard()),
            ),
          );
        },
      ),
    );
  }
}
