import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/navigation/app_route_observer.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/navigation/game_routes.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/di/home_navigation_provider.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';
import 'package:tictactoe/features/home/navigation/home_navigation.dart';
import 'package:tictactoe/features/home/navigation/home_routes.dart';
import 'package:tictactoe/features/home/presentation/home_view.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

import '../../../fakes/fake_game_repository.dart';

final class _FakeHomeNavigation implements HomeNavigation {
  Difficulty? openedDifficulty;
  int resumeCalls = 0;

  @override
  void openNewGame({required Difficulty difficulty}) {
    openedDifficulty = difficulty;
  }

  @override
  void openResumeGame() {
    resumeCalls++;
  }
}

void main() {
  Widget buildTestApp({
    required bool hasSavedGame,
    HomeNavigation? navigation,
  }) {
    final repository = FakeGameRepository()..hasSavedGame = hasSavedGame;

    return ProviderScope(
      overrides: [
        hasSavedGameUseCaseProvider.overrideWithValue(
          HasSavedGameUseCase(repository: repository),
        ),
        if (navigation != null)
          homeNavigationProvider.overrideWithValue(navigation),
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

  testWidgets(
    'shows new game button immediately without resume on first frame',
    (tester) async {
      await tester.pumpWidget(buildTestApp(hasSavedGame: true));

      expect(find.text('Nouvelle partie'), findsOneWidget);
      expect(find.text('Reprendre la partie'), findsNothing);
    },
  );

  testWidgets('hides resume button when no saved game', (tester) async {
    await tester.pumpWidget(buildTestApp(hasSavedGame: false));
    await tester.pumpAndSettle();

    expect(find.text('Nouvelle partie'), findsOneWidget);
    expect(find.text('Reprendre la partie'), findsNothing);
  });

  testWidgets('shows resume button when saved game exists', (tester) async {
    await tester.pumpWidget(buildTestApp(hasSavedGame: true));
    await tester.pumpAndSettle();

    expect(find.text('Nouvelle partie'), findsOneWidget);
    expect(find.text('Reprendre la partie'), findsOneWidget);

    final resumeButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Reprendre la partie'),
    );
    expect(resumeButton.onPressed, isNotNull);
  });

  testWidgets('opens difficulty dialog before starting a new game', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestApp(hasSavedGame: false));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nouvelle partie'));
    await tester.pumpAndSettle();

    expect(find.text('Niveau'), findsOneWidget);
    expect(find.text('Facile'), findsOneWidget);
    expect(find.text('Moyen'), findsOneWidget);
    expect(find.text('Difficile'), findsOneWidget);
  });

  testWidgets('starts a new game with selected difficulty', (tester) async {
    final navigation = _FakeHomeNavigation();

    await tester.pumpWidget(
      buildTestApp(hasSavedGame: false, navigation: navigation),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nouvelle partie'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Difficile'));
    await tester.pumpAndSettle();

    expect(navigation.openedDifficulty, Difficulty.hard);
    expect(find.text('Niveau'), findsNothing);
  });

  testWidgets('dismisses difficulty dialog without starting a game', (
    tester,
  ) async {
    final navigation = _FakeHomeNavigation();

    await tester.pumpWidget(
      buildTestApp(hasSavedGame: false, navigation: navigation),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nouvelle partie'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(navigation.openedDifficulty, isNull);
    expect(find.text('Niveau'), findsNothing);
  });

  testWidgets('hides resume after pop when saved game was cleared', (
    tester,
  ) async {
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
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Game screen'))),
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

    expect(find.text('Reprendre la partie'), findsOneWidget);

    router.push(GameRoutes.path);
    await tester.pumpAndSettle();
    expect(find.text('Game screen'), findsOneWidget);

    repository.hasSavedGame = false;
    router.pop();
    await tester.pumpAndSettle();

    expect(find.text('Reprendre la partie'), findsNothing);
  });
}
