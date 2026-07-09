import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoe/core/theme/app_radius.dart';
import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme.dart';
import 'package:tictactoe/core/widgets/shadowed_container.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_o.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_mark_x.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_status_label.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

void main() {
  Widget buildTestWidget({
    required GameStatus status,
    Player? winner,
    Player currentPlayer = Player.x,
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
          currentPlayer: currentPlayer,
          isCpuThinking: isCpuThinking,
        ),
      ),
    );
  }

  testWidgets('shows your turn label when human can play', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.playing, currentPlayer: Player.x),
    );
    await tester.pumpAndSettle();

    expect(find.text('À votre tour'), findsOneWidget);
    expect(find.byType(BoardMarkX), findsOneWidget);
  });

  testWidgets('shows playing label when it is cpu turn without thinking', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.playing, currentPlayer: Player.o),
    );
    await tester.pumpAndSettle();

    expect(find.text('En cours'), findsOneWidget);
  });

  testWidgets('shows cpu thinking label while cpu is computing', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.playing, isCpuThinking: true),
    );
    await tester.pumpAndSettle();

    expect(find.text("L'ordinateur réfléchit…"), findsOneWidget);
    expect(find.byType(BoardMarkO), findsOneWidget);
    expect(find.text('À votre tour'), findsNothing);
    expect(find.text('En cours'), findsNothing);
  });

  Future<BoxDecoration> statusBannerDecoration(WidgetTester tester) async {
    final decoratedBoxes = tester.widgetList<DecoratedBox>(
      find.descendant(
        of: find.byType(GameStatusLabel),
        matching: find.byType(DecoratedBox),
      ),
    );

    return decoratedBoxes
        .firstWhere(
          (box) => (box.decoration as BoxDecoration).border != null,
        )
        .decoration as BoxDecoration;
  }

  testWidgets('shows player won label when human wins', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.won, winner: Player.x),
    );
    await tester.pumpAndSettle();

    expect(find.text('Victoire du joueur'), findsOneWidget);
  });

  testWidgets('uses light player background when human wins', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.won, winner: Player.x),
    );
    await tester.pumpAndSettle();

    final decoration = await statusBannerDecoration(tester);
    final expectedBackground = GameStatusLabel.tintedPlayerBackground(
      playerColor: AppColorPalette.light.playerX,
      baseColor: AppColorPalette.light.boardCellBackground,
    );

    expect(decoration.color, expectedBackground);
    expect(
      (decoration.border as Border).top.color,
      AppColorPalette.light.playerX,
    );
  });

  testWidgets('uses compact medium radius banner styling', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.playing, currentPlayer: Player.x),
    );
    await tester.pumpAndSettle();

    final decoration = await statusBannerDecoration(tester);
    final Text label = tester.widget<Text>(find.text('À votre tour'));

    expect(decoration.borderRadius, AppRadius.standard.borderM);
    expect(label.style?.fontSize, 16);
  });

  testWidgets('shows cpu won label when cpu wins', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.won, winner: Player.o),
    );
    await tester.pumpAndSettle();

    expect(find.text("Victoire de l'ordinateur"), findsOneWidget);
  });

  testWidgets('shows draw label when game ends in a draw', (tester) async {
    await tester.pumpWidget(buildTestWidget(status: GameStatus.draw));
    await tester.pumpAndSettle();

    expect(find.text('Égalité'), findsOneWidget);
    expect(find.byType(BoardMarkX), findsOneWidget);
    expect(find.byType(BoardMarkO), findsOneWidget);
  });

  testWidgets('renders nothing when game is won without a winner', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.won, winner: null),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DecoratedBox), findsNothing);
    expect(find.byType(ShadowedContainer), findsNothing);
  });

  testWidgets('does not overflow on a narrow screen when cpu wins', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      buildTestWidget(status: GameStatus.won, winner: Player.o),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text("Victoire de l'ordinateur"), findsOneWidget);
  });
}
