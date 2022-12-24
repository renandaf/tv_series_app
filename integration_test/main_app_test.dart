// import 'package:core/core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:movies/movies.dart';
// import 'package:series/presentation/pages/home_series_page.dart';
// import 'package:series/presentation/pages/search_series_page.dart';
// import 'package:series/presentation/widgets/card_series.dart';
// import 'package:tv_series_app/main.dart' as app;

// void main() {
//   group(
//     'Integration Test',
//     () {
//       IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//       testWidgets('App flow', (tester) async {
//         app.main();
//         await tester.pumpAndSettle();

//         await tester.tap(find.byIcon(Icons.search));
//         await tester.pumpAndSettle();
//         expect(find.byType(SearchPage), findsOneWidget);
//         expect(find.byType(TextField), findsOneWidget);

//         await tester.enterText(find.byType(TextField), "wednesday");
//         await tester.testTextInput.receiveAction(TextInputAction.done);
//         await tester.pumpAndSettle();

//         expect(find.byIcon(Icons.arrow_back), findsOneWidget);
//         await tester.tap(find.byIcon(Icons.arrow_back));
//         await tester.pumpAndSettle();
//         expect(find.byType(HomePageSeries), findsOneWidget);
//         await tester.tap(find.byKey(const Key("drawer")));
//         await tester.pumpAndSettle();
//       });
//     },
//   );
// }
