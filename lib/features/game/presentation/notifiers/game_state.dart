import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';

part 'game_state.freezed.dart';

/// UI state for the game screen.
@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    Game? game,
    AppError? error,
  }) = _GameState;
}
