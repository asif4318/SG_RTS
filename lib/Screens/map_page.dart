import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:rts_flutter/services/location_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LocationService locationService = LocationService();

  late Future _getCurrentLocationFuture;
  LatLng? _currentPosition;
  // Default center if current location can't be found is Reitz Union
  final LatLng defaultPosition = const LatLng(29.646799, -82.348065);

  drawMarker(BuildContext context, LatLng point) {
    return Marker(builder: (context) => const Icon(Icons.place), point: point, width: 80, height: 80);
  }

  @override
  void initState() {
    _getCurrentLocationFuture =
        locationService.getCurrentLocation((value) => _currentPosition = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getCurrentLocationFuture,
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
                MarkerLayer(markers: [
                  drawMarker(context, _currentPosition ?? defaultPosition)
                ],)
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
