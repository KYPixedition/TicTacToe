import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';
import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/data/datasources/game_local_data_source.dart';
import 'package:tictactoe/features/game/data/repositories/local_game_repository.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

final class _FakeGameLocalDataSource implements GameLocalDataSource {
  _FakeGameLocalDataSource(this._value, {this.shouldFail = false});

  final String? _value;
  final bool shouldFail;
  String? lastWrittenValue;
  int clearCalls = 0;

  @override
  Future<Result<String?>> readRawGameState() async {
    if (shouldFail) {
      return const Result.failure(StorageReadError());
    }

    return Result.success(_value);
  }

  @override
  Future<Result<void>> writeRawGameState({required String value}) async {
    lastWrittenValue = value;
    return const Result.success(null);
  }

  @override
  Future<Result<void>> clearRawGameState() async {
    clearCalls++;
    return const Result.success(null);
  }
}

void main() {
  late Talker talker;

  setUp(() {
    talker = Talker();
  });

  test('returns false when storage key is absent', () async {
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource(null),
      talker: talker,
    );

    final Result<bool> result = await repository.hasValidSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isFalse);
  });

  test('returns false when saved JSON is corrupted', () async {
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource('not-json'),
      talker: talker,
    );

    final Result<bool> result = await repository.hasValidSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isFalse);
  });

  test('returns true when saved game is valid and playing', () async {
    const rawJson =
        '{"board":["x",null,null,null,"o",null,null,null,null],"status":"playing","currentPlayer":"x","difficulty":"medium"}';
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource(rawJson),
      talker: talker,
    );

    final Result<bool> result = await repository.hasValidSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isTrue);
  });

  test('returns false when saved game is finished', () async {
    const rawJson =
        '{"board":["x","x","x",null,"o",null,null,"o",null],"status":"won","currentPlayer":"x","difficulty":"medium"}';
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource(rawJson),
      talker: talker,
    );

    final Result<bool> result = await repository.hasValidSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isFalse);
  });

  test('loadSavedGame returns null when saved game is finished', () async {
    const rawJson =
        '{"board":["x","x","x",null,"o",null,null,"o",null],"status":"won","currentPlayer":"x","difficulty":"medium"}';
    final dataSource = _FakeGameLocalDataSource(rawJson);
    final repository = LocalGameRepository(
      dataSource: dataSource,
      talker: talker,
    );

    final Result<Game?> result = await repository.loadSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isNull);
    expect(dataSource.clearCalls, 1);
  });

  test('loadSavedGame clears storage when saved game is a draw', () async {
    const rawJson =
        '{"board":["x","o","x","x","o","o","o","x","o"],"status":"draw","currentPlayer":"x","difficulty":"medium"}';
    final dataSource = _FakeGameLocalDataSource(rawJson);
    final repository = LocalGameRepository(
      dataSource: dataSource,
      talker: talker,
    );

    final Result<Game?> result = await repository.loadSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isNull);
    expect(dataSource.clearCalls, 1);
  });

  test('returns false when storage read fails', () async {
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource(null, shouldFail: true),
      talker: talker,
    );

    final Result<bool> result = await repository.hasValidSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isFalse);
  });

  test('loadSavedGame returns null when saved JSON is corrupted', () async {
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource('not-json'),
      talker: talker,
    );

    final Result<Game?> result = await repository.loadSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isNull);
  });

  test('loadSavedGame returns game when save is valid', () async {
    const rawJson =
        '{"board":["x",null,null,null,"o",null,null,null,null],"status":"playing","currentPlayer":"x","difficulty":"hard"}';
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource(rawJson),
      talker: talker,
    );

    final Result<Game?> result = await repository.loadSavedGame();

    final restoredGame = switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    };

    expect(restoredGame, isNotNull);
    expect(restoredGame?.board[0], Player.x);
    expect(restoredGame?.board[4], Player.o);
    expect(restoredGame?.currentPlayer, Player.x);
    expect(restoredGame?.difficulty, Difficulty.hard);
  });

  test('loadSavedGame returns null when saved JSON has no difficulty', () async {
    const rawJson =
        '{"board":["x",null,null,null,"o",null,null,null,null],"status":"playing","currentPlayer":"x"}';
    final repository = LocalGameRepository(
      dataSource: _FakeGameLocalDataSource(rawJson),
      talker: talker,
    );

    final Result<Game?> result = await repository.loadSavedGame();

    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isNull);
  });

  test('saveGame writes serialized game state', () async {
    final dataSource = _FakeGameLocalDataSource(null);
    final repository = LocalGameRepository(
      dataSource: dataSource,
      talker: talker,
    );

    final result = await repository.saveGame(
      game: Game.initial(difficulty: Difficulty.hard),
    );

    expect(result, isA<Success<void>>());
    expect(dataSource.lastWrittenValue, isNotNull);
    expect(dataSource.lastWrittenValue, contains('"status":"playing"'));
    expect(dataSource.lastWrittenValue, contains('"difficulty":"hard"'));
  });

  test('clearSavedGame clears persisted state', () async {
    final dataSource = _FakeGameLocalDataSource(null);
    final repository = LocalGameRepository(
      dataSource: dataSource,
      talker: talker,
    );

    final result = await repository.clearSavedGame();

    expect(result, isA<Success<void>>());
    expect(dataSource.clearCalls, 1);
  });
}
