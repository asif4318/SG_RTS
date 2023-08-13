import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class Pattern {
  int id;
  double length;
  String direction;
  late List<PatternPoint> points;
  String? detourId;
  List<PatternPoint>? detourPoints;
  Color? color;

  Pattern(this.id, this.length, this.direction, this.points);

  getPoints() {
    List<LatLng> coords = [];
    for (var element in points) {
      coords.add(element.coordinates);
    }
    return coords;
  }

  Pattern.fromJson(Map<String, dynamic> json)
      : id = json["pid"],
        length = json["ln"],
        direction = json["rtdir"] {
    points = (json['pt'] as List)
        .map((pointJson) => PatternPoint.fromJson(pointJson))
        .toList();
    detourId = json.containsKey("dtrid") ? json["dtrid"] : null;
    if (json.containsKey("dtrpt")) {
      detourPoints = (json['dtrpt'] as List)
          .map((pointJson) => PatternPoint.fromJson(pointJson))
          .toList();
    }
  }
}

enum PointType { waypoint, stop }

class PatternPoint {
  int index;
  LatLng coordinates;
  PointType type;
  double distanceFromPattern;
  int? stopId;
  String? stopName;

  PatternPoint(
      this.index, this.coordinates, this.type, this.distanceFromPattern);

  PatternPoint.fromJson(Map<String, dynamic> json)
      : index = json["seq"],
        coordinates = LatLng(json["lat"], json["lon"]),
        type = json["typ"] == "S" ? PointType.stop : PointType.waypoint,
        distanceFromPattern = json["pdist"] {
    json.containsKey("stpnm") ? stopName = json["stpnm"] : null;
    json.containsKey("stpid") ? stopId = int.tryParse(json["stpid"]) : null;
  }
}
