import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/app_button.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

/// Dialog asking the player to choose a CPU difficulty before a new game.
class DifficultySelectionDialog extends StatelessWidget {
  const DifficultySelectionDialog({super.key});

  /// Shows the difficulty selection dialog.
  static Future<Difficulty?> show(BuildContext context) {
    return showDialog<Difficulty>(
      context: context,
      builder: (context) => const DifficultySelectionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spacings = context.spacings;

    return AlertDialog(
      title: Text(
        l10n?.difficultySelectionTitle ?? '',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton.primary(
            onPressed: () => Navigator.of(context).pop(Difficulty.easy),
            label: l10n?.difficultyEasy ?? '',
            icon: Icons.sentiment_satisfied_alt_rounded,
            minWidth: AppButton.defaultMinWidth,
          ),
          spacings.gapVerticalM,
          AppButton.primary(
            onPressed: () => Navigator.of(context).pop(Difficulty.medium),
            label: l10n?.difficultyMedium ?? '',
            icon: Icons.psychology_alt_rounded,
            minWidth: AppButton.defaultMinWidth,
          ),
          spacings.gapVerticalM,
          AppButton.primary(
            onPressed: () => Navigator.of(context).pop(Difficulty.hard),
            label: l10n?.difficultyHard ?? '',
            icon: Icons.smart_toy_rounded,
            minWidth: AppButton.defaultMinWidth,
          ),
        ],
      ),
    );
  }
}
