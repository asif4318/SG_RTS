import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  getLocationPermissions() async {
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Notify user services are not enabled
      return Future.error('Location services are not enabled');
    }

    permission = await Geolocator.checkPermission();

    debugPrint(permission.toString());

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
        permission == LocationPermission.always) {
      return true;
    }
  }

  getCurrentLocation(void Function(LatLng position) callback) async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10));
      debugPrint(position.toString());
    } catch (e) {
      position = null;
      debugPrint(e.toString());
    }

    if (position != null) {
      LatLng location = LatLng(position.latitude, position.longitude);
      callback(location);
    }

    return true;
  }
}
