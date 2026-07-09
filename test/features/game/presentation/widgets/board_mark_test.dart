import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_o.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_x.dart';

void main() {
  Future<void> pumpMark(WidgetTester tester, Widget mark) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: mark,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('BoardMarkX paints a themed custom mark', (tester) async {
    await pumpMark(tester, const BoardMarkX());

    final Finder markPaint = find.descendant(
      of: find.byType(BoardMarkX),
      matching: find.byType(CustomPaint),
    );

    expect(markPaint, findsOneWidget);

    final CustomPaint customPaint = tester.widget<CustomPaint>(markPaint);

    expect(customPaint.size.width, closeTo(54.4, 0.01));
    expect(customPaint.size.height, closeTo(54.4, 0.01));
    expect(customPaint.painter, isNotNull);
  });

  testWidgets('BoardMarkO paints a themed custom mark', (tester) async {
    await pumpMark(tester, const BoardMarkO());

    final Finder markPaint = find.descendant(
      of: find.byType(BoardMarkO),
      matching: find.byType(CustomPaint),
    );

    expect(markPaint, findsOneWidget);

    final CustomPaint customPaint = tester.widget<CustomPaint>(markPaint);

    expect(customPaint.size.width, closeTo(54.4, 0.01));
    expect(customPaint.size.height, closeTo(54.4, 0.01));
    expect(customPaint.painter, isNotNull);
  });
}
