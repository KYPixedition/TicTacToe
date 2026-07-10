import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/shadowed_container.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_player_mark.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

const double _statusMarkSize = 28;
const double _playerBackgroundAlpha = 0.18;

/// Displays the current game status below the game app bar.
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

  /// Blends [playerColor] onto [baseColor] for status banner backgrounds.
  static Color tintedPlayerBackground({
    required Color playerColor,
    required Color baseColor,
  }) {
    return Color.alphaBlend(
      playerColor.withValues(alpha: _playerBackgroundAlpha),
      baseColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _StatusContent? content = _resolveContent(
      l10n: AppLocalizations.of(context),
      colors: context.colors,
    );
    if (content == null) {
      return const SizedBox.shrink();
    }

    return Center(child: _GameStatusBanner(content: content));
  }

  _StatusContent? _resolveContent({
    required AppLocalizations l10n,
    required AppColorPalette colors,
  }) {
    if (isCpuThinking && status == GameStatus.playing) {
      return _forPlayer(
        label: l10n.gameStatusCpuThinking,
        player: Player.o,
        colors: colors,
      );
    }

    return switch (status) {
      GameStatus.playing when currentPlayer == Player.x => _forPlayer(
        label: l10n.gameStatusYourTurn,
        player: Player.x,
        colors: colors,
        accentColor: colors.gameStatusPlaying,
      ),
      GameStatus.playing => _forPlayer(
        label: l10n.gameStatusPlaying,
        player: Player.o,
        colors: colors,
        accentColor: colors.gameStatusPlaying,
      ),
      GameStatus.draw => _StatusContent(
        label: l10n.gameStatusDraw,
        markDisplay: const _BothPlayersMark(),
        accentColor: colors.onSurface,
        backgroundColor: colors.surface,
      ),
      GameStatus.won => switch (winner) {
        Player.x => _forPlayer(
          label: l10n.gameStatusPlayerWon,
          player: Player.x,
          colors: colors,
        ),
        Player.o => _forPlayer(
          label: l10n.gameStatusCpuWon,
          player: Player.o,
          colors: colors,
        ),
        null => null,
      },
    };
  }

  _StatusContent _forPlayer({
    required String label,
    required Player player,
    required AppColorPalette colors,
    Color? accentColor,
  }) {
    final Color playerColor = switch (player) {
      Player.x => colors.playerX,
      Player.o => colors.playerO,
    };

    return _StatusContent(
      label: label,
      markDisplay: _SinglePlayerMark(player),
      accentColor: accentColor ?? playerColor,
      backgroundColor: tintedPlayerBackground(
        playerColor: playerColor,
        baseColor: colors.boardCellBackground,
      ),
    );
  }
}

class _GameStatusBanner extends StatelessWidget {
  const _GameStatusBanner({required this.content});

  final _StatusContent content;

  static const int _maxTextLines = 2;
  static const double _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final spacings = context.spacings;
    final radii = context.radii;
    final typos = context.typos;

    return Semantics(
      label: content.label,
      child: ShadowedContainer(
        borderRadius: radii.borderM,
        boxShadow: context.shadows.card,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: content.backgroundColor,
            borderRadius: radii.borderM,
            border: Border.all(color: content.accentColor, width: _borderWidth),
          ),
          child: Padding(
            padding: spacings.paddingS,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _GameStatusMarks(display: content.markDisplay),
                spacings.gapHorizontalS,
                Flexible(
                  child: Text(
                    content.label,
                    style: typos.body.copyWith(
                      color: content.accentColor,
                      fontWeight: FontWeight.w600,
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
  }
}

class _GameStatusMarks extends StatelessWidget {
  const _GameStatusMarks({required this.display});

  final _StatusMarkDisplay display;

  @override
  Widget build(BuildContext context) {
    return switch (display) {
      _SinglePlayerMark(:final player) => GamePlayerMark(
        player: player,
        size: _statusMarkSize,
      ),
      _BothPlayersMark() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GamePlayerMark(player: Player.x, size: _statusMarkSize),
          context.spacings.gapHorizontalS,
          const GamePlayerMark(player: Player.o, size: _statusMarkSize),
        ],
      ),
    };
  }
}

sealed class _StatusMarkDisplay {
  const _StatusMarkDisplay();
}

final class _SinglePlayerMark extends _StatusMarkDisplay {
  const _SinglePlayerMark(this.player);

  final Player player;
}

final class _BothPlayersMark extends _StatusMarkDisplay {
  const _BothPlayersMark();
}

final class _StatusContent {
  const _StatusContent({
    required this.label,
    required this.markDisplay,
    required this.accentColor,
    required this.backgroundColor,
  });

  final String label;
  final _StatusMarkDisplay markDisplay;
  final Color accentColor;
  final Color backgroundColor;
}
