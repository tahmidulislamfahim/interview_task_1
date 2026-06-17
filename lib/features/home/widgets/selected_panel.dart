import 'package:flutter/material.dart';
import '../model/airport_model.dart';

class SelectedPanel extends StatelessWidget {
  final Airport? departure;
  final Airport? arrival;
  final VoidCallback onSwap;

  const SelectedPanel({
    super.key,
    required this.departure,
    required this.arrival,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Departure"),
                  Text(
                    departure?.code ?? "-",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.swap_horiz, size: 30),
                onPressed: onSwap,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Arrival"),
                  Text(
                    arrival?.code ?? "-",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
