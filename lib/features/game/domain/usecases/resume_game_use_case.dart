import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

/// Loads a previously saved game.
final class ResumeGameUseCase {
  final GameRepository _repository;

  const ResumeGameUseCase({
    required this._repository,
  });

  /// Returns a saved game when available and valid.
  ///
  /// Returns `null` when no save exists or when persisted data is invalid.
  Future<Result<Game?>> execute() {
    return _repository.loadSavedGame();
  }
}
