import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';
import 'package:interview_task_1/core/common/widgets/date_formatter.dart';

import '../controller/airport_controller.dart';

class FlightDateSelector extends StatelessWidget {
  const FlightDateSelector({super.key, required this.controller});

  final AirportController controller;

  Future<void> _selectDepartureDate(BuildContext context) async {
    final departureDate = controller.departureDate.value;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: _datePickerBuilder,
    );
    if (picked != null && picked != departureDate) {
      controller.setDepartureDate(picked);
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    controller.enableRoundTrip();

    final departureDate = controller.departureDate.value;
    final returnDate = controller.returnDate.value;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: returnDate ?? departureDate.add(const Duration(days: 7)),
      firstDate: departureDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: _datePickerBuilder,
    );
    if (picked != null) {
      controller.setReturnDate(picked);
    }
  }

  Widget _datePickerBuilder(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryBlue,
          onPrimary: AppColors.textDark,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: AppColors.scaffoldBg,
        ),
      ),
      child: child!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedTripType = controller.selectedTripType.value;
      final departureDate = controller.departureDate.value;
      final returnDate = controller.returnDate.value;
      final hasReturnDate = returnDate != null && selectedTripType != "One Way";

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: _DateTile(
                label: "DEPARTURE DATE",
                title: formatDayMonthYear(departureDate),
                subtitle: getWeekdayName(departureDate),
                titleColor: AppColors.textPrimary,
                titleSize: 15,
                titleWeight: FontWeight.bold,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                onTap: () => _selectDepartureDate(context),
              ),
            ),
            Container(width: 1, height: 60, color: AppColors.border),
            Expanded(
              child: _DateTile(
                label: "RETURN DATE",
                title: hasReturnDate
                    ? formatDayMonthYear(returnDate)
                    : "Save more on return flight",
                subtitle: hasReturnDate
                    ? getWeekdayName(returnDate)
                    : "Tap to add round trip",
                titleColor: hasReturnDate
                    ? AppColors.textPrimary
                    : AppColors.textMuted,
                titleSize: hasReturnDate ? 15 : 12,
                titleWeight: hasReturnDate
                    ? FontWeight.bold
                    : FontWeight.normal,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                onTap: () => _selectReturnDate(context),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.titleSize,
    required this.titleWeight,
    required this.borderRadius,
    required this.onTap,
  });

  final String label;
  final String title;
  final String subtitle;
  final Color titleColor;
  final double titleSize;
  final FontWeight titleWeight;
  final BorderRadius borderRadius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: titleSize,
                fontWeight: titleWeight,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
