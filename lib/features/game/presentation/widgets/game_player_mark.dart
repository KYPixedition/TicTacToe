import 'package:flutter/material.dart';

import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_o.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_x.dart';

/// Painted X or O mark sized for game UI chrome.
class GamePlayerMark extends StatelessWidget {
  const GamePlayerMark({
    super.key,
    required this.player,
    required this.size,
  });

  final Player player;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: switch (player) {
        Player.x => const BoardMarkX(),
        Player.o => const BoardMarkO(),
      },
    );
  }
}
