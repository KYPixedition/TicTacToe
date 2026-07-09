import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_player_mark.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

/// Displays human and CPU players with their marks for the game app bar.
class PlayerTurnRow extends StatelessWidget {
  const PlayerTurnRow({super.key});

  static const double playerIconSize = 32;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final labelStyle = context.typos.gameStatus.copyWith(
      color: colors.onPrimary,
    );
    final spacings = context.spacings;

    return Row(
      children: [
        spacings.gapHorizontalM,
        _PlayerTurnSide(
          player: Player.x,
          label: l10n?.gamePlayerHuman ?? '',
          labelStyle: labelStyle,
          markFirst: true,
        ),
        const Spacer(),
        _PlayerTurnSide(
          player: Player.o,
          label: l10n?.gamePlayerCpu ?? '',
          labelStyle: labelStyle,
          markFirst: false,
        ),
        spacings.gapHorizontalM,
      ],
    );
  }
}

class _PlayerTurnSide extends StatelessWidget {
  const _PlayerTurnSide({
    required this.player,
    required this.label,
    required this.labelStyle,
    required this.markFirst,
  });

  final Player player;
  final String label;
  final TextStyle labelStyle;
  final bool markFirst;

  @override
  Widget build(BuildContext context) {
    final spacings = context.spacings;
    final mark = GamePlayerMark(
      player: player,
      size: PlayerTurnRow.playerIconSize,
    );
    final labelWidget = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: labelStyle,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: markFirst
          ? [mark, spacings.gapHorizontalM, labelWidget]
          : [labelWidget, spacings.gapHorizontalM, mark],
    );
  }
}
