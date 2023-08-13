// Isar DB service
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rts_flutter/models/route.dart';

class DbService {
  late Future<Isar> db;

  DbService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    var dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([RouteSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Stream<List<Route>> getSavedRoutes() async* {
    final isar = await db;
    yield* isar.routes.where().watch(fireImmediately: true);
  }

  Future<List<Route>> getSelectedRoutes() async {
    final isar = await db;
    return isar.routes.where().findAll();
  }

  void saveRoutes(List<Route> routesList) async {
    final isar = await db;
    await isar.routes.putAll(routesList);
  }

  Future<List<Route>> getRoutes() async {
    final isar = await db;
    final routes = await isar.routes.where().findAll();
    return routes;
  }
}
