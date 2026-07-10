import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_app_bar.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

void main() {
  testWidgets('uses violet background and embeds player row', (tester) async {
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
          appBar: GameAppBar(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));

    expect(appBar.backgroundColor, AppColorPalette.light.logoBorder);
    expect(find.text('Joueur'), findsOneWidget);
    expect(find.text('Bot AI'), findsOneWidget);
  });
}
