import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

/// Creates a new game with a valid initial state.
final class StartGameUseCase {
  const StartGameUseCase();

  /// Returns a fresh game with [firstPlayer] to open the match.
  Result<Game> execute({
    required Difficulty difficulty,
    Player firstPlayer = Player.x,
  }) {
    return Result.success(
      Game.initial(difficulty: difficulty, firstPlayer: firstPlayer),
    );
  }
}
