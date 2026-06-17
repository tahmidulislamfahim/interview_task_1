import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_1/features/home/screen/airport_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flight Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AirportScreen(),
    );
  }
}
