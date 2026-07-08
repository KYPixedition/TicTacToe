import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

/// Displays the current game status below the player turn row.
class GameStatusLabel extends StatelessWidget {
  const GameStatusLabel({
    super.key,
    required this.status,
    required this.winner,
    required this.currentPlayer,
    this.isCpuThinking = false,
  });

  final GameStatus status;
  final Player? winner;
  final Player currentPlayer;
  final bool isCpuThinking;

  static const double _iconSize = 28;
  static const int _maxTextLines = 2;

  @override
  Widget build(BuildContext context) {
    final presentation = _resolvePresentation(
      l10n: AppLocalizations.of(context),
      colors: context.colors,
    );
    final spacings = context.spacings;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxBannerWidth = constraints.maxWidth;
        final maxTextWidth =
            maxBannerWidth - spacings.m * 2 - _iconSize - spacings.m;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxBannerWidth),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.boardCellBackground,
                borderRadius: context.radii.borderM,
                border: Border.all(color: presentation.accentColor, width: 2),
                boxShadow: context.shadows.card,
              ),
              child: Padding(
                padding: spacings.paddingM,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      presentation.icon,
                      color: presentation.accentColor,
                      size: _iconSize,
                    ),
                    spacings.gapHorizontalM,
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxTextWidth.clamp(0, maxBannerWidth),
                      ),
                      child: Text(
                        presentation.label,
                        style: context.typos.gameStatus.copyWith(
                          color: presentation.accentColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: _maxTextLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _StatusPresentation _resolvePresentation({
    required AppLocalizations? l10n,
    required AppColorPalette colors,
  }) {
    if (isCpuThinking && status == GameStatus.playing) {
      return _StatusPresentation(
        label: l10n?.gameStatusCpuThinking ?? '',
        icon: Icons.smart_toy_rounded,
        accentColor: colors.playerO,
      );
    }

    return switch (status) {
      GameStatus.playing when currentPlayer == Player.x => _StatusPresentation(
        label: l10n?.gameStatusYourTurn ?? '',
        icon: Icons.person_rounded,
        accentColor: colors.gameStatusPlaying,
      ),
      GameStatus.playing => _StatusPresentation(
        label: l10n?.gameStatusPlaying ?? '',
        icon: Icons.sports_esports_rounded,
        accentColor: colors.gameStatusPlaying,
      ),
      GameStatus.draw => _StatusPresentation(
        label: l10n?.gameStatusDraw ?? '',
        icon: Icons.handshake_rounded,
        accentColor: colors.onSurface,
      ),
      GameStatus.won => switch (winner) {
        Player.x => _StatusPresentation(
          label: l10n?.gameStatusPlayerWon ?? '',
          icon: Icons.emoji_events_rounded,
          accentColor: colors.playerX,
        ),
        Player.o => _StatusPresentation(
          label: l10n?.gameStatusCpuWon ?? '',
          icon: Icons.smart_toy_rounded,
          accentColor: colors.playerO,
        ),
        null => _StatusPresentation(
          label: '',
          icon: Icons.help_outline_rounded,
          accentColor: colors.boardCellBorder,
        ),
      },
    };
  }
}

final class _StatusPresentation {
  const _StatusPresentation({
    required this.label,
    required this.icon,
    required this.accentColor,
  });

  final String label;
  final IconData icon;
  final Color accentColor;
}
