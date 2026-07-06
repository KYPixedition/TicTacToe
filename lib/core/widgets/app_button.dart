import 'package:flutter/material.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/shadowed_container.dart';

/// Primary action button used across the application.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.size = 48,
    this.borderRadius,
    this.icon,
    this.label,
    this.minWidth,
  });

  final VoidCallback? onPressed;
  final IconData? icon;
  final String? label;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;
  final double? minWidth;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final spacings = context.spacings;
    final radii = context.radii;
    final shadows = context.shadows;
    final customRadius = borderRadius;
    final BorderRadius resolvedBorderRadius = customRadius != null
        ? BorderRadius.circular(customRadius)
        : radii.borderRound;
    final shape = RoundedRectangleBorder(borderRadius: resolvedBorderRadius);
    final hasLabel = label != null;
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: backgroundColor,
      disabledForegroundColor: foregroundColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: shape,
      padding: hasLabel ? spacings.paddingButton : EdgeInsets.zero,
      minimumSize: Size(0, size),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final currentLabel = label;
    final currentIcon = icon;
    if (currentLabel != null) {
      final resolvedMinWidth = minWidth ?? size;

      return ShadowedContainer(
        borderRadius: resolvedBorderRadius,
        boxShadow: shadows.button,
        child: SizedBox(
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
        ),
      );
    }

    return ShadowedContainer(
      borderRadius: resolvedBorderRadius,
      boxShadow: shadows.button,
      child: SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: currentIcon != null
              ? Icon(currentIcon, size: size * 0.45)
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
