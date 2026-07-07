import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe/features/game/domain/usecases/save_game_use_case.dart';

final class _FakeGameRepository implements GameRepository {
  Game? savedGame;
  int saveCalls = 0;

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    return const Result.success(false);
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    savedGame = game;
    saveCalls++;
    return const Result.success(null);
  }
}

void main() {
  test('delegates game saving to repository', () async {
    final fakeRepository = _FakeGameRepository();
    final useCase = SaveGameUseCase(repository: fakeRepository);
    final game = Game.initial();

    final result = await useCase.execute(game: game);

    expect(result, isA<Success<void>>());
    expect(fakeRepository.saveCalls, 1);
    expect(fakeRepository.savedGame, game);
  });
}
