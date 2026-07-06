import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

/// Checks whether a valid saved game exists in local storage.
final class HasSavedGameUseCase {
  final GameRepository _repository;

  const HasSavedGameUseCase({
    required this._repository,
  });

  /// Returns whether the player can resume a saved game.
  Future<Result<bool>> execute() {
    return _repository.hasValidSavedGame();
  }
}
