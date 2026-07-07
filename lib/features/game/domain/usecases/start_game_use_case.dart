import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

/// Creates a new game with a valid initial state.
final class StartGameUseCase {
  const StartGameUseCase();

  /// Returns a fresh game with [firstPlayer] to open the match.
  Result<Game> execute({Player firstPlayer = Player.x}) {
    return Result.success(Game.initial(firstPlayer: firstPlayer));
  }
}
