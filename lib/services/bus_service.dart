import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rts_flutter/models/prediction.dart';
import '../models/route.dart' as models;
import 'package:http/http.dart' as http;
import 'package:rts_flutter/models/pattern.dart';
import '../models/vehicles.dart';
import 'isar_db_service.dart';

class BusService {
  final String baseUrl;
  late String _apiKey;
  final _client = http.Client();
  final String _busTime = "bustime-response";

  IsarDbService dbService = IsarDbService();

  BusService(this.baseUrl) {
    const cleverApiKey = String.fromEnvironment('CLEVER_API_KEY');
    if (cleverApiKey.isEmpty) {
      throw AssertionError('CLEVER_API_KEY is not set');
    }
    _apiKey = cleverApiKey;
  }

  // Simple helper function to help build api urls
  Uri _urlBuilder(String baseUrl, String endpoint, String apiKey,
      String? params) {
    params = params ?? "";
    return Uri.parse("$baseUrl$endpoint?format=json&key=$apiKey$params");
  }

  Future<List<models.Route>> getRoutes() async {
    var response = await _client.get(
      _urlBuilder(baseUrl, "getroutes", _apiKey, null),
      headers: {
        "content-type": "application/json"
        // Specify content-type as JSON to prevent empty response body
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

  getPredictionFromVehicle(int busId) async {
    var response = await _client.get(_urlBuilder(baseUrl, "getpredictions", _apiKey, "&vid=$busId"));
    List<Prediction> predictions = [];

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body)[_busTime];
      if (!responseData.containsKey('!error')) {
        for (var element in responseData["prd"]) {
          predictions.add(Prediction.fromJson(element));
        }
      }
    }
    return predictions;
  }

  Stream<Pattern> getPatternsFromVehicles(List<Vehicle> vehicles) async* {
    List<Pattern> patterns = [];

    // We can combine up to 10 ids at a time into a single API call
    var patternIds = vehicles.map((e) => e.patternId).toList();

    // Create the chunks of ten
    List<List<int>> patternIdChunks = [];

    while (patternIds.length >= 10) {
      var sublist = patternIds.sublist(patternIds.length - 10);
      patternIds.removeRange(patternIds.length - 10, patternIds.length);
      patternIdChunks.add(sublist);
    }

    if (patternIds.isNotEmpty) {
      // Add the remaining patternIds if any
      patternIdChunks.add(patternIds);
    }

    var requestList = patternIdChunks.map((chunk) =>
        _client.get(_urlBuilder(
            baseUrl, "getpatterns", _apiKey, "&pid=${chunk.join(',')}"))).toList();

    for (var request in requestList) {
      var responseData = await request;
      if (responseData.statusCode == 200) {
        try {
          var busTimeResponse = jsonDecode(responseData.body)[_busTime];
          yield Pattern.fromJson(busTimeResponse);
        } catch (e) {
          // Do something
          debugPrint("Error while fetching patterns from vehicle IDs");
          debugPrintStack();
        }
      }

    }
  }

  Future<List<Vehicle>> getSelectedVehiclesList(
      void Function(List<Vehicle> vehicles) callback) async {
    var selectedRoutes = await dbService.getSelectedRoutes();
    List<http.Response> list = await Future.wait(selectedRoutes.map((route) =>
        _client.get(_urlBuilder(
            baseUrl, "getvehicles", _apiKey, "&rt=${route.routeNumber}"))));

    List<Vehicle> vehicles = [];

    for (int i = 0; i < list.length; i++) {
      var responseData = jsonDecode(list[i].body);
      var busTimeResponse = responseData[_busTime] as Map;
      if (!busTimeResponse.containsKey("error")) {
        for (var element in responseData[_busTime]["vehicle"]) {
          try {
            Vehicle vehicle = Vehicle.fromJson(element);
            vehicle.color = selectedRoutes[i].getColor();
            vehicles.add(vehicle);
          } catch (exception) {
            throw ErrorDescription("Error decoding Vehicles");
          }
        }
      }
    }

    callback(vehicles);
    return vehicles;
  }

  Future<List<Vehicle>> getVehicles(
      void Function(List<Vehicle> vehicles) callback, int routeId) async {
    var response = await _client.get(
      _urlBuilder(baseUrl, "getvehicles", _apiKey, "&rt=$routeId"),
      headers: {
        "content-type": "application/json"
        // Specify content-type as JSON to prevent empty response body
      },
    );

    List<Vehicle> vehicles = [];

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      try {
        for (var element in responseData["bustime-response"]["vehicle"]) {
          Vehicle vehicle = Vehicle.fromJson(element);
          vehicles.add(vehicle);
        }
        callback(vehicles);
      } catch (exception) {
        return [];
      }
    } else {
      throw Error();
    }

    return vehicles;
  }

  Future<List<Pattern>> getPatterns(
      void Function(List<Pattern> patternParams) callback, int routeId,
      {Color? color}) async {
    var response = await _client.get(
      _urlBuilder(baseUrl, "getpatterns", _apiKey, "&rt=$routeId"),
      headers: {
        "content-type": "application/json"
        // Specify content-type as JSON to prevent empty response body
      },
    );

    List<Pattern> patterns = [];

    // On Success
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (var element in responseData[_busTime]["ptr"]) {
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

  Future<List<Pattern>> getSelectedPatterns(
      void Function(List<Pattern> patternParams) callback) async {
    var selectedRoutes = await dbService.getSelectedRoutes();
    List<http.Response> list = await Future.wait(selectedRoutes.map((route) =>
        _client.get(_urlBuilder(
            baseUrl, "getpatterns", _apiKey, "&rt=${route.routeNumber}"))));

    List<Pattern> patterns = [];
    var maxIndex = selectedRoutes.length;

    for (int i = 0; i < maxIndex; i++) {
      var responseData = jsonDecode(list[i].body);
      if (responseData["bustime-response"].containsKey("ptr")) {
        for (var element in responseData["bustime-response"]["ptr"]) {
          try {
            Pattern pattern = Pattern.fromJson(element);
            pattern.color = selectedRoutes[i].getColor();
            patterns.add(pattern);
          } catch (exception) {
            throw ErrorDescription("Error decoding pattern");
          }
        }
      }
    }

    callback(patterns);
    return patterns;
  }
}
