import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_cell.dart';

/// Read-only 3×3 Tic-Tac-Toe board.
class BoardGrid extends StatelessWidget {
  const BoardGrid({
    super.key,
    required this.board,
    required this.onCellTap,
    this.isInteractionEnabled = true,
    this.winningLineIndices,
  });

  final List<Player?> board;
  final ValueChanged<int> onCellTap;
  final bool isInteractionEnabled;
  final List<int>? winningLineIndices;

  static const int _gridDimension = 3;
  static const double _cellGap = 10;

  @override
  Widget build(BuildContext context) {
    if (board.length != Game.boardSize) {
      return const SizedBox.shrink();
    }

    final winningIndices = winningLineIndices;

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

        return SizedBox(
          width: side,
          height: side,
          child: GridView.count(
            crossAxisCount: _gridDimension,
            mainAxisSpacing: _cellGap,
            crossAxisSpacing: _cellGap,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (int index = 0; index < board.length; index++)
                GestureDetector(
                  onTap: isInteractionEnabled && board[index] == null
                      ? () => onCellTap(index)
                      : null,
                  child: BoardCell(
                    player: board[index],
                    isWinning: winningIndices?.contains(index) ?? false,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
