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
        home: Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: BoardGrid(board: <Player?>[], onCellTap: (_) {}),
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
        home: Scaffold(
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
              onCellTap: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BoardCell), findsNWidgets(9));
  });

  testWidgets('propagates tapped cell index', (tester) async {
    int? tappedIndex;

    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: BoardGrid(
              board: const <Player?>[
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
              onCellTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(4));
    await tester.pumpAndSettle();

    expect(tappedIndex, 4);
  });
}
