import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe/features/game/domain/usecases/resume_game_use_case.dart';

final class _FakeGameRepository implements GameRepository {
  Result<Game?> loadResult = const Result.success(null);

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    return Result.success(switch (loadResult) {
      Success(:final value) => value != null && value.isResumable,
      Failure() => false,
    });
  }

  @override
  Future<Result<Game?>> loadSavedGame() async {
    return loadResult;
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    return const Result.success(null);
  }

  @override
  Future<Result<void>> clearSavedGame() async {
    return const Result.success(null);
  }
}

void main() {
  late _FakeGameRepository repository;
  late ResumeGameUseCase useCase;

  setUp(() {
    repository = _FakeGameRepository();
    useCase = ResumeGameUseCase(repository: repository);
  });

  test('returns saved game when repository provides one', () async {
    repository.loadResult = Result.success(
      Game(
        board: <Player?>[
          Player.x,
          Player.o,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        ],
        status: GameStatus.playing,
        currentPlayer: Player.x,
        difficulty: Difficulty.medium,
      ),
    );

    final Result<Game?> result = await useCase.execute();

    final restoredGame = switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    };

    expect(restoredGame, isNotNull);
    expect(restoredGame?.board[0], Player.x);
    expect(restoredGame?.board[1], Player.o);
    expect(restoredGame?.difficulty, Difficulty.medium);
  });

  test('returns null when repository has no saved game', () async {
    repository.loadResult = const Result.success(null);

    final Result<Game?> result = await useCase.execute();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isNull);
  });

  test('propagates repository failure when read fails', () async {
    // LocalGameRepository maps read failures to Success(null); this covers other implementations.
    repository.loadResult = const Result.failure(StorageReadError());

    final Result<Game?> result = await useCase.execute();

    expect(result, isA<Failure<Game?>>());
  });
}
