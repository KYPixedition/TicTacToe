import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/providers/shared_preferences_provider.dart';
import 'package:tictactoe/features/game/data/datasources/game_local_data_source.dart';

part 'game_local_data_source_provider.g.dart';

/// Provides the local game data source.
@riverpod
GameLocalDataSource gameLocalDataSource(Ref ref) {
  return SharedPreferencesGameLocalDataSource(
    preferences: ref.watch(sharedPreferencesProvider),
  );
}
