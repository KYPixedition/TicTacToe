import 'package:tictactoe/features/game/domain/entities/difficulty.dart';

/// Navigation contract for the home feature.
abstract interface class HomeNavigation {
  /// Navigates to the game screen to start a new game.
  void openNewGame({required Difficulty difficulty});

  /// Navigates to the game screen to resume a saved game.
  void openResumeGame();
}
