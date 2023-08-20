import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rts_flutter/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: FlutterRTSApp()));
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
      home: const App(),
      theme: brightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
