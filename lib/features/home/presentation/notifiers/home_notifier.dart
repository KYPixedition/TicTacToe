import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/di/home_navigation_provider.dart';
import 'package:tictactoe/features/home/presentation/notifiers/home_state.dart';

part 'home_notifier.g.dart';

/// Manages home screen state and user commands.
@Riverpod(name: 'homeNotifierProvider')
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() {
    _loadResumeAvailability();
    return const HomeState(isResumeEnabled: false);
  }

  Future<void> _loadResumeAvailability() async {
    final result = await ref.read(hasSavedGameUseCaseProvider).execute();
    if (!ref.mounted) {
      return;
    }

    final isResumeEnabled = switch (result) {
      Success(:final value) => value,
      Failure() => false,
    };

    state = HomeState(isResumeEnabled: isResumeEnabled);
  }

  /// Navigates to the game screen for a new game.
  void openNewGame() {
    ref.read(homeNavigationProvider).openNewGame();
  }

  /// Navigates to the game screen to resume a saved game.
  void openResumeGame() {
    if (!state.isResumeEnabled) {
      return;
    }

    ref.read(homeNavigationProvider).openResumeGame();
  }
}
