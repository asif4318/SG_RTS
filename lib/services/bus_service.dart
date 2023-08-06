import 'dart:convert';
import '../models/route.dart';
import 'package:http/http.dart' as http;

class BusService {
  final String baseUrl;
  final String apiKey;
  var client = http.Client();

  BusService(this.baseUrl, this.apiKey);

  // Simple helper function to help build api urls
  Uri _urlBuilder(String baseUrl, String endpoint, String apiKey) {
    return Uri.parse("$baseUrl$endpoint?format=json&key=$apiKey");
  }

  Future<List<Route>> getRoutes() async {
    var response = await client.get(
      _urlBuilder(baseUrl, "getroutes", apiKey),
      headers: {
        "content-type":
            "application/json" // Specify content-type as JSON to prevent empty response body
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
      throw Error();
    }

    return routes;
  }
}
