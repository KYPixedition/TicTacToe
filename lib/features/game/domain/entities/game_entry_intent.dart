import 'package:tictactoe/features/game/domain/entities/difficulty.dart';

/// Describes why the player opened the game screen.
sealed class GameEntryIntent {
  const GameEntryIntent();

  /// Starts a new game with the selected [difficulty].
  const factory GameEntryIntent.newGame({required Difficulty difficulty}) =
      NewGameEntryIntent;

  /// Attempts to resume a saved game.
  const factory GameEntryIntent.resume() = ResumeGameEntryIntent;
}

/// Intent for opening a fresh game with a selected difficulty.
final class NewGameEntryIntent extends GameEntryIntent {
  const NewGameEntryIntent({required this.difficulty});

  final Difficulty difficulty;
}

/// Intent for opening the game screen from a saved game.
final class ResumeGameEntryIntent extends GameEntryIntent {
  const ResumeGameEntryIntent();
}
