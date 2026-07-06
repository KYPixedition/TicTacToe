import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';

/// Local storage key for the persisted game state.
const String gameStateStorageKey = 'game_state';

/// Reads and writes game state from [SharedPreferences].
abstract interface class GameLocalDataSource {
  /// Reads the raw persisted game JSON string, if any.
  Future<Result<String?>> readRawGameState();
}

/// [SharedPreferences] implementation of [GameLocalDataSource].
final class SharedPreferencesGameLocalDataSource
    implements GameLocalDataSource {
  final SharedPreferences _preferences;

  const SharedPreferencesGameLocalDataSource({required this._preferences});

  @override
  Future<Result<String?>> readRawGameState() async {
    try {
      return Result.success(_preferences.getString(gameStateStorageKey));
    } on Object {
      return const Result.failure(StorageReadError());
    }
  }
}
