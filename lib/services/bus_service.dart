import 'dart:convert';
import '../models/route.dart';
import 'package:http/http.dart' as http;
import 'package:rts_flutter/models/pattern.dart';

class BusService {
  final String baseUrl;
  late String apiKey;
  var client = http.Client();

  BusService(this.baseUrl) {
    const cleverApiKey = String.fromEnvironment('CLEVER_API_KEY');
    if (cleverApiKey.isEmpty) {
      throw AssertionError('CLEVER_API_KEY is not set');
    }
    apiKey = cleverApiKey;
  }

  // Simple helper function to help build api urls
  Uri _urlBuilder(
      String baseUrl, String endpoint, String apiKey, String? params) {
    params = params ?? "";
    return Uri.parse("$baseUrl$endpoint?format=json&key=$apiKey$params");
  }

  Future<List<Route>> getRoutes() async {
    var response = await client.get(
      _urlBuilder(baseUrl, "getroutes", apiKey, null),
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

  Future<List<Pattern>> getPatterns(
      void Function(List<Pattern> patternParams) callback) async {
    var response = await client.get(
      _urlBuilder(baseUrl, "getpatterns", apiKey, "&rt=20"),
      headers: {
        "content-type":
            "application/json" // Specify content-type as JSON to prevent empty response body
      },
    );

    List<Pattern> patterns = [];

    // On Success
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (var element in responseData["bustime-response"]["ptr"]) {
        Pattern pattern = Pattern.fromJson(element);
        patterns.add(pattern);
      }
      callback(patterns);
    } else {
      throw Error();
    }

    return patterns;
  }
}
