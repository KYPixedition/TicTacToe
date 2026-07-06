import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/di/game_navigation_provider.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/navigation/game_navigation.dart';
import 'package:tictactoe/features/game/presentation/game_view.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_cell.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

class MockGameNavigation extends Mock implements GameNavigation {}

void main() {
  Widget buildTestApp({required Widget home}) {
    return ProviderScope(
      child: MaterialApp(
        theme: buildAppTheme(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );
  }

  testWidgets('shows back button and empty board for a new game', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryMode: GameEntryMode.newGame)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Menu principal'), findsOneWidget);
    expect(find.byType(BoardCell), findsNWidgets(9));
    expect(find.text('X'), findsNothing);
    expect(find.text('O'), findsNothing);
  });

  testWidgets('calls GameNavigation when back button is tapped', (tester) async {
    final mockNavigation = MockGameNavigation();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gameNavigationProvider.overrideWithValue(mockNavigation),
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
          home: const GameView(entryMode: GameEntryMode.newGame),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Menu principal'));
    await tester.pumpAndSettle();

    verify(mockNavigation.goHome()).called(1);
  });

  testWidgets('shows resume placeholder when entry mode is resume', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryMode: GameEntryMode.resume)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Reprise de partie'), findsOneWidget);
    expect(find.byType(BoardCell), findsNothing);
  });
}
