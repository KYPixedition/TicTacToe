import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

/// Persists a game state.
final class SaveGameUseCase {
  final GameRepository _repository;

  const SaveGameUseCase({required this._repository});

  /// Saves the current game.
  Future<Result<void>> execute({required Game game}) {
    return _repository.saveGame(game: game);
  }
}
