import 'package:flutter/material.dart';
import 'package:interview_task_1/features/home/model/airport_model.dart';

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
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(airport.code ?? 'N/A'),
        ),
        title: Text(
          airport.name ?? 'N/A',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${airport.city}, ${airport.country}"),
        trailing: Icon(Icons.flight_takeoff),
        onTap: onTap,
      ),
    );
  }
}