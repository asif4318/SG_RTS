import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'route.g.dart';

@collection
class Route {
  final Id routeNumber;
  final String routeName;
  final String routeColorHexCode;
  final String routeDesignator;
  var isFavorite = false;
  bool isSelected = false;

  Route.fromJson(Map<String, dynamic> json)
      : routeNumber = int.parse(json['rt']),
        routeName = json['rtnm'],
        routeColorHexCode = json['rtclr'],
        routeDesignator = json['rtdd'];

  @override
  bool operator == (Object other) {
    // TODO: implement ==
    return other is Route &&
        other.routeNumber == routeNumber &&
        other.routeDesignator == routeDesignator &&
        other.routeName == routeName &&
        other.routeColorHexCode == routeColorHexCode;
  }

  Route(this.routeNumber, this.routeName, this.routeColorHexCode,
      this.routeDesignator);

  /* Converts the rgb hex code color to a Flutter Color */
  getColor() {
    var colorString = routeColorHexCode.replaceFirst("#", "0xFF");
    var colorInt = 0;
    try {
      colorInt = int.parse(colorString);
    } catch (e) {
      throw ErrorDescription("Unable to convert color");
    }
    return Color(colorInt);
  }
}
