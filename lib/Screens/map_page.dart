import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import "package:rts_flutter/models/pattern.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:rts_flutter/services/bus_service.dart';
import 'package:rts_flutter/services/location_service.dart';

class MapPage extends StatefulWidget {
  final BusService busService;
  const MapPage({Key? key, required this.busService}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState(busService);
}

class _MapPageState extends State<MapPage> {
  LocationService locationService = LocationService();
  BusService busService;
  late Future _getCurrentLocationFuture;
  late Future _getPatternsFuture;
  List<Pattern>? _patterns;
  LatLng? _currentPosition;
  // Default center if current location can't be found is Reitz Union
  final LatLng defaultPosition = const LatLng(29.646799, -82.348065);

  _MapPageState(this.busService);

  drawMarker(BuildContext context, LatLng point) {
    return Marker(
        builder: (context) => const Icon(Icons.place),
        point: point,
        width: 80,
        height: 80);
  }

  @override
  void initState() {
    _getCurrentLocationFuture =
        locationService.getCurrentLocation((value) => _currentPosition = value);
    _getPatternsFuture =
        busService.getPatterns((patterns) => _patterns = patterns);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_getCurrentLocationFuture, _getPatternsFuture]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FlutterMap(
            options: MapOptions(
              center: _currentPosition ?? defaultPosition,
              zoom: 14,
              maxZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
                maxNativeZoom: 24,
                maxZoom: 20,
              ),
              PolylineLayer(
                polylines: [
                  Polyline(color: Colors.blue,strokeWidth: 6.0, points: _patterns?[0].getPoints()),
                  Polyline(color: Colors.blue,strokeWidth: 6.0, points: _patterns?[1].getPoints()),
                  Polyline(color: Colors.blue,strokeWidth: 6.0, points: _patterns?[2].getPoints())

                ],
              ),
              MarkerLayer(
                markers: [
                  drawMarker(context, _currentPosition ?? defaultPosition)
                ],
              )
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
