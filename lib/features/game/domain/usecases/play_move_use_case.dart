import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';

/// Validates and applies a human move on the game board.
final class PlayMoveUseCase {
  const PlayMoveUseCase();

  /// Applies a move and returns the updated game.
  Result<Game> execute({
    required Game game,
    required int cellIndex,
  }) {
    if (!game.canHumanPlayAt(cellIndex)) {
      return const Result.failure(InvalidMoveError());
    }

    return Result.success(game.applyHumanMove(cellIndex));
  }
}
