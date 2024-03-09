import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:eesup/main.dart' as main_app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Sign in', () {
    setUpAll(() {
      main_app.main([]);
    });

    testWidgets('sign in with email.', (tester) async {
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('sign_in_screen')), findsOneWidget);
      await tester.pumpAndSettle();

      final emailField = find.byKey(const Key('email_text_field'));
      final passwordField = find.byKey(const Key('password_text_field'));
      final signInButton = find.byKey(const Key('sign_in_button'));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(signInButton, findsOneWidget);

      await tester.enterText(emailField, 'misomenze6@gmail.com');
      await tester.pumpAndSettle();

      await tester.enterText(passwordField, 'Miso@9582');

      await tester.pumpAndSettle(const Duration(seconds: 10));

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);

      await tester.pumpAndSettle(const Duration(seconds: 10));

      await tester.tap(signInButton);

      await tester.pumpAndSettle(const Duration(seconds: 10));

      expect(find.byKey(const Key('shop_overview_screen')), findsOneWidget);

      await tester.pumpAndSettle();
    });
  });
}
