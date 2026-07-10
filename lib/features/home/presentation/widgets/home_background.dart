import 'package:flutter/material.dart';

import 'package:tictactoe/core/widgets/app_gradient_background.dart';

/// Gradient background for the home screen - light at the top, darker at the bottom.
class HomeBackground extends StatelessWidget {
  const HomeBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(child: child);
  }
}
