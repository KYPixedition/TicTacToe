import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tictactoe/features/game/di/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/usecases/save_game_use_case.dart';

part 'save_game_use_case_provider.g.dart';

/// Provides the [SaveGameUseCase].
@riverpod
SaveGameUseCase saveGameUseCase(Ref ref) {
  return SaveGameUseCase(repository: ref.watch(gameRepositoryProvider));
}
