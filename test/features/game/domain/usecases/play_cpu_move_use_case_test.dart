import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/usecases/play_cpu_move_use_case.dart';

void main() {
  const useCase = PlayCpuMoveUseCase();

  test('plays on first available cell', () {
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

    final result = useCase.execute(game: game);
    final updatedGame = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(updatedGame.board[1], Player.o);
    expect(updatedGame.currentPlayer, Player.x);
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
    final result = useCase.execute(game: Game.initial());

    expect(result, isA<Failure<Game>>());
  });
}
