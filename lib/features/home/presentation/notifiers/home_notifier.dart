import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/di/home_navigation_provider.dart';
import 'package:tictactoe/features/home/presentation/notifiers/home_state.dart';

part 'home_notifier.g.dart';

/// Manages home screen state and user commands.
@Riverpod(name: 'homeNotifierProvider')
class HomeNotifier extends _$HomeNotifier {
  int _resumeAvailabilityRequestId = 0;

  @override
  HomeState build() {
    _loadResumeAvailability();
    return const HomeState(isResumeEnabled: false);
  }

  /// Reloads whether a saved game can be resumed.
  void refreshResumeAvailability() {
    _loadResumeAvailability();
  }

  Future<void> _loadResumeAvailability() async {
    final requestId = ++_resumeAvailabilityRequestId;
    final result = await ref.read(hasSavedGameUseCaseProvider).execute();
    if (!ref.mounted || requestId != _resumeAvailabilityRequestId) {
      return;
    }

    final isResumeEnabled = switch (result) {
      Success(:final value) => value,
      Failure() => false,
    };

    state = HomeState(isResumeEnabled: isResumeEnabled);
  }

  /// Navigates to the game screen for a new game.
  void openNewGame({required Difficulty difficulty}) {
    ref.read(homeNavigationProvider).openNewGame(difficulty: difficulty);
  }

  /// Navigates to the game screen to resume a saved game.
  void openResumeGame() {
    if (!state.isResumeEnabled) {
      return;
    }

    ref.read(homeNavigationProvider).openResumeGame();
  }
}
