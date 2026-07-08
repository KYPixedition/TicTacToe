import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe/features/game/domain/usecases/clear_saved_game_use_case.dart';

final class _FakeGameRepository implements GameRepository {
  int clearCalls = 0;

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    return const Result.success(false);
  }

  @override
  Future<Result<Game?>> loadSavedGame() async {
    return const Result.success(null);
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    return const Result.success(null);
  }

  @override
  Future<Result<void>> clearSavedGame() async {
    clearCalls++;
    return const Result.success(null);
  }
}

void main() {
  test('delegates saved game clearing to repository', () async {
    final fakeRepository = _FakeGameRepository();
    final useCase = ClearSavedGameUseCase(repository: fakeRepository);

    final result = await useCase.execute();

    expect(result, isA<Success<void>>());
    expect(fakeRepository.clearCalls, 1);
  });
}
