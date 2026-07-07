import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/app_button.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_grid.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_status_label.dart';
import 'package:tictactoe/features/game/presentation/widgets/player_turn_row.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

/// Game screen for a new or resumed match.
class GameView extends ConsumerWidget {
  const GameView({super.key, required this.entryMode});

  final GameEntryMode entryMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(gameNotifierProvider(entryMode));
    final game = state.game;
    final colors = context.colors;
    final spacings = context.spacings;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: spacings.paddingL,
          child: Column(
            children: [
              if (game != null) ...[
                PlayerTurnRow(
                  currentPlayer: game.currentPlayer,
                  status: game.status,
                ),
                spacings.gapVerticalM,
                GameStatusLabel(
                  status: game.status,
                  winner: game.winner,
                  currentPlayer: game.currentPlayer,
                  isCpuThinking: state.isCpuThinking,
                ),
                spacings.gapVerticalXxl,
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: BoardGrid(
                      board: game.board,
                      isInteractionEnabled:
                          !state.isCpuThinking &&
                          game.status == GameStatus.playing,
                      onCellTap: (cellIndex) {
                        ref
                            .read(gameNotifierProvider(entryMode).notifier)
                            .playMove(cellIndex: cellIndex);
                      },
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: _GameResumePlaceholder(entryMode: entryMode),
                  ),
                ),
              ],
              spacings.gapVerticalM,
              if (game != null &&
                  game.status != GameStatus.playing &&
                  !state.isPlayAgainInProgress) ...[
                AppButton.primary(
                  onPressed: () => ref
                      .read(gameNotifierProvider(entryMode).notifier)
                      .playAgain(),
                  label: l10n?.gamePlayAgain ?? '',
                  icon: Icons.replay_rounded,
                  minWidth: AppButton.defaultMinWidth,
                ),
                spacings.gapVerticalM,
              ],
              AppButton.secondary(
                onPressed: () =>
                    ref.read(gameNotifierProvider(entryMode).notifier).goHome(),
                label: l10n?.gameBackToHome ?? '',
                icon: Icons.home_rounded,
                minWidth: AppButton.defaultMinWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Placeholder shown when resume is not yet implemented.
class _GameResumePlaceholder extends StatelessWidget {
  const _GameResumePlaceholder({required this.entryMode});

  final GameEntryMode entryMode;

  @override
  Widget build(BuildContext context) {
    if (entryMode != GameEntryMode.resume) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);

    return Text(
      l10n?.gameEntryModeResume ?? '',
      style: context.typos.body.copyWith(color: context.colors.onSurface),
    );
  }
}
