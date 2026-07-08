import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';

import '../../../../fakes/fake_game_repository.dart';

void main() {
  late FakeGameRepository repository;
  late HasSavedGameUseCase useCase;

  setUp(() {
    repository = FakeGameRepository();
    useCase = HasSavedGameUseCase(repository: repository);
  });

  test('returns true when a valid saved game exists', () async {
    repository.hasSavedGame = true;

    final Result<bool> result = await useCase.execute();

    expect(result, isA<Success<bool>>());
    expect(switch (result) {
      Success(:final value) => value,
      Failure() => fail('expected success'),
    }, isTrue);
  });

  test('returns false when no saved game exists', () async {
    repository.hasSavedGame = false;

    final Result<bool> result = await useCase.execute();

    expect(result, isA<Success<bool>>());
    expect(switch (result) {
      Success(:final value) => value,
      Failure() => false,
    }, isFalse);
  });

  test('returns failure when repository fails', () async {
    repository.shouldFail = true;

    final Result<bool> result = await useCase.execute();

    expect(result, isA<Failure<bool>>());
    expect(switch (result) {
      Success() => null,
      Failure(:final error) => error,
    }, isA<StorageReadError>());
  });
}
