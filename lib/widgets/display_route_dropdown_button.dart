import 'package:flutter/material.dart';

class DisplayRouteDropdownButton extends StatefulWidget {
  //late List<Route> routes;
  const DisplayRouteDropdownButton({super.key});

  @override
  State<DisplayRouteDropdownButton> createState() =>
      _DisplayRouteDropdownButtonState();
}

class _DisplayRouteDropdownButtonState
    extends State<DisplayRouteDropdownButton> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: const Icon(Icons.add_road),
      items: const [],
      onChanged: (item) {},
    );
  }
}
