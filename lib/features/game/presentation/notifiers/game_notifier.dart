import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/di/game_navigation_provider.dart';
import 'package:tictactoe/features/game/di/start_game_use_case_provider.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_state.dart';

part 'game_notifier.g.dart';

/// Manages game screen state and user commands.
@Riverpod(name: 'gameNotifierProvider')
class GameNotifier extends _$GameNotifier {
  @override
  GameState build(GameEntryMode entryMode) {
    return switch (entryMode) {
      GameEntryMode.newGame => _startNewGame(),
      GameEntryMode.resume => const GameState(),
    };
  }

  /// Navigates back to the home screen.
  void goHome() {
    ref.read(gameNavigationProvider).goHome();
  }

  GameState _startNewGame() {
    final result = ref.read(startGameUseCaseProvider).execute();

    return switch (result) {
      Success(:final value) => GameState(game: value),
      Failure(:final error) => GameState(error: error),
    };
  }
}
