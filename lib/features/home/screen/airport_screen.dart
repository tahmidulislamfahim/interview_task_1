import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/airport_controller.dart';
import '../widgets/airport_tile.dart';
import '../widgets/search_box.dart';
import '../widgets/selected_panel.dart';

class AirportScreen extends StatelessWidget {
  AirportScreen({super.key});

  final AirportController controller = Get.put(AirportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Airports"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Column(
        children: [
          SearchBox(
            onChanged: controller.search,
          ),

          Obx(() => SelectedPanel(
                departure: controller.departure.value,
                arrival: controller.arrival.value,
                onSwap: controller.swapAirports,
              )),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: controller.filtered.length,
                itemBuilder: (context, index) {
                  final airport = controller.filtered[index];

                  return AirportTile(
                    airport: airport,
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.flight_takeoff),
                                title: Text("Set as Departure"),
                                onTap: () {
                                  controller.setDeparture(airport);
                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.flight_land),
                                title: Text("Set as Arrival"),
                                onTap: () {
                                  controller.setArrival(airport);
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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