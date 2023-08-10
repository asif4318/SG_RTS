import 'package:latlong2/latlong.dart';

enum CardinalDirection {
  north,
  east,
  south,
  west
}

class Vehicle {

  // "vid": "701", X
  // "tmstmp": "20230810 12:49", ?
  // "lat": "29.646045000000004",
  // "lon": "-82.32263999999999",
  // "hdg": "188",
  // "pid": 477,
  // "rt": "1",
  // "des": "Rosa Parks/Downtown",
  // "pdist": 29640,
  // "dly": true,
  // "spd": 0,
  // "tatripid": "14180",
  // "origtatripno": "795658",
  // "tablockid": "10013",
  // "zone": "",
  // "mode": 0,
  // "psgld": "EMPTY",
  // "stst": 43800,
  // "stsd": "2023-08-10"

  int id;
  LatLng coordinates;
  CardinalDirection heading;
  int patternId;
  int patternDistance;
  int routeId;
  String destination;
  bool delay = false;
  int speed;

  Vehicle(this.id, this.coordinates, this.heading, this.patternId,
      this.patternDistance, this.routeId, this.destination, this.delay, this.speed);

  Vehicle.fromJson(Map<String, dynamic> json):
    id = int.parse(json["vid"]),
    coordinates = LatLng(double.parse(json["lat"]), double.parse(json["lon"])),
    patternId = json["pid"],
    routeId = int.parse(json["rt"]),
    destination = json["des"],
    patternDistance = 100,
      //patternDistance = int.parse(json["pdist"]),
    delay = json.containsKey("dly"),
    speed = 0,
    // speed = int.parse(json["spd"]),
    // TODO: Add switch statement to set Cardinal direction;
    heading = CardinalDirection.north;
}