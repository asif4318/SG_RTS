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
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LocationService locationService = LocationService();
  late Future _getCurrentLocationFuture;
  late Future _getPatternsFuture;
  List<Pattern>? _patterns;
  LatLng? _currentPosition;
  // Default center if current location can't be found is Reitz Union
  final LatLng defaultPosition = const LatLng(29.646799, -82.348065);


  drawMarker(BuildContext context, LatLng point) {
    return Marker(
        builder: (context) => const Icon(Icons.place, color: Colors.deepOrange, size: 30),
        point: point,
        width: 80,
        height: 80
    );
  }

  @override
  void initState() {
    _getCurrentLocationFuture =
        locationService.getCurrentLocation((location) => _currentPosition = location);
    _getPatternsFuture =
        widget.busService.getPatterns((patterns) => _patterns = patterns, 33, color: Colors.purple);

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
                polylines:  _patterns?.map((pattern) =>
                    Polyline(strokeWidth: 6.0, color: pattern.color ?? Colors.black, points: pattern.getPoints())).toList() ?? []
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
