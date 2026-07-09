import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tictactoe/core/providers/app_startup_provider.dart';
import 'package:tictactoe/core/providers/shared_preferences_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('appStartupProvider resolves SharedPreferences', () async {
    final container = ProviderContainer.test();

    final preferences = await container.read(appStartupProvider.future);

    expect(preferences, isA<SharedPreferences>());
    addTearDown(container.dispose);
  });

  test('sharedPreferencesProvider returns startup instance after app startup', () async {
    final container = ProviderContainer.test();
    final startupPreferences = await container.read(appStartupProvider.future);

    final preferences = container.read(sharedPreferencesProvider);

    expect(preferences, same(startupPreferences));
    addTearDown(container.dispose);
  });

  test('sharedPreferencesProvider override works without app startup', () async {
    SharedPreferences.setMockInitialValues({'test_key': 'test_value'});
    final mockPreferences = await SharedPreferences.getInstance();

    final container = ProviderContainer.test(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(mockPreferences),
      ],
    );

    expect(container.read(sharedPreferencesProvider), same(mockPreferences));
    addTearDown(container.dispose);
  });
}
