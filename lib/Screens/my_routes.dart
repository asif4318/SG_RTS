import 'package:flutter/material.dart';
import 'package:rts_flutter/services/repository/db_service.dart';
import 'package:rts_flutter/widgets/route_card.dart';

class MyRoutesPage extends StatelessWidget {
  const MyRoutesPage({super.key, required this.dbService});
  final DbService dbService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dbService.getFavoriteRoutes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final routes = snapshot.data;
            if (routes!.isEmpty) {
              return const Center(child: Text("No saved routes!"));
            }
            return ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                return RouteCard(route: routes[index]);
              },
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
