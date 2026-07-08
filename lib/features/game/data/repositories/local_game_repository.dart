import 'dart:convert';

import 'package:talker/talker.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/data/datasources/game_local_data_source.dart';
import 'package:tictactoe/features/game/data/models/game_dto.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

/// Local implementation of [GameRepository] backed by [GameLocalDataSource].
final class LocalGameRepository implements GameRepository {
  final GameLocalDataSource _dataSource;
  final Talker _talker;

  const LocalGameRepository({required this._dataSource, required this._talker});

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    final loadResult = await loadSavedGame();
    return switch (loadResult) {
      Success(:final value) => Result.success(value?.isResumable ?? false),
      Failure() => const Result.success(false),
    };
  }

  @override
  Future<Result<Game?>> loadSavedGame() async {
    final readResult = await _dataSource.readRawGameState();
    return switch (readResult) {
      Success(:final value) => _parseAndValidateSavedGame(value),
      Failure(:final error) => _handleReadFailure(error),
    };
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    final encodedGame = jsonEncode(GameDto.fromDomain(game).toJson());
    return _dataSource.writeRawGameState(value: encodedGame);
  }

  @override
  Future<Result<void>> clearSavedGame() {
    return _dataSource.clearRawGameState();
  }

  Result<Game?> _handleReadFailure(Object error) {
    _talker.warning('Failed to read saved game state: $error');
    return const Result.success(null);
  }

  Future<Result<Game?>> _parseAndValidateSavedGame(String? rawValue) async {
    final parsedResult = _parseSavedGame(rawValue);
    return switch (parsedResult) {
      Success(:final value) when value != null && !value.isResumable =>
        _clearFinishedGameAndReturnNull(),
      _ => parsedResult,
    };
  }

  Future<Result<Game?>> _clearFinishedGameAndReturnNull() async {
    final clearResult = await _dataSource.clearRawGameState();
    switch (clearResult) {
      case Failure(:final error):
        _talker.warning('Failed to clear finished saved game state: $error');
      case Success():
        break;
    }
    return const Result.success(null);
  }

  Result<Game?> _parseSavedGame(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) {
      return const Result.success(null);
    }

    try {
      final Object? decoded = jsonDecode(rawValue);
      if (decoded is! Map<String, dynamic>) {
        _talker.warning('Saved game state is not a JSON object');
        return const Result.success(null);
      }

      final game = GameDto.fromJson(decoded).toDomain();
      if (game.board.length != 9) {
        _talker.warning(
          'Saved game board has invalid size: ${game.board.length}',
        );
        return const Result.success(null);
      }

      return Result.success(game);
    } on Object catch (error, stackTrace) {
      _talker.handle(error, stackTrace, 'Invalid saved game JSON');
      return const Result.success(null);
    }
  }
}
