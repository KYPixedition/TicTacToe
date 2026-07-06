import 'package:flutter/material.dart';
import 'package:tictactoe/l10n/app_localizations.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';

/// Placeholder game screen shown after navigation from home.
class GameView extends StatelessWidget {
  const GameView({
    super.key,
    required this.entryMode,
  });

  final GameEntryMode entryMode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final modeLabel = switch (entryMode) {
      GameEntryMode.newGame => l10n?.gameEntryModeNew ?? '',
      GameEntryMode.resume => l10n?.gameEntryModeResume ?? '',
    };

    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        title: Text(l10n?.gamePlaceholder ?? ''),
      ),
      body: Center(
        child: Text(
          modeLabel,
          style: context.typos.body.copyWith(color: context.colors.onSurface),
        ),
      ),
    );
  }
}
