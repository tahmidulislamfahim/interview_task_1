import 'package:flutter/material.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';
import 'package:interview_task_1/features/airport_search/model/airport_model.dart';

class AirportTile extends StatelessWidget {
  final Airport airport;
  final VoidCallback onTap;

  const AirportTile({
    super.key,
    required this.airport,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.15),
          child: Text(
            airport.code ?? 'N/A',
            style: const TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        title: Text(
          airport.name ?? 'N/A',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${airport.city}, ${airport.country}",
          style: const TextStyle(color: AppColors.textMuted),
        ),
        trailing: const Icon(Icons.flight_takeoff, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}