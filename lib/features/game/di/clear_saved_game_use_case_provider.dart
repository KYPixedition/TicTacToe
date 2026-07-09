import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/di/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/usecases/clear_saved_game_use_case.dart';

part 'clear_saved_game_use_case_provider.g.dart';

@riverpod
ClearSavedGameUseCase clearSavedGameUseCase(Ref ref) {
  return ClearSavedGameUseCase(
    repository: ref.watch(gameRepositoryProvider),
  );
}
