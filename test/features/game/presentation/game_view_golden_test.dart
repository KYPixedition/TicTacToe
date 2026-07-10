import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/di/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_intent.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/game_view.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_state.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

import '../../../fakes/fake_game_repository.dart';

const GameEntryIntent _newGameIntent = GameEntryIntent.newGame(
  difficulty: Difficulty.easy,
);

const Size _goldenViewportSize = Size(414, 896);

GameState _humanWinEasyGameState() {
  return GameState(
    game: Game(
      board: <Player?>[
        Player.x,
        Player.o,
        Player.o,
        Player.o,
        Player.x,
        null,
        null,
        Player.o,
        Player.x,
      ],
      status: GameStatus.won,
      currentPlayer: Player.x,
      difficulty: Difficulty.easy,
    ),
  );
}

void main() {
  late FakeGameRepository fakeGameRepository;

  setUp(() {
    fakeGameRepository = FakeGameRepository();
  });

  Future<void> pumpHumanWinGameView(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(_goldenViewportSize);
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gameRepositoryProvider.overrideWithValue(fakeGameRepository),
          gameNotifierProvider(_newGameIntent).overrideWithValue(
            _humanWinEasyGameState(),
          ),
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

  testWidgets('matches golden for human win on easy difficulty', (
    tester,
  ) async {
    await pumpHumanWinGameView(tester);

    await expectLater(
      find.byType(GameView),
      matchesGoldenFile('goldens/game_view_human_win_easy.png'),
    );
  });
}
