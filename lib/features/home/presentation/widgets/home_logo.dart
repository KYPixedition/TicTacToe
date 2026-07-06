import 'package:flutter/material.dart';
import 'package:tictactoe/core/constants/app_assets.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';

/// Home screen logo displayed instead of the title text.
class HomeLogo extends StatelessWidget {
  const HomeLogo({
    required this.semanticsLabel,
    super.key,
  });

  final String semanticsLabel;

  static const double _widthFactor = 0.8;

  @override
  Widget build(BuildContext context) {
    final spacings = context.spacings;

    return Center(
      child: FractionallySizedBox(
        widthFactor: _widthFactor,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: spacings.huge),
          child: Semantics(
            label: semanticsLabel,
            image: true,
            child: Image.asset(
              AppAssets.homeLogo,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  semanticsLabel,
                  style: context.typos.title.copyWith(color: context.colors.primary),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
