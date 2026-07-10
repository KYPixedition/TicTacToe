import 'package:flutter/material.dart';

/// Semantic reusable shadows (cards, toolbars, overlays, buttons).
final class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows({
    required this.card,
    required this.toolbar,
    required this.overlay,
    required this.button,
    required this.boardCell,
  });

  static const AppShadows standard = AppShadows(
    card: [
      BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
    ],
    toolbar: [
      BoxShadow(
        color: Color(0x14000000),
        blurRadius: 12,
        offset: Offset(0, -4),
      ),
    ],
    overlay: [
      BoxShadow(color: Color(0x66000000), blurRadius: 4, offset: Offset(0, 1)),
    ],
    button: [
      BoxShadow(color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 4)),
      BoxShadow(color: Color(0x1F000000), blurRadius: 2, offset: Offset(0, 1)),
    ],
    boardCell: [
      BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2)),
      BoxShadow(color: Color(0x0D000000), blurRadius: 1, offset: Offset(0, 1)),
    ],
  );

  static const double _winningGlowOuterAlpha = 0.62;
  static const double _winningGlowInnerAlpha = 0.36;
  static const double _winningGlowOuterBlur = 14;
  static const double _winningGlowInnerBlur = 8;
  static const double _winningGlowOuterSpread = 2;

  final List<BoxShadow> card;
  final List<BoxShadow> toolbar;
  final List<BoxShadow> overlay;
  final List<BoxShadow> button;
  final List<BoxShadow> boardCell;

  /// Soft glow for highlighted board cells, player cards and status banner.
  static List<BoxShadow> boardCellWinningGlow(Color glowColor) {
    return [
      BoxShadow(
        color: glowColor.withValues(alpha: _winningGlowOuterAlpha),
        blurRadius: _winningGlowOuterBlur,
        spreadRadius: _winningGlowOuterSpread,
      ),
      BoxShadow(
        color: glowColor.withValues(alpha: _winningGlowInnerAlpha),
        blurRadius: _winningGlowInnerBlur,
      ),
    ];
  }

  @override
  AppShadows copyWith({
    List<BoxShadow>? card,
    List<BoxShadow>? toolbar,
    List<BoxShadow>? overlay,
    List<BoxShadow>? button,
    List<BoxShadow>? boardCell,
  }) {
    return AppShadows(
      card: card ?? this.card,
      toolbar: toolbar ?? this.toolbar,
      overlay: overlay ?? this.overlay,
      button: button ?? this.button,
      boardCell: boardCell ?? this.boardCell,
    );
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) {
      return this;
    }

    return AppShadows(
      card: _lerpShadowList(card, other.card, t),
      toolbar: _lerpShadowList(toolbar, other.toolbar, t),
      overlay: _lerpShadowList(overlay, other.overlay, t),
      button: _lerpShadowList(button, other.button, t),
      boardCell: _lerpShadowList(boardCell, other.boardCell, t),
    );
  }

  static List<BoxShadow> _lerpShadowList(
    List<BoxShadow> a,
    List<BoxShadow> b,
    double t,
  ) {
    if (a.length != b.length) {
      return t < 0.5 ? a : b;
    }

    return List<BoxShadow>.generate(
      a.length,
      (index) => BoxShadow.lerp(a[index], b[index], t) ?? a[index],
    );
  }
}
