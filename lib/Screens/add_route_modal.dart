import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/route.dart' as route_model;
import 'package:rts_flutter/providers.dart';

class FetchRoutesScreen extends ConsumerStatefulWidget {
  const FetchRoutesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FetchRoutesScreen> createState() => _FetchRoutesScreenState();
}

class _FetchRoutesScreenState extends ConsumerState<FetchRoutesScreen> {
  List<route_model.Route>? savedRoutes = [];

  _FetchRoutesScreenState();

  _addRoute(BuildContext context, route_model.Route newRoute) async {
    Navigator.of(context).pop();
    ref.read(dbProvider).upsertRoutes([newRoute]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

/*    Future.delayed(Duration.zero, () async {
      savedRoutes = ref.read(isarProvider).getFavoriteRoutes()
    });*/
  }

  @override
  Widget build(BuildContext context) {
    ref.read(dbProvider);
    final busService = ref.read(busServiceProvider);
    return FutureBuilder(
        future: busService.getRoutes(),
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
