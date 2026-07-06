import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

/// Provides the [SharedPreferences] instance injected at bootstrap.
@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Override sharedPreferencesProvider in main()');
}
