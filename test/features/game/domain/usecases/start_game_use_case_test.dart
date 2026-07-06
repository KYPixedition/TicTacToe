import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/usecases/start_game_use_case.dart';

void main() {
  const useCase = StartGameUseCase();

  test('returns an empty 3x3 board', () {
    final result = useCase.execute();

    expect(result, isA<Success<Game>>());
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.board, List<Player?>.filled(9, null));
  });

  test('sets human player X to move first', () {
    final result = useCase.execute();
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.currentPlayer, Player.x);
  });

  test('sets status to playing', () {
    final result = useCase.execute();
    final game = switch (result) {
      Success(:final value) => value,
      Failure() => throw StateError('expected success'),
    };

    expect(game.status, GameStatus.playing);
  });
}
