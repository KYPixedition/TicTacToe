import 'package:flutter/material.dart';
import 'package:tictactoe/core/theme/app_color_palette.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/shadowed_container.dart';

enum AppButtonVariant { primary, secondary }

/// Themed action button with primary and secondary visual variants.
class AppButton extends StatelessWidget {
  const AppButton._({
    super.key,
    required this.variant,
    required this.onPressed,
    this.size = 48,
    this.borderRadius,
    this.icon,
    this.label,
    this.minWidth,
  });

  /// Filled button with brand background and contrasting label.
  const AppButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    IconData? icon,
    String? label,
    double size = 48,
    double? borderRadius,
    double? minWidth,
  }) : this._(
         key: key,
         variant: AppButtonVariant.primary,
         onPressed: onPressed,
         icon: icon,
         label: label,
         size: size,
         borderRadius: borderRadius,
         minWidth: minWidth,
       );

  /// Outlined button with light background, brand label and border.
  const AppButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    IconData? icon,
    String? label,
    double size = 48,
    double? borderRadius,
    double? minWidth,
  }) : this._(
         key: key,
         variant: AppButtonVariant.secondary,
         onPressed: onPressed,
         icon: icon,
         label: label,
         size: size,
         borderRadius: borderRadius,
         minWidth: minWidth,
       );

  static const double defaultMinWidth = 240;

  final AppButtonVariant variant;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? label;
  final double size;
  final double? minWidth;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final spacings = context.spacings;
    final radii = context.radii;
    final shadows = context.shadows;
    final colors = context.colors;
    final isDisabled = onPressed == null;
    final style = _resolveStyle(
      colors: colors,
      variant: variant,
      isDisabled: isDisabled,
    );
    final customRadius = borderRadius;
    final BorderRadius resolvedBorderRadius = customRadius != null
        ? BorderRadius.circular(customRadius)
        : radii.borderRound;
    final shape = RoundedRectangleBorder(
      borderRadius: resolvedBorderRadius,
      side: style.borderSide,
    );
    final hasLabel = label != null;
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: style.backgroundColor,
      foregroundColor: style.foregroundColor,
      disabledBackgroundColor: style.backgroundColor,
      disabledForegroundColor: style.foregroundColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: shape,
      padding: hasLabel ? spacings.paddingButton : EdgeInsets.zero,
      minimumSize: Size(0, size),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final currentLabel = label;
    final currentIcon = icon;
    final Widget button;
    if (currentLabel != null) {
      final resolvedMinWidth = minWidth ?? size;
      button = SizedBox(
        width: resolvedMinWidth,
        child: ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  currentLabel,
                  style: context.typos.button,
                  textAlign: TextAlign.center,
                ),
              ),
              if (currentIcon != null) Icon(currentIcon, size: size * 0.4),
            ],
          ),
        ),
      );
    } else {
      button = SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: currentIcon != null
              ? Icon(currentIcon, size: size * 0.45)
              : const SizedBox.shrink(),
        ),
      );
    }

    if (variant == AppButtonVariant.primary) {
      return ShadowedContainer(
        borderRadius: resolvedBorderRadius,
        boxShadow: shadows.button,
        child: button,
      );
    }

    return button;
  }

  static _AppButtonStyle _resolveStyle({
    required AppColorPalette colors,
    required AppButtonVariant variant,
    required bool isDisabled,
  }) {
    if (isDisabled) {
      return _AppButtonStyle(
        backgroundColor: colors.buttonDisabledBackground,
        foregroundColor: colors.buttonDisabledForeground,
        borderSide: variant == AppButtonVariant.secondary
            ? BorderSide(color: colors.buttonDisabledForeground)
            : BorderSide.none,
      );
    }

    return switch (variant) {
      AppButtonVariant.primary => _AppButtonStyle(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      AppButtonVariant.secondary => _AppButtonStyle(
        backgroundColor: colors.buttonSecondaryBackground,
        foregroundColor: colors.buttonSecondaryForeground,
        borderSide: BorderSide(color: colors.buttonSecondaryBorder),
      ),
    };
  }
}

final class _AppButtonStyle {
  const _AppButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderSide = BorderSide.none,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide borderSide;
}
