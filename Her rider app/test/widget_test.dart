import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:her_user_app/common_widgets/floating_back_button.dart';
import 'package:her_user_app/common_widgets/blurred_map_background.dart';
import 'package:her_user_app/common_widgets/trip_setup_scaffold.dart';

void main() {
  testWidgets('FloatingBackButton navigates back when tapped', (WidgetTester tester) async {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          body: Stack(
            children: [
              FloatingBackButton(),
              Builder(
                builder: (BuildContext context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Scaffold(
                            body: Text('Next Page'),
                          ),
                        ),
                      );
                    },
                    child: const Text('Go to next page'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    expect(find.text('Next Page'), findsOneWidget);

    await tester.tap(find.byType(FloatingBackButton));
    await tester.pumpAndSettle();

    expect(find.text('Next Page'), findsNothing);
  });

  testWidgets('TripSetupScaffold displays child widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TripSetupScaffold(
          child: Text('Test Child'),
        ),
      ),
    );

    expect(find.text('Test Child'), findsOneWidget);
    expect(find.byType(BlurredMapBackground), findsOneWidget);
    expect(find.byType(FloatingBackButton), findsOneWidget);
  });
}
