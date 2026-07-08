import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

/// Selects a CPU move by ranking available cells with Minimax.
final class MinimaxAiStrategy {
  /// Creates a Minimax-based CPU strategy.
  const MinimaxAiStrategy();

  static const double _easyPercentile = 0.50;
  static const double _mediumPercentile = 0.70;
  static const double _hardPercentile = 0.85;

  /// Returns the selected cell index for [game], or null when no move is available.
  int? chooseCell({required Game game}) {
    final rankedMoves = _rankedMoves(game.board);
    if (rankedMoves.isEmpty) {
      return null;
    }

    return switch (game.difficulty) {
      Difficulty.easy => _chooseEasyMove(
        board: game.board,
        rankedMoves: rankedMoves,
      ),
      Difficulty.medium => _chooseTacticalMove(
        board: game.board,
        rankedMoves: rankedMoves,
        percentile: _mediumPercentile,
      ),
      Difficulty.hard => _chooseTacticalMove(
        board: game.board,
        rankedMoves: rankedMoves,
        percentile: _hardPercentile,
      ),
    };
  }

  int _chooseEasyMove({
    required List<Player?> board,
    required List<_RankedMove> rankedMoves,
  }) {
    final winningMove = _findImmediateWinningMove(
      board: board,
      player: Player.o,
    );
    if (winningMove != null) {
      return winningMove;
    }

    return _chooseMoveAtPercentile(
      rankedMoves: rankedMoves,
      percentile: _easyPercentile,
    );
  }

  int _chooseTacticalMove({
    required List<Player?> board,
    required List<_RankedMove> rankedMoves,
    required double percentile,
  }) {
    final winningMove = _findImmediateWinningMove(
      board: board,
      player: Player.o,
    );
    if (winningMove != null) {
      return winningMove;
    }

    final blockingMove = _findImmediateWinningMove(
      board: board,
      player: Player.x,
    );
    if (blockingMove != null) {
      return blockingMove;
    }

    return _chooseMoveAtPercentile(
      rankedMoves: rankedMoves,
      percentile: percentile,
    );
  }

  int _chooseMoveAtPercentile({
    required List<_RankedMove> rankedMoves,
    required double percentile,
  }) {
    final maxIndex = rankedMoves.length - 1;
    final moveIndex = (maxIndex * percentile).floor();
    return rankedMoves[moveIndex].cellIndex;
  }

  List<_RankedMove> _rankedMoves(List<Player?> board) {
    final moves = <_RankedMove>[];
    for (var cellIndex = 0; cellIndex < Game.boardSize; cellIndex++) {
      if (board[cellIndex] != null) {
        continue;
      }

      final nextBoard = List<Player?>.from(board);
      nextBoard[cellIndex] = Player.o;
      moves.add(
        _RankedMove(
          cellIndex: cellIndex,
          score: _scoreBoard(board: nextBoard, isCpuTurn: false, depth: 0),
        ),
      );
    }

    return moves..sort((left, right) {
      final scoreComparison = left.score.compareTo(right.score);
      if (scoreComparison != 0) {
        return scoreComparison;
      }
      return left.cellIndex.compareTo(right.cellIndex);
    });
  }

  int? _findImmediateWinningMove({
    required List<Player?> board,
    required Player player,
  }) {
    for (var cellIndex = 0; cellIndex < Game.boardSize; cellIndex++) {
      if (board[cellIndex] != null) {
        continue;
      }

      final nextBoard = List<Player?>.from(board);
      nextBoard[cellIndex] = player;
      if (Game.winnerForBoard(nextBoard) == player) {
        return cellIndex;
      }
    }
    return null;
  }

  int _scoreBoard({
    required List<Player?> board,
    required bool isCpuTurn,
    required int depth,
  }) {
    final status = Game.statusForBoard(board);
    if (status != GameStatus.playing) {
      return _terminalScore(board: board, depth: depth);
    }

    final scores = <int>[];
    for (var cellIndex = 0; cellIndex < Game.boardSize; cellIndex++) {
      if (board[cellIndex] != null) {
        continue;
      }

      final nextBoard = List<Player?>.from(board);
      nextBoard[cellIndex] = isCpuTurn ? Player.o : Player.x;
      scores.add(
        _scoreBoard(board: nextBoard, isCpuTurn: !isCpuTurn, depth: depth + 1),
      );
    }

    scores.sort();
    return isCpuTurn ? scores.last : scores.first;
  }

  int _terminalScore({required List<Player?> board, required int depth}) {
    final winner = Game.winnerForBoard(board);
    return switch (winner) {
      Player.o => 10 - depth,
      Player.x => depth - 10,
      null => 0,
    };
  }
}

final class _RankedMove {
  const _RankedMove({required this.cellIndex, required this.score});

  final int cellIndex;
  final int score;
}
