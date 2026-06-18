import 'package:flutter/material.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';
import 'package:interview_task_1/core/common/widgets/date_formatter.dart';
import 'package:interview_task_1/features/flight_search/model/flight_search_model.dart';

class FlightSegments extends StatelessWidget {
  const FlightSegments({super.key, required this.segment});

  final FlightSegment segment;

  @override
  Widget build(BuildContext context) {
    final depTime = segment.departureAirport.parsedTime;
    final arrTime = segment.arrivalAirport.parsedTime;
    final depTimeStr = depTime != null ? formatTime(depTime) : "";
    final arrTimeStr = arrTime != null ? formatTime(arrTime) : "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Icon(
                Icons.radio_button_unchecked,
                color: AppColors.textMuted,
                size: 14,
              ),
              Container(
                width: 2,
                height: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.textMuted, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                  ),
                ),
              ),
              const Icon(
                Icons.radio_button_unchecked,
                color: AppColors.textMuted,
                size: 14,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      depTimeStr,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${segment.departureAirport.name} (${segment.departureAirport.id})",
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  "Travel time: ${segment.durationFormatted}",
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      arrTimeStr,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${segment.arrivalAirport.name} (${segment.arrivalAirport.id})",
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${segment.airline}  •  ${segment.travelClass}  •  ${segment.airplane}  •  ${segment.flightNumber}",
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: segment.extensions.map((ext) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    ext,
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                    textAlign: TextAlign.right,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
