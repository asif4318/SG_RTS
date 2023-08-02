import 'package:flutter/material.dart';

class TripPlannerPage extends StatelessWidget {
  const TripPlannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Start"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Destination"),
            ),
            ElevatedButton(onPressed: null, child: Text("GO"))
          ],
        ));
  }
}
