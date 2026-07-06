import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Border radius tokens for the TicTacToe application.
final class AppBorderRadii extends ThemeExtension<AppBorderRadii> {
  const AppBorderRadii({
    required this.s,
    required this.m,
    required this.l,
    required this.round,
    required this.cell,
  });

  final double s;
  final double m;
  final double l;
  final double round;
  final double cell;

  static const AppBorderRadii standard = AppBorderRadii(
    s: 4,
    m: 12,
    l: 20,
    round: 999,
    cell: 4,
  );

  /// Small border radius token as [BorderRadius].
  BorderRadius get borderS => BorderRadius.circular(s);

  /// Medium border radius token as [BorderRadius].
  BorderRadius get borderM => BorderRadius.circular(m);

  /// Large border radius token as [BorderRadius].
  BorderRadius get borderL => BorderRadius.circular(l);

  /// Fully rounded (pill) border radius token as [BorderRadius].
  BorderRadius get borderRound => BorderRadius.circular(round);

  /// Board cell border radius token as [BorderRadius].
  BorderRadius get borderCell => BorderRadius.circular(cell);

  @override
  AppBorderRadii copyWith({
    double? s,
    double? m,
    double? l,
    double? round,
    double? cell,
  }) {
    return AppBorderRadii(
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      round: round ?? this.round,
      cell: cell ?? this.cell,
    );
  }

  @override
  AppBorderRadii lerp(ThemeExtension<AppBorderRadii>? other, double t) {
    if (other is! AppBorderRadii) {
      return this;
    }

    return AppBorderRadii(
      s: lerpDouble(s, other.s, t) ?? s,
      m: lerpDouble(m, other.m, t) ?? m,
      l: lerpDouble(l, other.l, t) ?? l,
      round: lerpDouble(round, other.round, t) ?? round,
      cell: lerpDouble(cell, other.cell, t) ?? cell,
    );
  }
}
