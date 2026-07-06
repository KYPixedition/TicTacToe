import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';
import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/data/datasources/game_local_data_source.dart';
import 'package:tictactoe/features/game/data/repositories/local_game_repository.dart';

final class _FakeGameLocalDataSource implements GameLocalDataSource {
  _FakeGameLocalDataSource(this._value, {this.shouldFail = false});

  final String? _value;
  final bool shouldFail;

  @override
  Future<Result<String?>> readRawGameState() async {
    if (shouldFail) {
      return const Result.failure(StorageReadError());
    }

    return Result.success(_value);
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
      '{"board":["x",null,null,null,"o",null,null,null,null],"status":"playing","currentPlayer":"x"}';
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
        '{"board":["x","x","x",null,"o",null,null,"o",null],"status":"won","currentPlayer":"x"}';
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
}
