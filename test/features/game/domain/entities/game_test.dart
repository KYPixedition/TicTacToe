import 'package:flutter_test/flutter_test.dart';

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

  test('applyHumanMove updates board and switches turn to cpu', () {
    final updatedGame = Game.initial(
      difficulty: Difficulty.easy,
    ).applyHumanMove(0);

    expect(updatedGame.board[0], Player.x);
    expect(updatedGame.currentPlayer, Player.o);
    expect(updatedGame.status, GameStatus.playing);
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
