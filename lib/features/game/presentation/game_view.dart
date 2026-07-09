import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/app_button.dart';
import 'package:tictactoe/core/widgets/app_gradient_background.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_intent.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_grid.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_app_bar.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_status_label.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

class GameView extends ConsumerWidget {
  const GameView({super.key, required this.entryIntent});

  final GameEntryIntent entryIntent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(gameNotifierProvider(entryIntent));
    final game = state.game;
    final spacings = context.spacings;
    final showPlayAgain =
        game != null &&
        game.status != GameStatus.playing &&
        !state.isPlayAgainInProgress;

    return Scaffold(
      appBar: game != null ? const GameAppBar() : null,
      body: AppGradientBackground(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: spacings.paddingL,
            child: Column(
              spacing: spacings.m,
              children: [
                if (game != null) ...[
                  GameStatusLabel(
                    status: game.status,
                    winner: game.winner,
                    currentPlayer: game.currentPlayer,
                    isCpuThinking: state.isCpuThinking,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: BoardGrid(
                        board: game.board,
                        winningLineIndices: game.winningLineIndices,
                        isInteractionEnabled:
                            !state.isCpuThinking &&
                            game.status == GameStatus.playing,
                        onCellTap: (cellIndex) {
                          ref
                              .read(gameNotifierProvider(entryIntent).notifier)
                              .playMove(cellIndex: cellIndex);
                        },
                      ),
                    ),
                  ),
                ] else
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),

                if (game != null)
                  Visibility(
                    visible: showPlayAgain,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AppButton.primary(
                      onPressed: showPlayAgain
                          ? () => ref
                                .read(
                                  gameNotifierProvider(entryIntent).notifier,
                                )
                                .playAgain()
                          : null,
                      label: l10n?.gamePlayAgain ?? '',
                      icon: Icons.replay_rounded,
                      minWidth: AppButton.defaultMinWidth,
                    ),
                  ),
                AppButton.secondary(
                  onPressed: () => ref
                      .read(gameNotifierProvider(entryIntent).notifier)
                      .goHome(),
                  label: l10n?.gameBackToHome ?? '',
                  icon: Icons.home_rounded,
                  minWidth: AppButton.defaultMinWidth,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
