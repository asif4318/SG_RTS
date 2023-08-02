import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future _getCurrentLocationFuture;
  LatLng? _currentPosition;
  final LatLng defaultPosition = const LatLng(29.646799, -82.348065);

  @override
  void initState() {
    _getCurrentLocationFuture = _getCurrentLocation();
    super.initState();
  }

  _getLocationPermissions() async {
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();

    print(permission.toString());

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // TODO: Handle Denied permission
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
  }

  _getCurrentLocation() async {
    Position? position;
    await _getLocationPermissions();
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10));
      print(position.toString());
    } catch (e) {
      position = null;
      debugPrint(e.toString());
    }

    if (position != null) {
      LatLng location = LatLng(position.latitude, position.longitude);
      _currentPosition = location;
    }

    return true;
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
                zoom: 16,
                maxZoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  maxNativeZoom: 24,
                  maxZoom: 16,
                ),
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
