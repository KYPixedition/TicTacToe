import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

void main() {
  test('statusForBoard returns won when top row is complete', () {
    final status = Game.statusForBoard(
      <Player?>[
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
    );

    expect(status, GameStatus.won);
  });

  test('statusForBoard returns won when middle column is complete', () {
    final status = Game.statusForBoard(
      <Player?>[
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
    );

    expect(status, GameStatus.won);
  });

  test('statusForBoard returns won when main diagonal is complete', () {
    final status = Game.statusForBoard(
      <Player?>[
        Player.o,
        Player.x,
        null,
        Player.x,
        Player.o,
        null,
        null,
        null,
        Player.o,
      ],
    );

    expect(status, GameStatus.won);
  });

  test('statusForBoard returns playing when board is not full and has no winner', () {
    final status = Game.statusForBoard(
      <Player?>[
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        null,
        null,
        null,
      ],
    );

    expect(status, GameStatus.playing);
  });

  test('statusForBoard returns draw when board is full without winner', () {
    final status = Game.statusForBoard(
      <Player?>[
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
    );

    expect(status, GameStatus.draw);
  });

  test('applyHumanMove updates board and switches turn to cpu', () {
    final updatedGame = Game.initial().applyHumanMove(0);

    expect(updatedGame.board[0], Player.x);
    expect(updatedGame.currentPlayer, Player.o);
    expect(updatedGame.status, GameStatus.playing);
  });

  test('applyCpuMoveFirstAvailable plays on first free cell', () {
    final game = Game(
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
      status: GameStatus.playing,
      currentPlayer: Player.o,
    );

    final updatedGame = game.applyCpuMoveFirstAvailable();

    expect(updatedGame.board[1], Player.o);
    expect(updatedGame.currentPlayer, Player.x);
  });
}
