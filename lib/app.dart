import 'package:flutter/material.dart';
import 'package:rts_flutter/services/isar_db_service.dart';
import 'package:rts_flutter/screens/add_route_modal.dart';
import 'package:rts_flutter/screens/map_page.dart';
import 'package:rts_flutter/screens/my_routes.dart';
import 'package:rts_flutter/screens/settings_page.dart';
import 'package:rts_flutter/screens/trip_planner_page.dart';
import 'package:rts_flutter/widgets/display_route_popup_menu_button.dart';

class Destination {
  Widget widget;
  String appBarTitle;
  FloatingActionButton? floatingActionButton;
  TextButton? textButton;

  Destination(this.widget, this.appBarTitle);
  Destination.withFloatingButton(
      this.widget, this.appBarTitle, this.floatingActionButton);
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  final IsarDbService dbService = IsarDbService();
  late Stream<List<Route>> routes;

  _AppState();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> destinations = <Destination>[
      Destination.withFloatingButton(
          MyRoutesPage(
            dbService: dbService, // Inject dbService into routes page
          ),
          "NaviGator",
          FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  enableDrag: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width,
                        child: const FetchRoutesScreen()
                    );
                  },
                );
              },
              label: const Text("Add Route"),
              icon: const Icon(Icons.add))),
      Destination(const MapPage(), "Map"),
      Destination(const TripPlannerPage(), "NaviGator"),
      Destination(const SettingsPage(), "Settings")
    ];
    return Scaffold(
        appBar: AppBar(
          // TODO: Make Scaffold text dependent on tab
          title: Text(destinations.elementAt(_selectedIndex).appBarTitle),
          leading: _selectedIndex == 1
              ? const DisplayRoutePopupMenuButton()
              : null,
          actions: const [],
        ),
        body: Center(
          child: destinations.elementAt(_selectedIndex).widget,
        ),
        bottomNavigationBar: NavigationBar(
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.bus_alert),
              label: 'My Stops',
            ),
            NavigationDestination(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.navigation),
              label: 'Trip Planner',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
        floatingActionButton:
            destinations.elementAt(_selectedIndex).floatingActionButton);
  }
}
