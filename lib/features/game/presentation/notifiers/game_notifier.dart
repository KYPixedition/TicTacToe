import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/di/clear_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/game/di/game_navigation_provider.dart';
import 'package:tictactoe/features/game/di/play_cpu_move_use_case_provider.dart';
import 'package:tictactoe/features/game/di/play_move_use_case_provider.dart';
import 'package:tictactoe/features/game/di/resume_game_use_case_provider.dart';
import 'package:tictactoe/features/game/di/save_game_use_case_provider.dart';
import 'package:tictactoe/features/game/di/start_game_use_case_provider.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_state.dart';

part 'game_notifier.g.dart';

const Duration _cpuTurnDelay = Duration(milliseconds: 400);

/// Manages game screen state and user commands.
@Riverpod(name: 'gameNotifierProvider')
class GameNotifier extends _$GameNotifier {
  @override
  GameState build(GameEntryMode entryMode) {
    switch (entryMode) {
      case GameEntryMode.newGame:
        return _createNewGameState(firstPlayer: Player.x);
      case GameEntryMode.resume:
        return _restoreOrStartNewGame();
    }
  }

  /// Navigates back to the home screen.
  void goHome() {
    ref.read(gameNavigationProvider).goHome();
  }

  /// Starts a new match on the same screen, alternating the opening player.
  Future<void> playAgain() async {
    final currentGame = state.game;
    if (currentGame == null || currentGame.status == GameStatus.playing) {
      return;
    }
    if (state.isPlayAgainInProgress) {
      return;
    }

    state = state.copyWith(isPlayAgainInProgress: true);

    final nextStartingPlayer = state.lastStartingPlayer == Player.x
        ? Player.o
        : Player.x;
    final startResult = ref
        .read(startGameUseCaseProvider)
        .execute(firstPlayer: nextStartingPlayer);

    switch (startResult) {
      case Success(:final value):
        state = state.copyWith(
          game: value,
          lastStartingPlayer: nextStartingPlayer,
          error: null,
          isCpuThinking: false,
          isPlayAgainInProgress: false,
        );
        if (nextStartingPlayer == Player.o) {
          await _runCpuTurnIfNeeded(game: value);
        }
      case Failure(:final error):
        state = state.copyWith(error: error, isPlayAgainInProgress: false);
    }
  }

  /// Plays one human move and triggers the CPU move when needed.
  Future<void> playMove({required int cellIndex}) async {
    if (state.isCpuThinking) {
      return;
    }

    final currentGame = state.game;
    if (currentGame == null) {
      return;
    }

    final playResult = ref
        .read(playMoveUseCaseProvider)
        .execute(game: currentGame, cellIndex: cellIndex);

    switch (playResult) {
      case Success(:final value):
        state = state.copyWith(game: value, error: null);
        final saved = await _saveCurrentGame(game: value);
        if (!ref.mounted) {
          return;
        }
        if (!saved) {
          state = state.copyWith(game: currentGame);
          return;
        }
        await _runCpuTurnIfNeeded(game: value);
      case Failure():
        return;
    }
  }

  GameState _createNewGameState({required Player firstPlayer}) {
    final result = ref
        .read(startGameUseCaseProvider)
        .execute(firstPlayer: firstPlayer);

    return switch (result) {
      Success(:final value) => GameState(
        game: value,
        lastStartingPlayer: firstPlayer,
      ),
      Failure(:final error) => GameState(error: error),
    };
  }

  GameState _restoreOrStartNewGame() {
    state = const GameState();
    _restoreOrStartNewGameAsync();
    return state;
  }

  Future<void> _restoreOrStartNewGameAsync() async {
    final resumedResult = await ref.read(resumeGameUseCaseProvider).execute();
    if (!ref.mounted) {
      return;
    }

    switch (resumedResult) {
      case Success(:final value) when value != null:
        state = state.copyWith(game: value, error: null, isCpuThinking: false);
        await _runCpuTurnIfNeeded(game: value);
      default:
        final fallbackState = _createNewGameState(firstPlayer: Player.x);
        state = fallbackState;
        if (fallbackState.game == null) {
          goHome();
        }
    }
  }

  Future<void> _runCpuTurnIfNeeded({required Game game}) async {
    if (game.status != GameStatus.playing || game.currentPlayer != Player.o) {
      return;
    }

    state = state.copyWith(isCpuThinking: true);
    await Future<void>.delayed(_cpuTurnDelay);
    if (!ref.mounted) {
      return;
    }
    final cpuResult = ref.read(playCpuMoveUseCaseProvider).execute(game: game);

    switch (cpuResult) {
      case Success(:final value):
        state = state.copyWith(game: value, error: null, isCpuThinking: false);
        final saved = await _saveCurrentGame(game: value);
        if (!saved) {
          state = state.copyWith(game: game);
        }
      case Failure():
        state = state.copyWith(isCpuThinking: false);
    }
  }

  Future<bool> _saveCurrentGame({required Game game}) async {
    if (!game.isResumable) {
      final clearResult = await ref
          .read(clearSavedGameUseCaseProvider)
          .execute();
      switch (clearResult) {
        case Success():
          return true;
        case Failure(:final error):
          state = state.copyWith(error: error);
          return false;
      }
    }

    final saveResult = await ref
        .read(saveGameUseCaseProvider)
        .execute(game: game);
    switch (saveResult) {
      case Success():
        return true;
      case Failure(:final error):
        state = state.copyWith(error: error);
        return false;
    }
  }
}
