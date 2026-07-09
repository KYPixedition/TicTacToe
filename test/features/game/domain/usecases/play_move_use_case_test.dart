import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/usecases/play_move_use_case.dart';

void main() {
  const useCase = PlayMoveUseCase();

  test('delegates valid move to Game.applyHumanMove', () {
    final initialGame = Game.initial(difficulty: Difficulty.easy);

    final useCaseResult = useCase.execute(game: initialGame, cellIndex: 0);
    final entityResult = initialGame.applyHumanMove(0);

    final useCaseGame = switch (useCaseResult) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };
    final entityGame = switch (entityResult) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(useCaseGame, entityGame);
    expect(useCaseGame.board[0], Player.x);
    expect(useCaseGame.currentPlayer, Player.o);
  });

  test('delegates invalid move failure from Game.applyHumanMove', () {
    final initialGame = Game.initial(
      difficulty: Difficulty.easy,
    ).copyWith(currentPlayer: Player.o);

    final useCaseResult = useCase.execute(game: initialGame, cellIndex: 0);
    final entityResult = initialGame.applyHumanMove(0);

    expect(useCaseResult, isA<Failure<Game>>());
    expect(entityResult, isA<Failure<Game>>());
    final useCaseError = switch (useCaseResult) {
      Failure(:final error) => error,
      Success() => throw StateError('expected failure'),
    };
    final entityError = switch (entityResult) {
      Failure(:final error) => error,
      Success() => throw StateError('expected failure'),
    };
    expect(useCaseError, entityError);
    expect(useCaseError, isA<InvalidMoveError>());
  });
}
