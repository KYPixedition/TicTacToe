import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/di/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/usecases/resume_game_use_case.dart';

part 'resume_game_use_case_provider.g.dart';

@riverpod
ResumeGameUseCase resumeGameUseCase(Ref ref) {
  return ResumeGameUseCase(
    repository: ref.watch(gameRepositoryProvider),
  );
}
