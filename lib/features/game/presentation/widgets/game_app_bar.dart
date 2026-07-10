import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/presentation/widgets/player_turn_row.dart';

/// Violet app bar displaying both players for the game screen.
class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  static const double _toolbarHeight = 56;

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacings = context.spacings;

    return AppBar(
      backgroundColor: colors.logoBorder,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: _toolbarHeight,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: spacings.m,
      title: const PlayerTurnRow(),
    );
  }
}
