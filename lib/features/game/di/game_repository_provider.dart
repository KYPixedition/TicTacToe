import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/providers/talker_provider.dart';
import 'package:tictactoe/features/game/data/repositories/local_game_repository.dart';
import 'package:tictactoe/features/game/di/game_local_data_source_provider.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';

part 'game_repository_provider.g.dart';

@riverpod
GameRepository gameRepository(Ref ref) {
  return LocalGameRepository(
    dataSource: ref.watch(gameLocalDataSourceProvider),
    talker: ref.watch(talkerProvider),
  );
}
