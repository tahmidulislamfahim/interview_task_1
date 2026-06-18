import 'package:flutter/material.dart';
import 'package:interview_task_1/core/common/colors/app_colors.dart';
import 'package:interview_task_1/core/common/widgets/date_formatter.dart';
import 'package:interview_task_1/features/flight_search/model/flight_search_model.dart';
import 'package:interview_task_1/features/flight_search/widgets/flight_segments.dart';

class FlightCard extends StatelessWidget {
  final FlightRoute route;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onSelect;

  const FlightCard({
    super.key,
    required this.route,
    required this.isExpanded,
    required this.onToggle,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final firstFlight = route.flights.first;
    final lastFlight = route.flights.last;

    final firstDepTime = firstFlight.departureAirport.parsedTime;
    final lastArrTime = lastFlight.arrivalAirport.parsedTime;

    final depDateStr = firstDepTime != null ? formatDate(firstDepTime) : "";
    final depTimeStr = firstDepTime != null ? formatTime(firstDepTime) : "";
    final arrTimeStr = lastArrTime != null ? formatTime(lastArrTime) : "";

    Color? emissionPillBg;
    Color? emissionPillText;
    String emissionPercentLabel = "";

    if (route.carbonEmissions != null) {
      final diff = route.carbonEmissions!.differencePercent;
      if (diff < 0) {
        emissionPillBg = AppColors.greenBg.withValues(alpha: 0.2);
        emissionPillText = AppColors.greenText;
        emissionPercentLabel = "$diff% emissions";
      } else if (diff > 0) {
        emissionPillBg = AppColors.border.withValues(alpha: 0.5);
        emissionPillText = AppColors.textMuted;
        emissionPercentLabel = "+$diff% emissions";
      } else {
        emissionPillBg = AppColors.border.withValues(alpha: 0.5);
        emissionPillText = AppColors.textMuted;
        emissionPercentLabel = "typical emissions";
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: route.airlineLogo.isNotEmpty
                            ? Image.network(
                                route.airlineLogo,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.flight,
                                      color: AppColors.textMuted,
                                      size: 20,
                                    ),
                              )
                            : const Icon(
                                Icons.flight,
                                color: AppColors.textMuted,
                                size: 20,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Departure • $depDateStr",
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "$depTimeStr – $arrTimeStr  •  ${route.durationFormatted}  •  ${route.stopsText}",
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "\$${route.price}",
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.textMuted,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (route.carbonEmissions != null)
                        Row(
                          children: [
                            Text(
                              route.carbonEmissions!.label,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: emissionPillBg,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                emissionPercentLabel,
                                style: TextStyle(
                                  color: emissionPillText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        const SizedBox.shrink(),
                      ElevatedButton(
                        onPressed: onSelect,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: AppColors.textDark,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "Select flight",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded) ...[
            const Divider(color: AppColors.border, height: 1, thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  for (int i = 0; i < route.flights.length; i++) ...[
                    FlightSegments(segment: route.flights[i]),
                    if (i < route.layovers.length)
                      _buildLayoverRow(route.layovers[i]),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLayoverRow(Layover layover) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          const Divider(color: AppColors.border, height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.access_time,
                  color: AppColors.textMuted,
                  size: 14,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${layover.durationFormatted} layover  -  ${layover.name} (${layover.id})",
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 1, thickness: 1),
        ],
      ),
    );
  }
}
