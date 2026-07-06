import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

part 'game.freezed.dart';

/// Domain entity representing a Tic-Tac-Toe game state.
@freezed
abstract class Game with _$Game {
  const factory Game({
    required List<Player?> board,
    required GameStatus status,
    required Player currentPlayer,
  }) = _Game;

  const Game._();

  /// Whether the game can be resumed by the player.
  bool get isResumable => status == GameStatus.playing;
}
