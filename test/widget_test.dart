import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tictactoe/app/app.dart';
import 'package:tictactoe/core/providers/shared_preferences_provider.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';

import 'fakes/fake_game_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('starts on home screen with action buttons', (tester) async {
    final repository = FakeGameRepository()..hasSavedGame = false;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
          hasSavedGameUseCaseProvider.overrideWithValue(
            HasSavedGameUseCase(repository: repository),
          ),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Tic Tac Toe'), findsOneWidget);
    expect(find.text('Nouvelle partie'), findsOneWidget);
    expect(find.text('Reprendre la partie'), findsOneWidget);
  });
}
