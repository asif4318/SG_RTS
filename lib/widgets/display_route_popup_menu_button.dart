import 'package:flutter/material.dart';
import 'package:rts_flutter/services/bus_service.dart';
import 'package:rts_flutter/services/db_service.dart';

class DisplayRoutePopupMenuButton extends StatelessWidget {
  final BusService busService;

  const DisplayRoutePopupMenuButton({super.key, required this.busService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: busService.getRoutes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PopupMenuButton(
              itemBuilder: (context) {
                return snapshot.data
                        ?.map((e) =>  PopupMenuItem(
                            value: e.routeNumber, child: Text(e.routeDesignator + ". " + e.routeName)))
                        .toList() ??
                    [];
              },
              icon: const Icon(Icons.add_road));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
