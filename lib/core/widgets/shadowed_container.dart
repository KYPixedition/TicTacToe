import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';

/// Wraps [child] with a themed box shadow.
class ShadowedContainer extends StatelessWidget {
  const ShadowedContainer({
    required this.borderRadius,
    required this.boxShadow,
    required this.child,
    super.key,
  });

  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacings.s),
      child: Container(
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
