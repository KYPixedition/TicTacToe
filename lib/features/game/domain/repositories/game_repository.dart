import 'package:tictactoe/core/result/result.dart';

/// Contract for game persistence and retrieval.
abstract interface class GameRepository {
  /// Returns whether a valid, resumable saved game exists.
  Future<Result<bool>> hasValidSavedGame();
}
