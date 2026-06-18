import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';
import 'package:interview_task_1/features/flight_search/model/flight_search_model.dart';

class PriceInsightsBanner extends StatelessWidget {
  final PriceInsights? insights;

  const PriceInsightsBanner({super.key, this.insights});

  @override
  Widget build(BuildContext context) {
    if (insights == null) return const SizedBox.shrink();

    final lowestPrice = insights!.lowestPrice;
    final level = insights!.priceLevel.toLowerCase();
    final range = insights!.typicalPriceRange;

    Color levelColor;
    IconData icon;
    String description;
    String rangeText = "";

    if (range.length >= 2) {
      rangeText = "Typical range: \$${range[0]} - \$${range[1]}";
    }

    if (level == 'high') {
      levelColor = AppColors.orangeText;
      icon = Icons.error_outline_rounded;
      description = "Prices are currently high";
    } else if (level == 'low') {
      levelColor = AppColors.greenText;
      icon = Icons.arrow_downward_rounded;
      description = "Prices are currently low";
    } else {
      levelColor = AppColors.primaryBlue;
      icon = Icons.info_outline_rounded;
      description = "Prices are currently typical";
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: levelColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (rangeText.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        rangeText,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    "Price History",
                    "Lowest price for this route: \$$lowestPrice",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.surface,
                    colorText: AppColors.textPrimary,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Text(
                      "View price history",
                      style: TextStyle(
                        color: AppColors.accentBlueText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.accentBlueText,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPriceIndicatorBar(lowestPrice, range),
        ],
      ),
    );
  }

  Widget _buildPriceIndicatorBar(int lowestPrice, List<int> range) {
    if (range.length < 2) return const SizedBox.shrink();

    final minTypical = range[0];
    final maxTypical = range[1];

    final double absoluteMin = minTypical - 50.0;
    final double absoluteMax = maxTypical + 50.0;
    final double totalSpread = absoluteMax - absoluteMin;

    double position = (lowestPrice - absoluteMin) / totalSpread;
    position = position.clamp(0.02, 0.98);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: const LinearGradient(
                  colors: [AppColors.priceLow, AppColors.priceTypical, AppColors.priceHigh],
                  stops: [0.2, 0.5, 0.8],
                ),
              ),
            ),
            Align(
              alignment: Alignment(position * 2 - 1, 0),
              child: Container(
                height: 14,
                width: 14,
                decoration: const BoxDecoration(
                  color: AppColors.textPrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Center(
                  child: Container(
                    height: 6,
                    width: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${minTypical - 50}",
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
            Text(
              "Current: \$$lowestPrice",
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${maxTypical + 50}",
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}
