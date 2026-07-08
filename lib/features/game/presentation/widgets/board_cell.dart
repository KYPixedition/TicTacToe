import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

/// Read-only display of a single board cell.
class BoardCell extends StatelessWidget {
  const BoardCell({super.key, required this.player});

  final Player? player;

  @override
  Widget build(BuildContext context) {
    final mark = switch (player) {
      Player.x => 'X',
      Player.o => 'O',
      null => '',
    };
    final markColor = switch (player) {
      Player.x => context.colors.playerX,
      Player.o => context.colors.playerO,
      null => context.colors.onSurface,
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.boardCellBackground,
        borderRadius: context.radii.borderCell,
        border: Border.all(color: context.colors.boardCellBorder),
      ),
      child: Center(
        child: Text(
          mark,
          style: context.typos.cellMark.copyWith(color: markColor),
        ),
      ),
    );
  }
}
