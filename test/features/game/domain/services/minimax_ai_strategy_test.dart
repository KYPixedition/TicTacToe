import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/services/minimax_ai_strategy.dart';

void main() {
  const strategy = MinimaxAiStrategy();

  test('returns a valid empty cell for each difficulty', () {
    for (final difficulty in Difficulty.values) {
      final game = Game(
        board: <Player?>[
          Player.x,
          null,
          null,
          null,
          Player.o,
          null,
          null,
          null,
          null,
        ],
        status: GameStatus.playing,
        currentPlayer: Player.o,
        difficulty: difficulty,
      );

      final cellIndex = strategy.chooseCell(game: game);

      expect(cellIndex, isNotNull);
      expect(game.canCpuPlayAt(cellIndex ?? -1), isTrue);
    }
  });

  test('does not mutate the game while computing a move', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        null,
        null,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.hard,
    );
    final originalBoard = List<Player?>.from(game.board);

    strategy.chooseCell(game: game);

    expect(game.board, originalBoard);
  });

  test('returns null when no move is available', () {
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
      currentPlayer: Player.o,
      difficulty: Difficulty.hard,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, isNull);
  });

  test(
    'easy difficulty uses fallback percentile when no immediate win exists',
    () {
      final game = Game(
        board: <Player?>[
          Player.x,
          null,
          null,
          null,
          Player.o,
          null,
          null,
          null,
          null,
        ],
        status: GameStatus.playing,
        currentPlayer: Player.o,
        difficulty: Difficulty.easy,
      );

      final cellIndex = strategy.chooseCell(game: game);

      expect(cellIndex, 5);
    },
  );

  test('easy difficulty chooses an immediate winning move', () {
    final game = Game(
      board: <Player?>[
        Player.o,
        Player.o,
        null,
        Player.x,
        null,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.easy,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 2);
  });

  test('medium difficulty chooses an immediate winning move', () {
    final game = Game(
      board: <Player?>[
        Player.o,
        Player.o,
        null,
        Player.x,
        null,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.medium,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 2);
  });

  test('medium difficulty blocks an immediate human winning move', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.medium,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 2);
  });

  test('medium difficulty prefers winning immediately over blocking', () {
    final game = Game(
      board: <Player?>[
        Player.o,
        Player.o,
        null,
        Player.x,
        Player.x,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.medium,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 2);
  });

  test('medium difficulty uses fallback percentile when no tactic exists', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        null,
        null,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.medium,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 6);
  });

  test('hard difficulty chooses an immediate winning move', () {
    final game = Game(
      board: <Player?>[
        Player.o,
        Player.o,
        null,
        Player.x,
        Player.x,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.hard,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 2);
  });

  test('hard difficulty blocks an immediate human winning move', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.hard,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 2);
  });

  test('hard difficulty prefers winning immediately over blocking', () {
    final game = Game(
      board: <Player?>[
        Player.o,
        Player.o,
        null,
        Player.x,
        Player.x,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.hard,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 2);
  });

  test('hard difficulty uses fallback percentile when no tactic exists', () {
    final game = Game(
      board: <Player?>[
        Player.x,
        null,
        null,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.o,
      difficulty: Difficulty.hard,
    );

    final cellIndex = strategy.chooseCell(game: game);

    expect(cellIndex, 7);
  });

  test(
    'easy difficulty does not block when only the human can win immediately',
    () {
      final game = Game(
        board: <Player?>[
          Player.x,
          Player.x,
          null,
          Player.o,
          null,
          null,
          null,
          null,
          null,
        ],
        status: GameStatus.playing,
        currentPlayer: Player.o,
        difficulty: Difficulty.easy,
      );

      final cellIndex = strategy.chooseCell(game: game);

      expect(cellIndex, isNot(2));
    },
  );
}
