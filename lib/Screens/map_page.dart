import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import "package:rts_flutter/models/pattern.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:rts_flutter/providers.dart';
import 'package:rts_flutter/services/location_service.dart';
import '../models/vehicles.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  late Timer _timer;
  LocationService locationService = LocationService();
  final LatLngBounds mapBounds = LatLngBounds(
      const LatLng(29.793223, -82.661976), const LatLng(29.402954, -82.202424));
  late Future _getCurrentLocationFuture;
  late Future _getPatternsFuture;
  late Future _getVehiclesFuture;
  List<Pattern>? _patterns;
  List<Vehicle>? _vehicles;
  LatLng? _currentPosition;

  // Default center if current location can't be found is Reitz Union
  final LatLng defaultPosition = const LatLng(29.646799, -82.348065);

  drawAllBusMarkers(BuildContext context) {
    List<Marker> markers = [];
    if (_vehicles != null) {
      for (var bus in _vehicles!) {
        markers.add(drawBusMarker(context, bus.coordinates, bus.color));
      }
    }
    return markers;
  }

  drawBusMarker(BuildContext context, LatLng point, Color? color) {
    return Marker(
        builder: (context) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.directions_bus_rounded,
                  color: color ?? Colors.white, size: 30),
            ),
        point: point,
        width: 40,
        height: 40);
  }

  drawMarker(BuildContext context, LatLng point) {
    return Marker(
        builder: (context) =>
            const Icon(Icons.place, color: Colors.deepOrange, size: 30),
        point: point,
        width: 80,
        height: 80);
  }

  appendPatterns(List<Pattern> newValues) {
    List<Pattern> temp = _patterns ?? [];
    _patterns = [...temp, ...newValues];
  }

  @override
  void initState() {
    final busService = ref.read(busServiceProvider);

    _getCurrentLocationFuture = locationService
        .getCurrentLocation((location) => _currentPosition = location);
    _getPatternsFuture =
        busService.getSelectedPatterns((patterns) => _patterns = patterns);
    _getVehiclesFuture =
        busService.getSelectedVehiclesList((vehicles) => _vehicles = vehicles);

    _timer = Timer.periodic(
        const Duration(seconds: 10),
        (Timer t) => setState(() {
              debugPrint("getting vehicle location update");
              _getVehiclesFuture = busService.getVehicles(
                  (vehicles) => _vehicles = vehicles, 20);
            }));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final busService = ref.read(busServiceProvider);
    ref.listen(selectedRoutesProvider, (previousValue, nextValue) {
      _getPatternsFuture =
          ref.read(busServiceProvider).getSelectedPatterns((patternParams) {
        _patterns = patternParams;
        setState(() {});
      });
      _getVehiclesFuture = busService.getSelectedVehiclesList((vehicles) {_vehicles = vehicles;});
    });
    return FutureBuilder(
      future: Future.wait(
          [_getCurrentLocationFuture, _getPatternsFuture, _getVehiclesFuture]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FlutterMap(
              options: MapOptions(
                  center: _currentPosition ?? defaultPosition,
                  zoom: 14,
                  maxZoom: 18,
                  //bounds: mapBounds,
                  maxBounds: mapBounds),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  maxNativeZoom: 24,
                  maxZoom: 20,
                ),
                PolylineLayer(
                    polylines: _patterns
                            ?.map((pattern) => Polyline(
                                strokeWidth: 6.0,
                                color: pattern.color ?? Colors.black,
                                points: pattern.getPoints()))
                            .toList() ??
                        []),
                MarkerLayer(
                  markers: [
                    ...drawAllBusMarkers(context),
                    drawMarker(context, _currentPosition ?? defaultPosition)
                  ],
                )
              ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
