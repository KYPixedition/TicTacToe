import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';

/// Creates a new game with a valid initial state.
final class StartGameUseCase {
  const StartGameUseCase();

  /// Returns a fresh game ready for the human player to open.
  Result<Game> execute() {
    return Result.success(Game.initial());
  }
}
