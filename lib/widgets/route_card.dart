import 'package:flutter/material.dart';
import 'package:rts_flutter/models/route.dart' as route_model;

class RouteCard extends StatelessWidget {
  const RouteCard({Key? key, required this.route}) : super(key: key);
  final route_model.Route route;

  @override
  Widget build(BuildContext context) {
    return const Card(
        child: ListTile(
      leading: Icon(Icons.circle),
      title: Text("Rosa Parks to Butler Plaza TS"),
      subtitle: Text("{STOP NUMBER} - {num1} .. and more"),
    ));
  }
}
