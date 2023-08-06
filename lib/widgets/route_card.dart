import 'package:flutter/material.dart';
import 'package:rts_flutter/models/route.dart' as route_model;

class RouteCard extends StatelessWidget {
  const RouteCard({Key? key, required this.route}) : super(key: key);
  final route_model.Route route;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: const Icon(Icons.circle),
          title: Text(route.routeName),
          subtitle: Text(route.routeNumber.toString())),
    );
  }
}
