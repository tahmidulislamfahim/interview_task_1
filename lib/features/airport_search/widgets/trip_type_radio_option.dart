import 'package:flutter/material.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';

class TripTypeRadioOption extends StatelessWidget {
  const TripTypeRadioOption({
    super.key,
    required this.label,
    required this.selectedTripType,
    required this.onSelected,
  });

  final String label;
  final String selectedTripType;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedTripType == label;

    return GestureDetector(
      onTap: () => onSelected(label),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primaryBlue : AppColors.textMuted,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(3),
            child: isSelected
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryBlue,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.textPrimary : AppColors.textMuted,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
