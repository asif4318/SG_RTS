import 'package:flutter/material.dart';

import '../models/vehicles.dart';

// TODO: Get stop info for vehicle
class VehicleInfoActionSheet extends StatelessWidget {
  final Vehicle bus;
  const VehicleInfoActionSheet({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Vehicle Info: ${bus.id}'),
            ElevatedButton(
              child: Text(bus.id.toString()),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )));
  }
}
