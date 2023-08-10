import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rts_flutter/models/route.dart' as route_model;
import 'package:isar/isar.dart';
import 'package:rts_flutter/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getApplicationDocumentsDirectory().then((value) async =>
      await Isar.open([route_model.RouteSchema], directory: value.path));
  runApp(const FlutterRTSApp());
}

class FlutterRTSApp extends StatelessWidget {
  const FlutterRTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    var brightThemeData = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true);

    var darkThemeData = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true);

    return MaterialApp(
      home: App(),
      theme: brightThemeData,
      darkTheme: darkThemeData,
    );
  }
}
