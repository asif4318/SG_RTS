class Stop {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  Stop(this.id, this.name, this.latitude, this.longitude);

  Stop.fromJson(Map<String, dynamic> json)
      : id = json['stpid'],
        name = json['stpnm'],
        latitude = json['lat'],
        longitude = json['lon'];
}