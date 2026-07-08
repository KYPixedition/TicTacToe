import 'package:json_annotation/json_annotation.dart';

import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

part 'game_dto.g.dart';

/// Data transfer object for serializing a [Game] to local storage.
@JsonSerializable()
class GameDto {
  const GameDto({
    required this.board,
    required this.status,
    required this.currentPlayer,
    required this.difficulty,
  });

  factory GameDto.fromJson(Map<String, dynamic> json) =>
      _$GameDtoFromJson(json);

  final List<String?> board;
  final String status;
  final String currentPlayer;
  final String difficulty;

  Map<String, dynamic> toJson() => _$GameDtoToJson(this);

  /// Maps this DTO to a domain [Game] entity.
  Game toDomain() {
    return Game(
      board: board.map(_parseCell).toList(),
      status: _parseStatus(status),
      currentPlayer: _parsePlayer(currentPlayer),
      difficulty: _parseDifficulty(difficulty),
    );
  }

  /// Maps a domain [Game] entity to DTO.
  factory GameDto.fromDomain(Game game) {
    return GameDto(
      board: game.board.map(_playerToJson).toList(),
      status: game.status.name,
      currentPlayer: game.currentPlayer.name,
      difficulty: game.difficulty.name,
    );
  }

  static Player? _parseCell(String? value) {
    return switch (value) {
      'x' || 'X' => Player.x,
      'o' || 'O' => Player.o,
      null => null,
      _ => null,
    };
  }

  static GameStatus _parseStatus(String value) {
    return switch (value) {
      'playing' => GameStatus.playing,
      'won' => GameStatus.won,
      'draw' => GameStatus.draw,
      _ => GameStatus.playing,
    };
  }

  static Player _parsePlayer(String value) {
    return switch (value) {
      'x' || 'X' => Player.x,
      'o' || 'O' => Player.o,
      _ => Player.x,
    };
  }

  static Difficulty _parseDifficulty(String value) {
    return switch (value) {
      'easy' => Difficulty.easy,
      'medium' => Difficulty.medium,
      'hard' => Difficulty.hard,
      _ => throw FormatException('Unknown difficulty value: $value'),
    };
  }

  static String? _playerToJson(Player? player) {
    return switch (player) {
      Player.x => 'x',
      Player.o => 'o',
      null => null,
    };
  }
}
