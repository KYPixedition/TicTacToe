import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/usecases/play_move_use_case.dart';

void main() {
  const useCase = PlayMoveUseCase();

  test('applies valid move and switches turn to cpu', () {
    final result = useCase.execute(
      game: Game.initial(difficulty: Difficulty.easy),
      cellIndex: 0,
    );

    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.board[0], Player.x);
    expect(game.currentPlayer, Player.o);
    expect(game.status, GameStatus.playing);
  });

  test('refuses move on occupied cell', () {
    final initialGame = Game.initial(difficulty: Difficulty.easy).copyWith(
      board: <Player?>[
        Player.x,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ],
    );

    final result = useCase.execute(game: initialGame, cellIndex: 0);

    expect(result, isA<Failure<Game>>());
    final error = switch (result) {
      Failure(:final error) => error,
      Success() => throw StateError('expected failure'),
    };
    expect(error, isA<InvalidMoveError>());
  });

  test('refuses move when game is already won', () {
    final initialGame = Game.initial(difficulty: Difficulty.easy).copyWith(
      board: <Player?>[
        Player.x,
        Player.x,
        Player.x,
        Player.o,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.won,
    );

    final result = useCase.execute(game: initialGame, cellIndex: 6);

    expect(result, isA<Failure<Game>>());
    expect(initialGame.board[6], isNull);
    expect(initialGame.currentPlayer, Player.x);
  });

  test('refuses move when game is already draw', () {
    final initialGame = Game(
      board: <Player?>[
        Player.x,
        Player.o,
        Player.x,
        Player.x,
        Player.o,
        Player.o,
        Player.o,
        Player.x,
        Player.o,
      ],
      status: GameStatus.draw,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    final result = useCase.execute(game: initialGame, cellIndex: 0);

    expect(result, isA<Failure<Game>>());
    expect(initialGame.currentPlayer, Player.x);
    expect(initialGame.status, GameStatus.draw);
  });

  test('refuses move during cpu turn', () {
    final initialGame = Game.initial(
      difficulty: Difficulty.easy,
    ).copyWith(currentPlayer: Player.o);

    final result = useCase.execute(game: initialGame, cellIndex: 0);

    expect(result, isA<Failure<Game>>());
    expect(initialGame.board[0], isNull);
    expect(initialGame.currentPlayer, Player.o);
  });

  test('refuses move outside board bounds', () {
    final initialGame = Game.initial(difficulty: Difficulty.easy);

    final negativeResult = useCase.execute(game: initialGame, cellIndex: -1);
    final overflowResult = useCase.execute(game: initialGame, cellIndex: 9);

    expect(negativeResult, isA<Failure<Game>>());
    expect(overflowResult, isA<Failure<Game>>());
    expect(initialGame.board, List<Player?>.filled(9, null));
  });

  test('sets status to won when move completes a line', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        Player.x,
        null,
        null,
        Player.o,
        null,
        null,
        null,
        Player.o,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    final result = useCase.execute(game: game, cellIndex: 2);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.status, GameStatus.won);
    expect(updatedGame.currentPlayer, Player.x);
  });

  test('sets status to draw when board is full without winner', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        Player.o,
        Player.x,
        Player.x,
        Player.o,
        Player.o,
        Player.o,
        Player.x,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    final result = useCase.execute(game: game, cellIndex: 8);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.status, GameStatus.draw);
  });
}
