import 'dart:convert';

import 'package:talker/talker.dart';
import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/data/datasources/game_local_data_source.dart';
import 'package:tictactoe/features/game/data/models/game_dto.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

/// Local implementation of [GameRepository] backed by [GameLocalDataSource].
final class LocalGameRepository implements GameRepository {
  final GameLocalDataSource _dataSource;
  final Talker _talker;

  const LocalGameRepository({
    required this._dataSource,
    required this._talker,
  });

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    final readResult = await _dataSource.readRawGameState();

    return switch (readResult) {
      Failure(:final error) => _handleReadFailure(error),
      Success(:final value) => _parseSavedGame(value),
    };
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    final encodedGame = jsonEncode(GameDto.fromDomain(game).toJson());
    return _dataSource.writeRawGameState(value: encodedGame);
  }

  Result<bool> _handleReadFailure(AppError error) {
    _talker.warning('Failed to read saved game state: $error');
    return const Result.success(false);
  }

  Result<bool> _parseSavedGame(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) {
      return const Result.success(false);
    }

    try {
      final Object? decoded = jsonDecode(rawValue);
      if (decoded is! Map<String, dynamic>) {
        _talker.warning('Saved game state is not a JSON object');
        return const Result.success(false);
      }

      final game = GameDto.fromJson(decoded).toDomain();
      if (game.board.length != 9) {
        _talker.warning('Saved game board has invalid size: ${game.board.length}');
        return const Result.success(false);
      }

      return Result.success(game.isResumable);
    } on Object catch (error, stackTrace) {
      _talker.handle(error, stackTrace, 'Invalid saved game JSON');
      return const Result.success(false);
    }
  }
}
