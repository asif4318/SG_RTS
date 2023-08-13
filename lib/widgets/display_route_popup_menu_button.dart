import 'package:flutter/material.dart';
import 'package:rts_flutter/services/bus_service.dart';
import 'package:rts_flutter/services/repository/db_service.dart';

class DisplayRoutePopupMenuButton extends StatefulWidget {
  final BusService busService;
  final DbService dbService;

  const DisplayRoutePopupMenuButton({Key? key, required this.busService, required this.dbService})
      : super(key: key);

  @override
  State<DisplayRoutePopupMenuButton> createState() =>
      _DisplayRoutePopupMenuButtonState();
}

class _DisplayRoutePopupMenuButtonState extends State<DisplayRoutePopupMenuButton> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([widget.busService.getRoutes(), widget.dbService.getSelectedRoutes()]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final allRoutes = snapshot.data![0];
          final selectedRoutes = snapshot.data![1];

          return PopupMenuButton(
            itemBuilder: (context) {
              return allRoutes
                  .map((e) => CheckedPopupMenuItem(
                value: e.routeNumber,
                checked: selectedRoutes.any((element) => element.routeNumber == e.routeNumber),
                child: Text("${e.routeDesignator}. ${e.routeName}"),
              ))
                  .toList();
            },
            onSelected: (routeNumber) async {
              final selectedRoute = selectedRoutes.firstWhere((element) => element.routeNumber == routeNumber, orElse: () => allRoutes.firstWhere((element) => element.routeNumber == routeNumber));

              if (selectedRoute != null) {
                final isSelected = selectedRoute.isSelected;
                selectedRoute.isSelected = !isSelected;
                await widget.dbService.upsertRoutes([selectedRoute]);
              }

              setState(() {});
            },
            icon: const Icon(Icons.add_road),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
