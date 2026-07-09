import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_radius.dart';
import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_shadows.dart';
import 'package:tictactoe/core/theme/app_spacings.dart';
import 'package:tictactoe/core/theme/app_typography.dart';

/// Builds the application [ThemeData] with all registered extensions.
ThemeData buildAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColorPalette.light.primary),
    extensions: const [
      AppColorPalette.light,
      AppTypography.light,
      AppSpacings.standard,
      AppRadius.standard,
      AppShadows.standard,
    ],
  );
}
