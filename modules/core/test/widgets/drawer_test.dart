import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('drawer test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("title"),
      ),
      body: const Center(
        child: Text("message"),
      ),
    )));

    await tester.pump();
    ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("popular_movie")), findsOneWidget);
    expect(find.byKey(const Key("nowplaying_movie")), findsOneWidget);
    expect(find.byKey(const Key("toprated_movie")), findsOneWidget);
    expect(find.byKey(const Key("popular_series")), findsOneWidget);
    expect(find.byKey(const Key("onair_series")), findsOneWidget);
    expect(find.byKey(const Key("toprated_series")), findsOneWidget);
    expect(find.byKey(const Key("watchlist")), findsOneWidget);
  });
}
