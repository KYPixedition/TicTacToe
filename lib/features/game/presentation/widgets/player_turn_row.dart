import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

/// Displays the human and CPU players with an active-turn highlight.
class PlayerTurnRow extends StatelessWidget {
  const PlayerTurnRow({
    super.key,
    required this.currentPlayer,
    required this.status,
  });

  final Player currentPlayer;
  final GameStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spacings = context.spacings;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _PlayerTurnCell(
            label: l10n?.gamePlayerHuman ?? '',
            icon: Icons.person,
            player: Player.x,
            isActive: _isActive(Player.x),
          ),
        ),
        spacings.gapHorizontalL,
        Expanded(
          child: _PlayerTurnCell(
            label: l10n?.gamePlayerCpu ?? '',
            icon: Icons.smart_toy,
            player: Player.o,
            isActive: _isActive(Player.o),
          ),
        ),
      ],
    );
  }

  bool _isActive(Player player) {
    return status == GameStatus.playing && currentPlayer == player;
  }
}

class _PlayerTurnCell extends StatelessWidget {
  const _PlayerTurnCell({
    required this.label,
    required this.icon,
    required this.player,
    required this.isActive,
  });

  final String label;
  final IconData icon;
  final Player player;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacings = context.spacings;
    final iconColor = switch (player) {
      Player.x => colors.playerX,
      Player.o => colors.playerO,
    };

    final mark = switch (player) {
      Player.x => 'X',
      Player.o => 'O',
    };

    final markStyle = context.typos.cellMark.copyWith(color: iconColor);
    final markWidth = markStyle.fontSize;

    final activeBorderColor = isActive
        ? _activeBorderColor(colors)
        : colors.boardCellBorder;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.boardCellBackground,
        borderRadius: context.radii.borderM,
        border: Border.all(color: activeBorderColor, width: isActive ? 2 : 1),
      ),
      child: Padding(
        padding: spacings.paddingS,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            spacings.gapHorizontalS,
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: context.typos.body.copyWith(color: colors.onSurface),
              ),
            ),
            spacings.gapHorizontalS,
            SizedBox(
              width: markWidth,
              child: Text(mark, textAlign: TextAlign.center, style: markStyle),
            ),
          ],
        ),
      ),
    );
  }

  Color _activeBorderColor(AppColorPalette colors) {
    return switch (player) {
      Player.x => colors.gameStatusPlaying,
      Player.o => colors.playerO,
    };
  }
}
