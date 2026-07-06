import 'package:flutter/material.dart';
import 'package:tictactoe/core/theme/app_border_radii.dart';
import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_shadows.dart';
import 'package:tictactoe/core/theme/app_spacings.dart';
import 'package:tictactoe/core/theme/app_typography.dart';

/// Provides typed access to theme extensions from a [BuildContext].
extension AppThemeContextX on BuildContext {
  AppColorPalette get colors =>
      Theme.of(this).extension<AppColorPalette>() ?? AppColorPalette.light;

  AppSpacings get spacings =>
      Theme.of(this).extension<AppSpacings>() ?? AppSpacings.standard;

  AppBorderRadii get radii =>
      Theme.of(this).extension<AppBorderRadii>() ?? AppBorderRadii.standard;

  AppTypography get typos =>
      Theme.of(this).extension<AppTypography>() ?? AppTypography.light;

  AppShadows get shadows =>
      Theme.of(this).extension<AppShadows>() ?? AppShadows.standard;
}
