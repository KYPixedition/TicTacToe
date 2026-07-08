import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tictactoe/features/game/domain/usecases/start_game_use_case.dart';

part 'start_game_use_case_provider.g.dart';

/// Provides the [StartGameUseCase].
@riverpod
StartGameUseCase startGameUseCase(Ref ref) {
  return const StartGameUseCase();
}
