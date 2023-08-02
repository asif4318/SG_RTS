class Route {
  final int routeNumber;
  final String routeName;
  final String routeColorHexCode;
  final String routeDesignator;

  Route.fromJson(Map<String, dynamic> json)
      : routeNumber = int.parse(json['rt']),
        routeName = json['rtnm'],
        routeColorHexCode = json['rtclr'],
        routeDesignator = json['rtdd'];

  Route(this.routeNumber, this.routeName, this.routeColorHexCode, this.routeDesignator);
}