import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/app_button.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

class DifficultySelectionDialog extends StatelessWidget {
  const DifficultySelectionDialog({super.key});

  static const double _borderWidth = 4;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final spacings = context.spacings;
    final radii = context.radii;
    final typos = context.typos;

    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.all(spacings.l),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colors.homeBackgroundStart, colors.homeBackgroundEnd],
              ),
              borderRadius: radii.borderL,
              border: Border.all(color: colors.logoBorder, width: _borderWidth),
              boxShadow: context.shadows.card,
            ),
            padding: spacings.paddingL,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.difficultySelectionTitle,
                  textAlign: TextAlign.center,
                  style: typos.title.copyWith(color: colors.logoBorder),
                ),
                spacings.gapVerticalL,
                AppButton.primary(
                  onPressed: () => Navigator.of(context).pop(Difficulty.easy),
                  label: l10n.difficultyEasy,
                  minWidth: AppButton.defaultMinWidth,
                ),
                spacings.gapVerticalM,
                AppButton.secondary(
                  onPressed: () => Navigator.of(context).pop(Difficulty.medium),
                  label: l10n.difficultyMedium,
                  minWidth: AppButton.defaultMinWidth,
                ),
                spacings.gapVerticalM,
                AppButton.tertiary(
                  onPressed: () => Navigator.of(context).pop(Difficulty.hard),
                  label: l10n.difficultyHard,
                  minWidth: AppButton.defaultMinWidth,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
