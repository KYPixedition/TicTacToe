import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import '../../../fakes/fake_game_repository.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';
import 'package:tictactoe/features/home/presentation/home_view.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

void main() {
  Widget buildTestApp({required bool hasSavedGame}) {
    final repository = FakeGameRepository()..hasSavedGame = hasSavedGame;

    return ProviderScope(
      overrides: [
        hasSavedGameUseCaseProvider.overrideWithValue(HasSavedGameUseCase(repository: repository)),
      ],
      child: MaterialApp(
        theme: buildAppTheme(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeView(),
      ),
    );
  }

  testWidgets('shows both buttons immediately with resume disabled on first frame', (tester) async {
    await tester.pumpWidget(buildTestApp(hasSavedGame: true));

    expect(find.text('Nouvelle partie'), findsOneWidget);
    expect(find.text('Reprendre la partie'), findsOneWidget);

    final resumeButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Reprendre la partie'),
    );
    expect(resumeButton.onPressed, isNull);
  });

  testWidgets('shows both buttons with resume disabled when no saved game', (tester) async {
    await tester.pumpWidget(buildTestApp(hasSavedGame: false));
    await tester.pumpAndSettle();

    expect(find.text('Nouvelle partie'), findsOneWidget);
    expect(find.text('Reprendre la partie'), findsOneWidget);

    final resumeButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Reprendre la partie'),
    );
    expect(resumeButton.onPressed, isNull);
  });

  testWidgets('enables resume button when saved game exists', (tester) async {
    await tester.pumpWidget(buildTestApp(hasSavedGame: true));
    await tester.pumpAndSettle();

    final resumeButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Reprendre la partie'),
    );
    expect(resumeButton.onPressed, isNotNull);
  });
}
