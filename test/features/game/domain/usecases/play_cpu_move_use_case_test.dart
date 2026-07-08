import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/services/minimax_ai_strategy.dart';
import 'package:tictactoe/features/game/domain/usecases/play_cpu_move_use_case.dart';

void main() {
  const useCase = PlayCpuMoveUseCase(strategy: MinimaxAiStrategy());

  test('plays a valid cpu move selected by difficulty strategy', () {
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
      difficulty: Difficulty.hard,
    );

    final result = useCase.execute(game: game);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.board.where((cell) => cell == Player.o).length, 1);
    expect(updatedGame.currentPlayer, Player.x);
  });

  test('hard difficulty takes immediate winning move', () {
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

    final result = useCase.execute(game: game);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.board[2], Player.o);
    expect(updatedGame.status, GameStatus.won);
  });

  test('returns failure when game is already finished', () {
    final game = Game(
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
      currentPlayer: Player.o,
      difficulty: Difficulty.hard,
    );

    final result = useCase.execute(game: game);

    expect(result, isA<Failure<Game>>());
    final error = switch (result) {
      Failure(:final error) => error,
      Success() => throw StateError('expected failure'),
    };
    expect(error, isA<InvalidMoveError>());
  });

  test('returns failure when it is not cpu turn', () {
    final result = useCase.execute(
      game: Game.initial(difficulty: Difficulty.hard),
    );

    expect(result, isA<Failure<Game>>());
  });
}
