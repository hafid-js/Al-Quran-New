import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alquran_new/development/tasbih/widgets/tasbih_bead_counter.dart';

void main() {
  testWidgets('swipe left triggers onCount once', (tester) async {
    var counted = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TasbihBeadCounter(
              count: 5,
              enabled: true,
              onCount: () => counted++,
            ),
          ),
        ),
      ),
    );

    expect(find.text('5'), findsOneWidget);

    final bead = find.byType(GestureDetector).first;
    final center = tester.getCenter(bead);
    await tester.dragFrom(center, const Offset(-120, 0));
    await tester.pumpAndSettle();

    expect(counted, 1);
  });

  testWidgets('disabled bead does not count', (tester) async {
    var counted = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TasbihBeadCounter(
              count: 33,
              enabled: false,
              onCount: () => counted++,
            ),
          ),
        ),
      ),
    );

    final bead = find.byType(GestureDetector).first;
    final center = tester.getCenter(bead);
    await tester.dragFrom(center, const Offset(-120, 0));
    await tester.pumpAndSettle();

    expect(counted, 0);
  });

  testWidgets('interrupted swipe does not stack onCount', (tester) async {
    var counted = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TasbihBeadCounter(
              count: 0,
              enabled: true,
              onCount: () => counted++,
            ),
          ),
        ),
      ),
    );

    final bead = find.byType(GestureDetector).first;
    final center = tester.getCenter(bead);

    await tester.dragFrom(center, const Offset(-120, 0));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.dragFrom(center, const Offset(-120, 0));
    await tester.pumpAndSettle();

    expect(counted, 1);
  });
}
