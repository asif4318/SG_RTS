import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/route.dart' as models;
import 'package:http/http.dart' as http;
import 'package:rts_flutter/models/pattern.dart';

import '../models/vehicles.dart';

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

  Future<List<models.Route>> getRoutes() async {
    var response = await client.get(
      _urlBuilder(baseUrl, "getroutes", apiKey, null),
      headers: {
        "content-type":
            "application/json" // Specify content-type as JSON to prevent empty response body
      },
    );

    List<models.Route> routes = [];

    // On Success
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (var element in responseData["bustime-response"]["routes"]) {
        models.Route route = models.Route.fromJson(element);
        routes.add(route);
      }
    } else {
      throw Error();
    }

    return routes;
  }

  Future<List<Vehicle>>  getVehicles(void Function(List<Vehicle> vehicles) callback, int routeId) async {
    var response = await client.get(
      _urlBuilder(baseUrl, "getvehicles", apiKey, "&rt=$routeId"),
      headers: {
        "content-type":
        "application/json" // Specify content-type as JSON to prevent empty response body
      },
    );

    List<Vehicle> vehicles = [];

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (var element in responseData["bustime-response"]["vehicle"]) {
        Vehicle vehicle = Vehicle.fromJson(element);
        vehicles.add(vehicle);
      }
      callback(vehicles);
    } else {
      throw Error();
    }

    return vehicles;
    }

  Future<List<Pattern>> getPatterns(
      void Function(List<Pattern> patternParams) callback, int routeId, {Color? color}) async {
    var response = await client.get(
      _urlBuilder(baseUrl, "getpatterns", apiKey, "&rt=$routeId"),
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
        pattern.color = color ?? Colors.deepOrangeAccent;
        patterns.add(pattern);
      }
      callback(patterns);
    } else {
      throw Error();
    }

    return patterns;
  }
}
