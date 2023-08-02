import 'package:flutter/material.dart';

class MyRoutesPage extends StatefulWidget {
  const MyRoutesPage({super.key});

  @override
  State<MyRoutesPage> createState() => _MyRoutesPageState();
}

class _MyRoutesPageState extends State<MyRoutesPage> {
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const <Widget>[
        Card(
          child: ListTile(
            leading: const Icon(Icons.circle),
            title: const Text("Rosa Parks to Butler Plaza TS"),
            subtitle: const Text("Stops: 1, 5, 12"),
          ),
        ),
      ],
    );
  }
}
