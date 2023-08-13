// Isar DB service
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rts_flutter/models/route.dart';
import 'package:rts_flutter/services/repository/db_service.dart';

class IsarDbService implements DbService  {
  late Future<Isar> db;

  IsarDbService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    var dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([RouteSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  /// DbService Interface Methods ////

  @override
  Stream<List<Route>> getFavoriteRoutes() async* {
    final isar = await db;
    yield* isar.routes.where().watch(fireImmediately: true);
  }

  @override
  Future<List<Route>> getSelectedRoutes() async {
    final isar = await db;
    return isar.routes.filter().isSelectedEqualTo(true).findAll();
  }

  @override
  void upsertRoutes(List<Route> routesList) async {
    final isar = await db;
    await isar.writeTxn(() async => await isar.routes.putAll(routesList));
  }

  @override
  Future<List<Route>> getRoutes() async {
    final isar = await db;
    final routes = await isar.routes.where().findAll();
    return routes;
  }
}
