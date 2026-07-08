// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDto _$GameDtoFromJson(Map<String, dynamic> json) => GameDto(
  board: (json['board'] as List<dynamic>).map((e) => e as String?).toList(),
  status: json['status'] as String,
  currentPlayer: json['currentPlayer'] as String,
  difficulty: json['difficulty'] as String,
);

Map<String, dynamic> _$GameDtoToJson(GameDto instance) => <String, dynamic>{
  'board': instance.board,
  'status': instance.status,
  'currentPlayer': instance.currentPlayer,
  'difficulty': instance.difficulty,
};
