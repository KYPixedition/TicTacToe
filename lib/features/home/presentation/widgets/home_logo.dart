import 'package:flutter/material.dart';

import 'package:tictactoe/core/constants/app_assets.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';

/// Home screen logo displayed instead of the title text.
class HomeLogo extends StatelessWidget {
  const HomeLogo({required this.semanticsLabel, super.key});

  final String semanticsLabel;

  static const double _maxHeight = 260;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: _maxHeight),
      child: Semantics(
        label: semanticsLabel,
        image: true,
        child: Image.asset(
          AppAssets.homeLogo,
          width: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Text(
              semanticsLabel,
              style: context.typos.title.copyWith(
                color: context.colors.logoBorder,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}
