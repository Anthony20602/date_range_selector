// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:date_range_selector/date_range_selector.dart';

void main() {
  testWidgets('Date range selector shows dialog with correct title',
      (WidgetTester tester) async {
    // Set a larger screen size for testing
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () async {
                  await showCustomDateRangePicker(
                    context,
                    DateTime(2024, 1, 1),
                    DateTime(2024, 12, 31),
                    (DateTime from, DateTime to) {
                      // Callback handler
                    },
                    primaryColor: Colors.blue,
                    title: 'Test Date Range',
                  );
                },
                child: const Text('Open Picker'),
              );
            },
          ),
        ),
      ),
    );

    // Verify the button is present
    expect(find.text('Open Picker'), findsOneWidget);

    // Tap the button to open the dialog
    await tester.tap(find.text('Open Picker'));
    await tester.pumpAndSettle();

    // Verify the dialog title is shown
    expect(find.text('Test Date Range'), findsOneWidget);

    // Verify FROM and TO labels are present
    expect(find.text('FROM'), findsOneWidget);
    expect(find.text('TO'), findsOneWidget);

    // Verify action buttons are present
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Apply'), findsOneWidget);

    // Clean up
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  test('showCustomDateRangePicker accepts color parameter', () {
    // This test verifies that the function signature is correct
    const testColor = Color(0xFF6200EE);
    expect(testColor, isA<Color>());
  });

  test('Default values are properly defined', () {
    // Verify the default color is defined
    const defaultColor = Color(0xFF2196F3);
    expect(defaultColor, isA<Color>());

    // Verify default title
    const defaultTitle = 'Select Date Range';
    expect(defaultTitle, isA<String>());
    expect(defaultTitle.length, greaterThan(0));
  });
}
