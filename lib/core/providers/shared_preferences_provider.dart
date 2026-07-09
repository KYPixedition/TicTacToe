import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tictactoe/core/providers/app_startup_provider.dart';

part 'shared_preferences_provider.g.dart';

@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  return ref.watch(appStartupProvider).requireValue;
}
