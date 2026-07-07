import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';

/// Contract for game persistence and retrieval.
abstract interface class GameRepository {
  /// Returns whether a valid, resumable saved game exists.
  Future<Result<bool>> hasValidSavedGame();

  /// Persists a game state locally.
  Future<Result<void>> saveGame({required Game game});
}
