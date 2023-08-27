import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rts_flutter/models/prediction.dart';
import 'package:rts_flutter/providers.dart';

import '../models/vehicles.dart';

// TODO: Get stop info for vehicle
class VehicleInfoActionSheet extends ConsumerWidget {
  final Vehicle bus;

  const VehicleInfoActionSheet({super.key, required this.bus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var busService = ref.read(busServiceProvider);
    return FutureBuilder(
        future: busService.getPredictionFromVehicle(bus.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var predictions = snapshot.data as List<Prediction>;
            return Container(
                child: Column(children: <Widget>[
              Text('Vehicle Info: ${bus.id} - Route ${bus.routeId}'),
              Text('Destination: ${bus.destination}'),
              Expanded(
                  child: ListView(children: [
                ...predictions.take(4).map((e) => ListTile(
                      title: Text(e.stopName),
                      trailing: Text(TimeOfDay.fromDateTime(e.predictionTime)
                          .format(context)),
                    ))
              ]))
            ]));
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            debugPrintStack();
            return const Text("ERROR ");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
