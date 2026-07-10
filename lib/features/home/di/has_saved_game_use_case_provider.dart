import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tictactoe/features/game/di/game_repository_provider.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';

part 'has_saved_game_use_case_provider.g.dart';

@riverpod
HasSavedGameUseCase hasSavedGameUseCase(Ref ref) {
  return HasSavedGameUseCase(repository: ref.watch(gameRepositoryProvider));
}
