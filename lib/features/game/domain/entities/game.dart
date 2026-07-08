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

  static const List<List<int>> _winningLines = <List<int>>[
    <int>[0, 1, 2],
    <int>[3, 4, 5],
    <int>[6, 7, 8],
    <int>[0, 3, 6],
    <int>[1, 4, 7],
    <int>[2, 5, 8],
    <int>[0, 4, 8],
    <int>[2, 4, 6],
  ];

  /// Creates a new game with an empty board and [firstPlayer] to move first.
  factory Game.initial({Player firstPlayer = Player.x}) {
    return Game(
      board: List<Player?>.filled(boardSize, null),
      status: GameStatus.playing,
      currentPlayer: firstPlayer,
    );
  }

  /// Whether the game can be resumed by the player.
  bool get isResumable => status == GameStatus.playing;

  /// Whether the human player can play at [cellIndex].
  bool canHumanPlayAt(int cellIndex) {
    if (cellIndex < 0 || cellIndex >= boardSize) {
      return false;
    }
    if (status != GameStatus.playing) {
      return false;
    }
    if (currentPlayer != Player.x) {
      return false;
    }
    return board[cellIndex] == null;
  }

  /// Whether the CPU can play a move.
  bool canCpuPlay() {
    if (status != GameStatus.playing) {
      return false;
    }
    if (currentPlayer != Player.o) {
      return false;
    }
    return board.any((cell) => cell == null);
  }

  /// Applies a human move at [cellIndex].
  ///
  /// Caller must ensure [canHumanPlayAt] is true.
  Game applyHumanMove(int cellIndex) {
    return _applyMove(cellIndex: cellIndex, player: Player.x);
  }

  /// Applies a CPU move on the first available cell.
  ///
  /// Caller must ensure [canCpuPlay] is true.
  Game applyCpuMoveFirstAvailable() {
    final cellIndex = board.indexWhere((cell) => cell == null);
    return _applyMove(cellIndex: cellIndex, player: Player.o);
  }

  /// Returns the winning player for [board], or null when there is no winner.
  static Player? winnerForBoard(List<Player?> board) {
    for (final line in _winningLines) {
      final first = board[line[0]];
      if (first == null) {
        continue;
      }
      if (board[line[1]] == first && board[line[2]] == first) {
        return first;
      }
    }
    return null;
  }

  /// The winning player when [status] is [GameStatus.won].
  Player? get winner => status == GameStatus.won ? winnerForBoard(board) : null;

  /// Resolves the game status for a board state.
  static GameStatus statusForBoard(List<Player?> board) {
    if (winnerForBoard(board) != null) {
      return GameStatus.won;
    }

    final hasFreeCell = board.any((cell) => cell == null);
    return hasFreeCell ? GameStatus.playing : GameStatus.draw;
  }

  Game _applyMove({required int cellIndex, required Player player}) {
    final updatedBoard = List<Player?>.from(board);
    updatedBoard[cellIndex] = player;
    final updatedStatus = statusForBoard(updatedBoard);
    final nextPlayer = player == Player.x ? Player.o : Player.x;

    return copyWith(
      board: updatedBoard,
      status: updatedStatus,
      currentPlayer: updatedStatus == GameStatus.playing
          ? nextPlayer
          : currentPlayer,
    );
  }
}
