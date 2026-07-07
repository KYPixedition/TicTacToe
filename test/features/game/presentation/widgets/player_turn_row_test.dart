import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/player_turn_row.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

void main() {
  Widget buildTestWidget({
    required Player currentPlayer,
    required GameStatus status,
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
        body: PlayerTurnRow(
          currentPlayer: currentPlayer,
          status: status,
        ),
      ),
    );
  }

  Future<BoxDecoration> humanCellDecoration(WidgetTester tester) async {
    final humanIcon = find.byIcon(Icons.person);
    final decoratedBox = find.ancestor(
      of: humanIcon,
      matching: find.byType(DecoratedBox),
    );
    final widget = tester.widget<DecoratedBox>(decoratedBox);
    return widget.decoration as BoxDecoration;
  }

  Future<BoxDecoration> cpuCellDecoration(WidgetTester tester) async {
    final cpuIcon = find.byIcon(Icons.smart_toy);
    final decoratedBox = find.ancestor(
      of: cpuIcon,
      matching: find.byType(DecoratedBox),
    );
    final widget = tester.widget<DecoratedBox>(decoratedBox);
    return widget.decoration as BoxDecoration;
  }

  testWidgets('highlights human player when it is their turn', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        currentPlayer: Player.x,
        status: GameStatus.playing,
      ),
    );
    await tester.pumpAndSettle();

    final humanDecoration = await humanCellDecoration(tester);
    final cpuDecoration = await cpuCellDecoration(tester);

    expect((humanDecoration.border as Border).top.width, 2);
    expect((cpuDecoration.border as Border).top.width, 1);
  });

  testWidgets('highlights cpu player when it is their turn', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        currentPlayer: Player.o,
        status: GameStatus.playing,
      ),
    );
    await tester.pumpAndSettle();

    final humanDecoration = await humanCellDecoration(tester);
    final cpuDecoration = await cpuCellDecoration(tester);

    expect((humanDecoration.border as Border).top.width, 1);
    expect((cpuDecoration.border as Border).top.width, 2);
    expect(
      (cpuDecoration.border as Border).top.color,
      AppColorPalette.light.playerO,
    );
  });

  testWidgets('shows no active border when game is won', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        currentPlayer: Player.x,
        status: GameStatus.won,
      ),
    );
    await tester.pumpAndSettle();

    final humanDecoration = await humanCellDecoration(tester);
    final cpuDecoration = await cpuCellDecoration(tester);

    expect((humanDecoration.border as Border).top.width, 1);
    expect((cpuDecoration.border as Border).top.width, 1);
  });

  testWidgets('shows no active border when game is draw', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        currentPlayer: Player.o,
        status: GameStatus.draw,
      ),
    );
    await tester.pumpAndSettle();

    final humanDecoration = await humanCellDecoration(tester);
    final cpuDecoration = await cpuCellDecoration(tester);

    expect((humanDecoration.border as Border).top.width, 1);
    expect((cpuDecoration.border as Border).top.width, 1);
  });
}
