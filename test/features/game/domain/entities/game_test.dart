import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

void main() {
  test('statusForBoard returns won when top row is complete', () {
    final status = Game.statusForBoard(<Player?>[
      Player.x,
      Player.x,
      Player.x,
      null,
      Player.o,
      null,
      null,
      null,
      null,
    ]);

    expect(status, GameStatus.won);
  });

  test('statusForBoard returns won when middle column is complete', () {
    final status = Game.statusForBoard(<Player?>[
      null,
      Player.o,
      null,
      Player.x,
      Player.o,
      null,
      Player.x,
      Player.o,
      null,
    ]);

    expect(status, GameStatus.won);
  });

  test('statusForBoard returns won when main diagonal is complete', () {
    final status = Game.statusForBoard(<Player?>[
      Player.o,
      Player.x,
      null,
      Player.x,
      Player.o,
      null,
      null,
      null,
      Player.o,
    ]);

    expect(status, GameStatus.won);
  });

  test(
    'statusForBoard returns playing when board is not full and has no winner',
    () {
      final status = Game.statusForBoard(<Player?>[
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        null,
        null,
        null,
      ]);

      expect(status, GameStatus.playing);
    },
  );

  test('statusForBoard returns draw when board is full without winner', () {
    final status = Game.statusForBoard(<Player?>[
      Player.x,
      Player.o,
      Player.x,
      Player.x,
      Player.o,
      Player.o,
      Player.o,
      Player.x,
      Player.x,
    ]);

    expect(status, GameStatus.draw);
  });

  test('winner returns Player.x when top row is complete', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        Player.x,
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.won,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    expect(game.winner, Player.x);
  });

  test('winner returns Player.o when middle column is complete', () {
    final game = Game(
      board: <Player?>[
        null,
        Player.o,
        null,
        Player.x,
        Player.o,
        null,
        Player.x,
        Player.o,
        null,
      ],
      status: GameStatus.won,
      currentPlayer: Player.o,
      difficulty: Difficulty.easy,
    );

    expect(game.winner, Player.o);
  });

  test('winner is null when game is playing', () {
    expect(Game.initial(difficulty: Difficulty.easy).winner, isNull);
  });

  test('winner is null when game is draw', () {
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
        Player.x,
      ],
      status: GameStatus.draw,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    expect(game.winner, isNull);
  });

  test('winnerForBoard matches statusForBoard winner detection', () {
    final board = <Player?>[
      Player.o,
      Player.x,
      null,
      Player.x,
      Player.o,
      null,
      null,
      null,
      Player.o,
    ];

    expect(Game.winnerForBoard(board), Player.o);
    expect(Game.statusForBoard(board), GameStatus.won);
  });

  test('winningLineIndicesForBoard returns top row indices', () {
    final board = <Player?>[
      Player.x,
      Player.x,
      Player.x,
      null,
      Player.o,
      null,
      null,
      null,
      null,
    ];

    expect(Game.winningLineIndicesForBoard(board), <int>[0, 1, 2]);
  });

  test('winningLineIndicesForBoard returns middle column indices', () {
    final board = <Player?>[
      null,
      Player.o,
      null,
      Player.x,
      Player.o,
      null,
      Player.x,
      Player.o,
      null,
    ];

    expect(Game.winningLineIndicesForBoard(board), <int>[1, 4, 7]);
  });

  test('winningLineIndicesForBoard returns main diagonal indices', () {
    final board = <Player?>[
      Player.o,
      Player.x,
      null,
      Player.x,
      Player.o,
      null,
      null,
      null,
      Player.o,
    ];

    expect(Game.winningLineIndicesForBoard(board), <int>[0, 4, 8]);
  });

  test('winningLineIndicesForBoard returns anti-diagonal indices', () {
    final board = <Player?>[
      null,
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      null,
      Player.o,
      null,
      Player.x,
    ];

    expect(Game.winningLineIndicesForBoard(board), <int>[2, 4, 6]);
  });

  test('winningLineIndicesForBoard returns null when there is no winner', () {
    final board = <Player?>[
      Player.x,
      null,
      Player.o,
      null,
      null,
      null,
      null,
      null,
      null,
    ];

    expect(Game.winningLineIndicesForBoard(board), isNull);
  });

  test('winningLineIndices is null when game is playing', () {
    expect(Game.initial(difficulty: Difficulty.easy).winningLineIndices, isNull);
  });

  test('winningLineIndices is null when game is draw', () {
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
        Player.x,
      ],
      status: GameStatus.draw,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    expect(game.winningLineIndices, isNull);
  });

  test('winningLineIndices returns winning line when game is won', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        Player.x,
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.won,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    expect(game.winningLineIndices, <int>[0, 1, 2]);
  });

  test('applyHumanMove updates board and switches turn to cpu', () {
    final initialGame = Game.initial(difficulty: Difficulty.easy);
    final result = initialGame.applyHumanMove(0);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.board[0], Player.x);
    expect(updatedGame.currentPlayer, Player.o);
    expect(updatedGame.status, GameStatus.playing);
  });

  test('applyHumanMove refuses move on occupied cell', () {
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

    final result = initialGame.applyHumanMove(0);

    expect(result, isA<Failure<Game>>());
    final error = switch (result) {
      Failure(:final error) => error,
      Success() => throw StateError('expected failure'),
    };
    expect(error, isA<InvalidMoveError>());
  });

  test('applyHumanMove refuses move when game is already won', () {
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

    final result = initialGame.applyHumanMove(6);

    expect(result, isA<Failure<Game>>());
    expect(initialGame.board[6], isNull);
    expect(initialGame.currentPlayer, Player.x);
  });

  test('applyHumanMove refuses move when game is already draw', () {
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

    final result = initialGame.applyHumanMove(0);

    expect(result, isA<Failure<Game>>());
    expect(initialGame.currentPlayer, Player.x);
    expect(initialGame.status, GameStatus.draw);
  });

  test('applyHumanMove refuses move during cpu turn', () {
    final initialGame = Game.initial(
      difficulty: Difficulty.easy,
    ).copyWith(currentPlayer: Player.o);

    final result = initialGame.applyHumanMove(0);

    expect(result, isA<Failure<Game>>());
    expect(initialGame.board[0], isNull);
    expect(initialGame.currentPlayer, Player.o);
  });

  test('applyHumanMove refuses move outside board bounds', () {
    final initialGame = Game.initial(difficulty: Difficulty.easy);

    final negativeResult = initialGame.applyHumanMove(-1);
    final overflowResult = initialGame.applyHumanMove(9);

    expect(negativeResult, isA<Failure<Game>>());
    expect(overflowResult, isA<Failure<Game>>());
    expect(initialGame.board, List<Player?>.filled(9, null));
  });

  test('applyHumanMove sets status to won when move completes a line', () {
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

    final result = game.applyHumanMove(2);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.status, GameStatus.won);
    expect(updatedGame.currentPlayer, Player.x);
  });

  test('applyHumanMove sets status to draw when board is full without winner', () {
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

    final result = game.applyHumanMove(8);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.status, GameStatus.draw);
  });

  test('initial with firstPlayer O sets cpu to move first', () {
    final game = Game.initial(
      difficulty: Difficulty.easy,
      firstPlayer: Player.o,
    );

    expect(game.currentPlayer, Player.o);
    expect(game.status, GameStatus.playing);
    expect(game.board, List<Player?>.filled(9, null));
  });
}
