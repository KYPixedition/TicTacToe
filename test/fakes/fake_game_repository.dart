import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

/// In-memory fake [GameRepository] for tests.
final class FakeGameRepository implements GameRepository {
  bool hasSavedGame = false;
  bool shouldFail = false;

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    if (shouldFail) {
      return const Result.failure(StorageReadError());
    }

    return Result.success(hasSavedGame);
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    if (shouldFail) {
      return const Result.failure(StorageWriteError());
    }

    hasSavedGame = true;
    return const Result.success(null);
  }
}
