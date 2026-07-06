import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_cell.dart';

/// Read-only 3×3 Tic-Tac-Toe board.
class BoardGrid extends StatelessWidget {
  const BoardGrid({
    super.key,
    required this.board,
  });

  final List<Player?> board;

  static const int _gridDimension = 3;

  @override
  Widget build(BuildContext context) {
    if (board.length != Game.boardSize) {
      return const SizedBox.shrink();
    }

    final gap = context.spacings.s;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        if (maxWidth <= 0) {
          return const SizedBox.shrink();
        }

        final maxHeight = constraints.maxHeight;
        final heightLimit = maxHeight.isFinite ? maxHeight : maxWidth;
        final side = math.min(maxWidth, heightLimit);
        if (side <= 0) {
          return const SizedBox.shrink();
        }

        return Center(
          child: SizedBox(
            width: side,
            height: side,
            child: GridView.count(
              crossAxisCount: _gridDimension,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [for (final player in board) BoardCell(player: player)],
            ),
          ),
        );
      },
    );
  }
}
