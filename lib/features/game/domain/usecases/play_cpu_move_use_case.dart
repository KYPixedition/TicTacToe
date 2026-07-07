import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';

/// Plays the CPU move on the first available cell.
final class PlayCpuMoveUseCase {
  const PlayCpuMoveUseCase();

  /// Applies one CPU move and returns the updated game.
  Result<Game> execute({required Game game}) {
    if (!game.canCpuPlay()) {
      return const Result.failure(InvalidMoveError());
    }

    return Result.success(game.applyCpuMoveFirstAvailable());
  }
}
