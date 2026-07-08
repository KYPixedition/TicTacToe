import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';

/// Contract for game persistence and retrieval.
abstract interface class GameRepository {
  /// Returns whether a valid, resumable saved game exists.
  Future<Result<bool>> hasValidSavedGame();

  /// Loads a saved game when available and valid.
  ///
  /// Returns `null` when no save exists or when persisted data is invalid.
  Future<Result<Game?>> loadSavedGame();

  /// Persists a game state locally.
  Future<Result<void>> saveGame({required Game game});

  /// Clears any persisted game state.
  Future<Result<void>> clearSavedGame();
}
