import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:integration_testing/view/home_view.dart";
import 'package:integration_testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Integration Testing or End to End Testing", () {
    testWidgets("Verify Login Screen with correct Email and Password",
        (tester) async {
      // To ensure app main func called and this file main shouldnt call therefore we imported main as app;
      app.main();
      await tester.pump();
      await tester.enterText(find.byType(TextField).at(0), "Email");
      await tester.enterText(find.byType(TextField).at(1), "Password");
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets("Verify Login Screen with uncorrect Email or Password",
        (tester) async {
      // To ensure app main func called and this file main shouldnt call therefore we imported main as app;
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), "Emails");
      await tester.enterText(find.byType(TextField).at(1), "Password");
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
