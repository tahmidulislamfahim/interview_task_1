import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';

import '../controller/airport_controller.dart';
import 'airport_tile.dart';
import 'search_box.dart';

class AirportSelectPage extends StatelessWidget {
  const AirportSelectPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final AirportController controller = Get.find<AirportController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBox(
            controller: controller.airportSearchTextController,
            onChanged: controller.search,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                const Text(
                  "MATCHING AIRPORTS",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${controller.filtered.length}",
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.primaryBlue),
                      SizedBox(height: 16),
                      Text(
                        "Loading airports...",
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                );
              }

              if (controller.filtered.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "No airports found",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Try a different search term",
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: controller.filtered.length,
                itemBuilder: (context, index) {
                  final airport = controller.filtered[index];
                  return AirportTile(
                    airport: airport,
                    onTap: () => Get.back(result: airport),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
