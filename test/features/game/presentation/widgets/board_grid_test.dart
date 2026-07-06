import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_cell.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_grid.dart';

void main() {
  testWidgets('renders nothing when board size is invalid', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: BoardGrid(
              board: <Player?>[],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BoardCell), findsNothing);
  });

  testWidgets('renders nine cells for a valid board', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: const Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: BoardGrid(
              board: <Player?>[
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BoardCell), findsNWidgets(9));
  });
}
