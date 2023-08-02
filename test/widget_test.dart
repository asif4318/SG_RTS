// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rts_flutter/main.dart';
import 'package:rts_flutter/services/bus_service.dart';
import 'package:http/http.dart' as http;

void main() {
  const String apiKey = "scpKSw3cZWhNFutcJBtngS99c";

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterRTSApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('Test if bus service gets all routes', () async {
    BusService busService = BusService("https://riderts.app/bustime/api/v3/", apiKey);

    var routes = await busService.getRoutes();
    assert(routes.isNotEmpty);
  });

  test('test basic api fetch', () => () async {
    var request = await http.get(Uri.parse("https://riderts.app/bustime/api/v3/getroutes?format=json&key=scpKSw3cZWhNFutcJBtngS99c"));

    assert(request.body.isNotEmpty);
    assert(request.statusCode==200);
  });
}
