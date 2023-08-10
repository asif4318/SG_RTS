import 'package:flutter/material.dart';
import 'package:rts_flutter/services/db_service.dart';

class DisplayRoutePopupMenuButton extends StatelessWidget {
  final DbService dbService;

  const DisplayRoutePopupMenuButton({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbService.getSavedRoutes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PopupMenuButton(
              itemBuilder: (context) {
                return snapshot.data
                        ?.map((e) => PopupMenuItem(
                            value: e.routeNumber, child: Text(e.routeName)))
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
