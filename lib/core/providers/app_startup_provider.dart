import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_startup_provider.g.dart';

/// Initializes async runtime dependencies before the app widget tree mounts.
@Riverpod(keepAlive: true)
Future<SharedPreferences> appStartup(Ref ref) async {
  return SharedPreferences.getInstance();
}
