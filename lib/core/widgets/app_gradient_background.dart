import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';

/// Shared vertical gradient background used across app screens.
class AppGradientBackground extends StatelessWidget {
  const AppGradientBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.homeBackgroundStart, colors.homeBackgroundEnd],
        ),
      ),
      child: child,
    );
  }
}
