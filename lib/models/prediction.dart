DateTime parseDateTime(String dateTimeString) {
  final List<String> parts = dateTimeString.split(' ');
  final String datePart = parts[0];
  final String timePart = parts[1];

  final List<String> dateParts = datePart.split('');
  final List<String> timeParts = timePart.split(':');

  final int year = int.parse(dateParts[0] + dateParts[1] + dateParts[2] + dateParts[3]);
  final int month = int.parse(dateParts[4] + dateParts[5]);
  final int day = int.parse(dateParts[6] + dateParts[7]);

  final int hour = int.parse(timeParts[0]);
  final int minute = int.parse(timeParts[1]);

  return DateTime(year, month, day, hour, minute);
}

class Prediction {
  final String timestamp;
  final String type;
  final String stopName;
  final String stopId;
  final String vehicleId;
  final int dstp;
  final String route;
  final String routeDesignator;
  final String routeDirection;
  final String destination;
  final DateTime predictionTime;
  final String tablockid;
  final String tatripid;
  final String origtatripno;
  final bool delay;
  final int dyn;
  final String prdctdn;
  final String zone;
  final String nbus;
  final String passengerLoad;
  final int stst;
  final String stsd;
  final int flagstop;

  Prediction({
    required this.timestamp,
    required this.type,
    required this.stopName,
    required this.stopId,
    required this.vehicleId,
    required this.dstp,
    required this.route,
    required this.routeDesignator,
    required this.routeDirection,
    required this.destination,
    required this.predictionTime,
    required this.tablockid,
    required this.tatripid,
    required this.origtatripno,
    required this.delay,
    required this.dyn,
    required this.prdctdn,
    required this.zone,
    required this.nbus,
    required this.passengerLoad,
    required this.stst,
    required this.stsd,
    required this.flagstop,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      timestamp: json['tmstmp'],
      type: json['typ'],
      stopName: json['stpnm'],
      stopId: json['stpid'],
      vehicleId: json['vid'],
      dstp: json['dstp'],
      route: json['rt'],
      routeDesignator: json['rtdd'],
      routeDirection: json['rtdir'],
      destination: json['des'],
      predictionTime: parseDateTime(json['prdtm']),
      tablockid: json['tablockid'],
      tatripid: json['tatripid'],
      origtatripno: json['origtatripno'],
      delay: json['dly'],
      dyn: json['dyn'],
      prdctdn: json['prdctdn'],
      zone: json['zone'],
      nbus: json['nbus'],
      passengerLoad: json['psgld'],
      stst: json['stst'],
      stsd: json['stsd'],
      flagstop: json['flagstop'],
    );
  }
}
