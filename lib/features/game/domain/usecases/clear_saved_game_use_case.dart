import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

/// Clears any saved game from local persistence.
final class ClearSavedGameUseCase {
  final GameRepository _repository;

  const ClearSavedGameUseCase({
    required this._repository,
  });

  /// Deletes persisted game state.
  Future<Result<void>> execute() {
    return _repository.clearSavedGame();
  }
}
