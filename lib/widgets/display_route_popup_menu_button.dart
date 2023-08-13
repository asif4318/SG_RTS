import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rts_flutter/providers.dart';

class DisplayRoutePopupMenuButton extends ConsumerWidget {

  const DisplayRoutePopupMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbService = ref.read(dbProvider);
    final busService = ref.read(busServiceProvider);

    return FutureBuilder(
      future: Future.wait([busService.getRoutes()]),
      builder: (context, snapshot) {
        final selectedRoutes = ref.watch(selectedRoutesProvider);
        if (snapshot.hasData && !selectedRoutes.isLoading) {
          final allRoutes = snapshot.data![0];
          return PopupMenuButton(
            itemBuilder: (context) {
              return allRoutes
                  .map((e) => CheckedPopupMenuItem(
                value: e.routeNumber,
                checked: selectedRoutes.value!.any((element) => element.routeNumber == e.routeNumber),
                child: Text("${e.routeDesignator}. ${e.routeName}"),
              ))
                  .toList();
            },
            onSelected: (routeNumber) async {
              final selectedRoute = selectedRoutes.value!.firstWhere((element) => element.routeNumber == routeNumber, orElse: () => allRoutes.firstWhere((element) => element.routeNumber == routeNumber));

              if (selectedRoute != null) {
                final isSelected = selectedRoute.isSelected;
                selectedRoute.isSelected = !isSelected;
                await dbService.upsertRoutes([selectedRoute]);
                ref.invalidate(selectedRoutesProvider);
              }
            },
            icon: const Icon(Icons.add_road),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

}
