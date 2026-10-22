import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/core/widgets/snack_bar.dart';

void main() {
  testWidgets('error message disappears after 7 seconds', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showSnackBar(
                context: context,
                message: 'Something went wrong',
                type: SnackBarType.error,
              ),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('go'));
    await tester.pump();
    expect(find.text('Something went wrong'), findsOneWidget);

    await tester.pump(const Duration(seconds: 6));
    expect(find.text('Something went wrong'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Something went wrong'), findsNothing);
  });
}
