import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/services/minimax_ai_strategy.dart';

/// Plays the CPU move using the strategy selected by the game difficulty.
final class PlayCpuMoveUseCase {
  final MinimaxAiStrategy strategy;

  const PlayCpuMoveUseCase({required this.strategy});

  /// Applies one CPU move and returns the updated game.
  Result<Game> execute({required Game game}) {
    if (!game.canCpuPlay()) {
      return const Result.failure(InvalidMoveError());
    }

    final cellIndex = strategy.chooseCell(game: game);
    if (cellIndex == null || !game.canCpuPlayAt(cellIndex)) {
      return const Result.failure(InvalidMoveError());
    }

    return Result.success(game.applyCpuMove(cellIndex));
  }
}
