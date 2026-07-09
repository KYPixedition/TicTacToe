import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/di/game_navigation_provider.dart';
import 'package:tictactoe/features/game/di/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_intent.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/navigation/game_navigation.dart';
import 'package:tictactoe/features/game/presentation/game_view.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_state.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_cell.dart';
import 'package:tictactoe/l10n/app_localizations.dart';
import '../../../fakes/fake_game_repository.dart';

class MockGameNavigation extends Mock implements GameNavigation {}

const GameEntryIntent _newGameIntent = GameEntryIntent.newGame(
  difficulty: Difficulty.easy,
);
const GameEntryIntent _resumeIntent = GameEntryIntent.resume();

int boardCellCount(WidgetTester tester, Player? player) {
  return tester
      .widgetList<BoardCell>(find.byType(BoardCell))
      .where((cell) => cell.player == player)
      .length;
}

void main() {
  late FakeGameRepository fakeGameRepository;

  setUp(() {
    fakeGameRepository = FakeGameRepository();
  });

  Widget buildTestApp({required Widget home, GameNavigation? navigation}) {
    return ProviderScope(
      overrides: [
        gameRepositoryProvider.overrideWithValue(fakeGameRepository),
        if (navigation != null)
          gameNavigationProvider.overrideWithValue(navigation),
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
        home: home,
      ),
    );
  }

  Future<void> pumpGameViewWithState(
    WidgetTester tester, {
    required GameState gameState,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gameRepositoryProvider.overrideWithValue(fakeGameRepository),
          gameNotifierProvider(_newGameIntent).overrideWithValue(gameState),
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
          home: const GameView(entryIntent: _newGameIntent),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows back button and empty board for a new game', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Menu principal'), findsOneWidget);
    expect(find.text('À votre tour'), findsOneWidget);
    expect(find.text('Joueur'), findsOneWidget);
    expect(find.text('Bot AI'), findsOneWidget);
    expect(find.byType(BoardCell), findsNWidgets(9));
    expect(boardCellCount(tester, Player.x), 0);
    expect(boardCellCount(tester, Player.o), 0);
  });

  testWidgets('calls GameNavigation when back button is tapped', (
    tester,
  ) async {
    final mockNavigation = MockGameNavigation();

    await tester.pumpWidget(
      buildTestApp(
        home: const GameView(entryIntent: _newGameIntent),
        navigation: mockNavigation,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Menu principal'));
    await tester.pumpAndSettle();

    verify(mockNavigation.goHome()).called(1);
  });

  testWidgets('shows player mark when tapping an empty cell', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(boardCellCount(tester, Player.x), 1);
  });

  testWidgets('does not change board when tapping an occupied cell', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(boardCellCount(tester, Player.x), 1);

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(boardCellCount(tester, Player.x), 1);
    expect(boardCellCount(tester, Player.o), 1);
  });

  testWidgets('shows cpu thinking label after player move', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text("L'ordinateur réfléchit…"), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(boardCellCount(tester, Player.x), 1);
    expect(boardCellCount(tester, Player.o), 1);
    expect(find.text('À votre tour'), findsOneWidget);
  });

  testWidgets('ignores board taps while cpu is thinking', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pump();
    // Keep the test inside the CPU thinking window before the delayed CPU move runs.
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byType(BoardCell).at(1), warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(boardCellCount(tester, Player.x), 1);
    expect(boardCellCount(tester, Player.o), 1);
    expect(find.text('À votre tour'), findsOneWidget);
  });

  testWidgets('shows player won label after human wins', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byType(BoardCell).at(4));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byType(BoardCell).at(8));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Victoire du joueur'), findsOneWidget);
  });

  testWidgets('shows play again button after human wins', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byType(BoardCell).at(4));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byType(BoardCell).at(8));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Rejouer'), findsOneWidget);
    expect(find.text('Menu principal'), findsOneWidget);
  });

  testWidgets('ignores board taps after game is finished', (tester) async {
    final finishedGame = Game(
      board: <Player?>[
        Player.x,
        Player.x,
        Player.x,
        Player.o,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.won,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );
    fakeGameRepository.savedGame = finishedGame;

    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _resumeIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(6), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(boardCellCount(tester, Player.x), 3);
    expect(boardCellCount(tester, Player.o), 2);
    expect(fakeGameRepository.savedGame, finishedGame);
    expect(find.text('Victoire du joueur'), findsOneWidget);
  });

  testWidgets('shows play again button after draw', (tester) async {
    await pumpGameViewWithState(
      tester,
      gameState: GameState(
        game: Game(
          board: <Player?>[
            Player.x,
            Player.o,
            Player.x,
            Player.x,
            Player.o,
            Player.o,
            Player.o,
            Player.x,
            Player.o,
          ],
          status: GameStatus.draw,
          currentPlayer: Player.x,
          difficulty: Difficulty.easy,
        ),
      ),
    );

    expect(find.text('Égalité'), findsOneWidget);
    expect(find.text('Rejouer'), findsOneWidget);
  });

  testWidgets('shows play again button after cpu wins', (tester) async {
    await pumpGameViewWithState(
      tester,
      gameState: GameState(
        game: Game(
          board: <Player?>[
            Player.x,
            Player.o,
            Player.x,
            Player.x,
            Player.o,
            Player.x,
            Player.o,
            Player.o,
            Player.o,
          ],
          status: GameStatus.won,
          currentPlayer: Player.o,
          difficulty: Difficulty.easy,
        ),
      ),
    );

    expect(find.text("Victoire de l'ordinateur"), findsOneWidget);
    expect(find.text('Rejouer'), findsOneWidget);
  });

  testWidgets('hides play again button while game is playing', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    final Visibility playAgainVisibility = tester.widget<Visibility>(
      find.ancestor(
        of: find.text('Rejouer'),
        matching: find.byType(Visibility),
      ),
    );

    expect(playAgainVisibility.visible, isFalse);
    expect(playAgainVisibility.maintainSize, isTrue);
  });

  testWidgets('play again resets the board', (tester) async {
    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _newGameIntent)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BoardCell).at(0));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byType(BoardCell).at(4));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byType(BoardCell).at(8));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Rejouer'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('À votre tour'), findsOneWidget);
    expect(boardCellCount(tester, Player.x), 0);
    expect(boardCellCount(tester, Player.o), 1);
  });

  testWidgets('shows restored board when entry mode is resume', (tester) async {
    fakeGameRepository.savedGame = Game(
      board: <Player?>[
        Player.x,
        null,
        null,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    );

    await tester.pumpWidget(
      buildTestApp(home: const GameView(entryIntent: _resumeIntent)),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BoardCell), findsNWidgets(9));
    expect(boardCellCount(tester, Player.x), 1);
    expect(boardCellCount(tester, Player.o), 1);
  });

  testWidgets('navigates home in resume mode when save is missing', (
    tester,
  ) async {
    fakeGameRepository.savedGame = null;
    final mockNavigation = MockGameNavigation();

    await tester.pumpWidget(
      buildTestApp(
        home: const GameView(entryIntent: _resumeIntent),
        navigation: mockNavigation,
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    verify(mockNavigation.goHome()).called(1);
  });
}
