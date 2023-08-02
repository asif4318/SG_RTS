import 'dart:convert';

import '../models/route.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class BusService {
  static const String endpoint = "getroutes";

  var client = http.Client();
  final dio = Dio();

  late Uri url;

  BusService(String baseURL, String apiKey) {
    url = Uri.parse("$baseURL$endpoint?format=json&key=$apiKey");
  }

  Future<List<Route>> getRoutes() async {
    var response = await http.get(
      url,
      headers: {
      "content-type": "application/json" // Specify content-type as JSON to prevent empty response body
      },
    );

    List<Route> routes = [];

    // On Success
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (var element in responseData["bustime-response"]["routes"]) {
        Route route = Route.fromJson(element);
        routes.add(route);
      }
    } else {
      print(response.body);
    }

    return routes;
  }
}