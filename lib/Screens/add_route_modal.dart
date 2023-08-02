import 'package:flutter/material.dart';
import 'package:rts_flutter/services/bus_service.dart';

class FetchRoutesScreen extends StatefulWidget {
  const FetchRoutesScreen({Key? key}) : super(key: key);

  @override
  State<FetchRoutesScreen> createState() => _FetchRoutesScreenState();
}

class _FetchRoutesScreenState extends State<FetchRoutesScreen> {
  _addRoute (BuildContext context) {
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    // Ensure the bus API key is set
    const cleverApiKey = String.fromEnvironment('CLEVER_API_KEY');
    if (cleverApiKey.isEmpty) {
      throw AssertionError('CLEVER_API_KEY is not set');
    }

    return FutureBuilder(
        future: BusService("https://riderts.app/bustime/api/v3/", cleverApiKey)
            .getRoutes(),
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
                          child: SearchBar(
                            hintText: "Search for a route",
                          )),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.length,
                            prototypeItem: const Card(
                                child: ListTile(
                                  leading: Icon(
                                      Icons.transit_enterexit_rounded),
                                  title: Text("STOP NAME\n"),
                                  subtitle: Text("ROUTE1, ROUTE2, ROUTE3"),
                                )),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => _addRoute(context),
                                  child: Card(
                                      child: ListTile(
                                        leading:
                                        const Icon(
                                            Icons.transit_enterexit_rounded),
                                        title: Text(data[index].routeName),
                                        subtitle:
                                        Text(
                                            data[index].routeNumber.toString()),
                                        trailing: const Icon(
                                            Icons.navigate_next),
                                      ))
                              );
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
