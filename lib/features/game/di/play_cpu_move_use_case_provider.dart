import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tictactoe/features/game/domain/services/minimax_ai_strategy.dart';
import 'package:tictactoe/features/game/domain/usecases/play_cpu_move_use_case.dart';

part 'play_cpu_move_use_case_provider.g.dart';

@riverpod
PlayCpuMoveUseCase playCpuMoveUseCase(Ref ref) {
  return const PlayCpuMoveUseCase(strategy: MinimaxAiStrategy());
}
