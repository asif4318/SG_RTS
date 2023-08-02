import 'package:flutter/material.dart';
import 'package:rts_flutter/Screens/add_route_modal.dart';
import 'package:rts_flutter/Screens/map_page.dart';
import 'package:rts_flutter/Screens/my_routes.dart';
import 'package:rts_flutter/Screens/settings_page.dart';
import 'package:rts_flutter/Screens/trip_planner_page.dart';

import 'Screens/add_route_modal.dart';

void main() => runApp(const FlutterRTSApp());

class FlutterRTSApp extends StatelessWidget {
  const FlutterRTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    var brightThemeData = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true);

    var darkThemeData = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true);

    return MaterialApp(
      home: const App(),
      theme: brightThemeData,
      darkTheme: darkThemeData,
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyRoutesPage(),
    MapPage(),
    TripPlannerPage(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: Make Scaffold text dependent on tab
        title: const Text('NaviGator'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bus_alert),
            label: 'My Stops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Trip Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width,
                        child: const FetchRoutesScreen());
                  },
                );
              },
              label: const Text("Add Route"),
              icon: const Icon(Icons.add))
          : null,
    );
  }
}
