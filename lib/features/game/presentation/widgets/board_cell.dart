import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_shadows.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_o.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_x.dart';

/// Read-only display of a single board cell.
class BoardCell extends StatelessWidget {
  const BoardCell({super.key, required this.player, this.isWinning = false});

  final Player? player;
  final bool isWinning;

  static const double _winningBorderWidth = 5;
  static const double _insetShadowAlpha = 0.72;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radii = context.radii;
    final insetShadowColor = colors.boardCellRecessedInsetShadow.withValues(
      alpha: _insetShadowAlpha,
    );

    final cell = Container(
      decoration: BoxDecoration(
        color: colors.boardCellRecessedBackground,
        borderRadius: radii.borderCell,
      ),
      foregroundDecoration: isWinning
          ? BoxDecoration(
              borderRadius: radii.borderCell,
              border: Border.all(
                color: colors.boardCellWinningGlow,
                width: _winningBorderWidth,
              ),
            )
          : null,
      child: ClipRRect(
        borderRadius: radii.borderCell,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _BoardCellInsetShadow(
              shadowColor: insetShadowColor,
              maskColor: colors.onPrimary,
            ),
            Center(
              child: switch (player) {
                Player.x => const BoardMarkX(),
                Player.o => const BoardMarkO(),
                null => const SizedBox.shrink(),
              },
            ),
          ],
        ),
      ),
    );

    if (!isWinning) {
      return cell;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radii.borderCell,
        boxShadow: AppShadows.boardCellWinningGlow(colors.boardCellWinningGlow),
      ),
      child: cell,
    );
  }
}

class _BoardCellInsetShadow extends StatelessWidget {
  const _BoardCellInsetShadow({
    required this.shadowColor,
    required this.maskColor,
  });

  final Color shadowColor;
  final Color maskColor;

  static const double _fadeStart = 0.28;
  static const double _fadeMid = 0.58;
  static const double _maskMidAlpha = 0.8;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.center,
          radius: 1,
          colors: [
            maskColor.withValues(alpha: 0),
            maskColor.withValues(alpha: _maskMidAlpha),
            maskColor,
          ],
          stops: const [_fadeStart, _fadeMid, 1],
        ).createShader(bounds);
      },
      child: ColoredBox(color: shadowColor),
    );
  }
}
