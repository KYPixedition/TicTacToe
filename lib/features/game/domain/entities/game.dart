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

  /// Number of cells on the board.
  static const int boardSize = 9;

  /// Creates a new game with an empty board and the human player to move first.
  factory Game.initial() {
    return Game(
      board: List<Player?>.filled(boardSize, null),
      status: GameStatus.playing,
      currentPlayer: Player.x,
    );
  }

  /// Whether the game can be resumed by the player.
  bool get isResumable => status == GameStatus.playing;
}
