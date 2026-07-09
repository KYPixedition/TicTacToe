import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_o.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_x.dart';
import 'package:tictactoe/features/game/presentation/widgets/player_turn_row.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

void main() {
  testWidgets('shows X mark, human label, cpu label and O mark', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              child: PlayerTurnRow(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BoardMarkX), findsOneWidget);
    expect(find.byType(BoardMarkO), findsOneWidget);
    expect(find.text('Joueur'), findsOneWidget);
    expect(find.text('Bot AI'), findsOneWidget);
  });

  testWidgets('shows player marks at icon size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: Center(child: PlayerTurnRow()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Finder humanMarkHost = find.ancestor(
      of: find.byType(BoardMarkX),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox &&
            widget.width == PlayerTurnRow.playerIconSize &&
            widget.height == PlayerTurnRow.playerIconSize,
      ),
    );

    expect(tester.getSize(humanMarkHost), const Size(32, 32));
  });

  testWidgets('uses larger white labels on the app bar row', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: Center(child: PlayerTurnRow()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Text humanLabel = tester.widget<Text>(find.text('Joueur'));
    final Text cpuLabel = tester.widget<Text>(find.text('Bot AI'));

    expect(humanLabel.style?.color, AppColorPalette.light.onPrimary);
    expect(humanLabel.style?.fontSize, 20);
    expect(cpuLabel.style?.color, AppColorPalette.light.onPrimary);
    expect(cpuLabel.style?.fontSize, 20);
  });
}
