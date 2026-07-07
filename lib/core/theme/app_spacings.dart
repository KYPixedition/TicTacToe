import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Spacing tokens for the TicTacToe application.
final class AppSpacings extends ThemeExtension<AppSpacings> {
  const AppSpacings({
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
    required this.xxl,
    required this.huge,
  });

  final double s;
  final double m;
  final double l;
  final double xl;
  final double xxl;
  final double huge;

  static const AppSpacings standard = AppSpacings(
    s: 8,
    m: 16,
    l: 24,
    xl: 32,
    xxl: 64,
    huge: 200,
  );

  /// Small padding on all sides.
  EdgeInsets get paddingS => EdgeInsets.all(s);

  /// Medium padding on all sides.
  EdgeInsets get paddingM => EdgeInsets.all(m);

  /// Large padding on all sides.
  EdgeInsets get paddingL => EdgeInsets.all(l);

  /// Extra-large padding on all sides.
  EdgeInsets get paddingXl => EdgeInsets.all(xl);

  /// Default padding for labeled buttons (horizontal [m], vertical [s]).
  EdgeInsets get paddingButton =>
      EdgeInsets.symmetric(horizontal: m, vertical: s);

  /// Small vertical gap between widgets in a [Column].
  SizedBox get gapVerticalS => SizedBox(height: s);

  /// Medium vertical gap between widgets in a [Column].
  SizedBox get gapVerticalM => SizedBox(height: m);

  /// Large vertical gap between widgets in a [Column].
  SizedBox get gapVerticalL => SizedBox(height: l);

  /// Extra-large vertical gap between widgets in a [Column].
  SizedBox get gapVerticalXl => SizedBox(height: xl);

  /// Double extra-large vertical gap between widgets in a [Column].
  SizedBox get gapVerticalXxl => SizedBox(height: xxl);

  /// Huge vertical gap between widgets in a [Column].
  SizedBox get gapVerticalHuge => SizedBox(height: huge);

  /// Small horizontal gap between widgets in a [Row].
  SizedBox get gapHorizontalS => SizedBox(width: s);

  /// Medium horizontal gap between widgets in a [Row].
  SizedBox get gapHorizontalM => SizedBox(width: m);

  /// Large horizontal gap between widgets in a [Row].
  SizedBox get gapHorizontalL => SizedBox(width: l);

  /// Extra-large horizontal gap between widgets in a [Row].
  SizedBox get gapHorizontalXl => SizedBox(width: xl);

  /// Double extra-large horizontal gap between widgets in a [Row].
  SizedBox get gapHorizontalXxl => SizedBox(width: xxl);

  /// Returns symmetric padding using the given horizontal and vertical values.
  EdgeInsets symmetric({double? horizontal, double? vertical}) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? m,
      vertical: vertical ?? s,
    );
  }

  @override
  AppSpacings copyWith({
    double? s,
    double? m,
    double? l,
    double? xl,
    double? xxl,
    double? huge,
  }) {
    return AppSpacings(
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      huge: huge ?? this.huge,
    );
  }

  @override
  AppSpacings lerp(ThemeExtension<AppSpacings>? other, double t) {
    if (other is! AppSpacings) {
      return this;
    }

    return AppSpacings(
      s: lerpDouble(s, other.s, t) ?? s,
      m: lerpDouble(m, other.m, t) ?? m,
      l: lerpDouble(l, other.l, t) ?? l,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
      huge: lerpDouble(huge, other.huge, t) ?? huge,
    );
  }
}
