import '../../models/route.dart';

abstract class DbService {
  Stream<List<Route>> getFavoriteRoutes();

  Future<List<Route>> getSelectedRoutes();

  void upsertRoutes(List<Route> routesList);

  Future<List<Route>> getRoutes();
}