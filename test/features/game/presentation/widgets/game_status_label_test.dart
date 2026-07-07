import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_status_label.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

void main() {
  Widget buildTestWidget({
    required GameStatus status,
    Player? winner,
    bool isCpuThinking = false,
  }) {
    return MaterialApp(
      theme: buildAppTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GameStatusLabel(
          status: status,
          winner: winner,
          isCpuThinking: isCpuThinking,
        ),
      ),
    );
  }

  testWidgets('shows playing label while game is in progress', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.playing),
    );
    await tester.pumpAndSettle();

    expect(find.text('En cours'), findsOneWidget);
  });

  testWidgets('shows cpu thinking label while cpu is computing', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        status: GameStatus.playing,
        isCpuThinking: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("L'ordinateur réfléchit…"), findsOneWidget);
    expect(find.text('En cours'), findsNothing);
  });

  testWidgets('shows player won label when human wins', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        status: GameStatus.won,
        winner: Player.x,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Victoire du joueur'), findsOneWidget);
  });

  testWidgets('shows cpu won label when cpu wins', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        status: GameStatus.won,
        winner: Player.o,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("Victoire de l'ordinateur"), findsOneWidget);
  });

  testWidgets('shows draw label when game ends in a draw', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.draw),
    );
    await tester.pumpAndSettle();

    expect(find.text('Égalité'), findsOneWidget);
  });

  testWidgets('does not overflow on a narrow screen when cpu wins', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      buildTestWidget(
        status: GameStatus.won,
        winner: Player.o,
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text("Victoire de l'ordinateur"), findsOneWidget);
  });
}
