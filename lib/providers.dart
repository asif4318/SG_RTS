import 'package:rts_flutter/models/route.dart';
import 'package:rts_flutter/services/bus_service.dart';
import 'package:rts_flutter/services/repository/db_service.dart';
import 'package:rts_flutter/services/isar_db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Singleton for BusTime API Service
final busServiceProvider = Provider<BusService>((ref) {
  final BusService busService =
      BusService("https://riderts.app/bustime/api/v3/");
  return busService;
});

// Singleton for DbService
final dbProvider = Provider<DbService>((ref) {
  final DbService dbService = IsarDbService();
  return dbService;
});

final selectedRoutesProvider = FutureProvider<List<Route>>((ref) async {
  return await ref.read(dbProvider).getSelectedRoutes();
});