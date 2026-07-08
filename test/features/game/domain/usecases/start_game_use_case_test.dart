import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/usecases/start_game_use_case.dart';

void main() {
  const useCase = StartGameUseCase();

  test('returns an empty 3x3 board', () {
    final result = useCase.execute(difficulty: Difficulty.medium);

    expect(result, isA<Success<Game>>());
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.board, List<Player?>.filled(9, null));
  });

  test('sets human player X to move first', () {
    final result = useCase.execute(difficulty: Difficulty.medium);
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.currentPlayer, Player.x);
  });

  test('sets status to playing', () {
    final result = useCase.execute(difficulty: Difficulty.medium);
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.status, GameStatus.playing);
  });

  test('sets cpu player O to move first when requested', () {
    final result = useCase.execute(
      difficulty: Difficulty.medium,
      firstPlayer: Player.o,
    );
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.currentPlayer, Player.o);
    expect(game.board, List<Player?>.filled(9, null));
    expect(game.status, GameStatus.playing);
  });

  test('stores selected difficulty on new game', () {
    final result = useCase.execute(difficulty: Difficulty.hard);
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.difficulty, Difficulty.hard);
  });
}
