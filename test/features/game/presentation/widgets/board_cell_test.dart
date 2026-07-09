import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_cell.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_x.dart';

void main() {
  Future<void> pumpBoardCell(
    WidgetTester tester, {
    required Player? player,
    bool isWinning = false,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: BoardCell(player: player, isWinning: isWinning),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders painted X mark', (tester) async {
    await pumpBoardCell(tester, player: Player.x);

    expect(find.byType(BoardMarkX), findsOneWidget);
    expect(
      find.descendant(of: find.byType(BoardMarkX), matching: find.byType(CustomPaint)),
      findsOneWidget,
    );
  });

  BoxDecoration recessedCellDecoration(WidgetTester tester) {
    return tester
        .widget<Container>(
          find.descendant(
            of: find.byType(BoardCell),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Container &&
                  widget.decoration is BoxDecoration &&
                  (widget.decoration! as BoxDecoration).color ==
                      AppColorPalette.light.boardCellRecessedBackground,
            ),
          ),
        )
        .decoration! as BoxDecoration;
  }

  testWidgets('normal cell uses solid darker recessed background', (tester) async {
    await pumpBoardCell(tester, player: Player.x);

    expect(
      recessedCellDecoration(tester).color,
      AppColorPalette.light.boardCellRecessedBackground,
    );
  });

  testWidgets('normal cell uses shader mask inner shadow', (tester) async {
    await pumpBoardCell(tester, player: Player.x);

    expect(recessedCellDecoration(tester).boxShadow, isNull);

    final Finder innerShadowMask = find.descendant(
      of: find.byType(BoardCell),
      matching: find.byWidgetPredicate(
        (widget) => widget is ShaderMask && widget.blendMode == BlendMode.dstIn,
      ),
    );

    expect(innerShadowMask, findsOneWidget);

    final ColoredBox shadowLayer = tester.widget<ColoredBox>(
      find.descendant(
        of: innerShadowMask,
        matching: find.byType(ColoredBox),
      ),
    );

    expect(
      shadowLayer.color,
      AppColorPalette.light.boardCellRecessedInsetShadow.withValues(alpha: 0.72),
    );
  });

  testWidgets('winning cell keeps the same layout size as a normal cell', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: Scaffold(
          body: Row(
            children: [
              const SizedBox(
                width: 80,
                height: 80,
                child: BoardCell(player: Player.x),
              ),
              const SizedBox(
                width: 80,
                height: 80,
                child: BoardCell(player: Player.x, isWinning: true),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final sizes = tester.getSize(find.byType(BoardCell).first);
    final winningSize = tester.getSize(find.byType(BoardCell).last);

    expect(winningSize, sizes);
  });

  testWidgets('winning cell uses winning border decoration', (tester) async {
    await pumpBoardCell(tester, player: Player.x, isWinning: true);

    final borderDecoration = tester
        .widget<Container>(
          find.descendant(
            of: find.byType(BoardCell),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Container &&
                  widget.decoration is BoxDecoration &&
                  (widget.decoration! as BoxDecoration).color ==
                      AppColorPalette.light.boardCellRecessedBackground,
            ),
          ),
        )
        .foregroundDecoration! as BoxDecoration;
    final border = borderDecoration.border as Border;

    expect(border.top.width, 5);
    expect(border.top.color, AppColorPalette.light.boardCellWinningGlow);
  });
}
