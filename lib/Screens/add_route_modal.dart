import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rts_flutter/services/bus_service.dart';
import '../models/route.dart' as route_model;

class FetchRoutesScreen extends StatefulWidget {
  final BusService busService;
  const FetchRoutesScreen({Key? key, required this.busService}) : super(key: key);

  @override
  State<FetchRoutesScreen> createState() => _FetchRoutesScreenState();
}

class _FetchRoutesScreenState extends State<FetchRoutesScreen> {
  Isar? isar;
  List<route_model.Route>? savedRoutes = [];

  _FetchRoutesScreenState();

  _addRoute(BuildContext context, route_model.Route newRoute) async {
    Navigator.of(context).pop();
    //isar
    await isar?.writeTxn(() async {
      await isar?.routes.put(newRoute);
    });
  }

  // _checkIfRouteExistsInDb(route_model.Route route) {
  //   bool doesExist = false;
  //   isar?.txnSync(() async {
  //     var result = await isar?.routes
  //         .where()
  //         .routeNumberEqualTo(route.routeNumber)
  //         .findFirst();
  //     doesExist = result != null;
  //   });
  //   return doesExist;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isar = Isar.getInstance();

    Future.delayed(Duration.zero, () async {
      savedRoutes = await isar?.routes.where().findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.busService.getRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                '${snapshot.error} occurred',
                style: const TextStyle(fontSize: 18),
              ));
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data!;
              return Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                  child: Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                          // TODO: Implement Search
                          child: SearchBar(
                            hintText: "Search for a route",
                          )),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              if (true) {
                                return GestureDetector(
                                    onTap: () async {
                                      data[index].isFavorite = true;
                                      _addRoute(context, data[index]);
                                    },
                                    child: Card(
                                        child: ListTile(
                                      leading: const Icon(
                                          Icons.transit_enterexit_rounded),
                                      title: Text(data[index].routeName),
                                      subtitle: Text(
                                          data[index].routeNumber.toString()),
                                      trailing: const Icon(Icons.navigate_next),
                                    )));
                              }
                            }),
                      )
                    ],
                  ));
            }
          }
          return const Center(
              child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ));
        });
  }
}
