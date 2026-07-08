import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/navigation/app_route_observer.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import '../../../fakes/fake_game_repository.dart';
import 'package:tictactoe/features/game/navigation/game_routes.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';
import 'package:tictactoe/features/home/navigation/home_routes.dart';
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

  testWidgets('disables resume after pop when saved game was cleared', (tester) async {
    final repository = FakeGameRepository()..hasSavedGame = true;

    final router = GoRouter(
      observers: [appRouteObserver],
      initialLocation: HomeRoutes.path,
      routes: [
        GoRoute(
          path: HomeRoutes.path,
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: GameRoutes.path,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Game screen')),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hasSavedGameUseCaseProvider.overrideWithValue(
            HasSavedGameUseCase(repository: repository),
          ),
        ],
        child: MaterialApp.router(
          theme: buildAppTheme(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    var resumeButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Reprendre la partie'),
    );
    expect(resumeButton.onPressed, isNotNull);

    router.push(GameRoutes.path);
    await tester.pumpAndSettle();
    expect(find.text('Game screen'), findsOneWidget);

    repository.hasSavedGame = false;
    router.pop();
    await tester.pumpAndSettle();

    resumeButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Reprendre la partie'),
    );
    expect(resumeButton.onPressed, isNull);
  });
}
