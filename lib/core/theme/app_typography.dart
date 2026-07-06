import 'package:flutter/material.dart';

/// Typography tokens for the TicTacToe application.
final class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.title,
    required this.body,
    required this.button,
    required this.cellMark,
  });

  final TextStyle title;
  final TextStyle body;
  final TextStyle button;
  final TextStyle cellMark;

  static const AppTypography light = AppTypography(
    title: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    body: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    button: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    cellMark: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  );

  @override
  AppTypography copyWith({
    TextStyle? title,
    TextStyle? body,
    TextStyle? button,
    TextStyle? cellMark,
  }) {
    return AppTypography(
      title: title ?? this.title,
      body: body ?? this.body,
      button: button ?? this.button,
      cellMark: cellMark ?? this.cellMark,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }

    return AppTypography(
      title: TextStyle.lerp(title, other.title, t) ?? title,
      body: TextStyle.lerp(body, other.body, t) ?? body,
      button: TextStyle.lerp(button, other.button, t) ?? button,
      cellMark: TextStyle.lerp(cellMark, other.cellMark, t) ?? cellMark,
    );
  }
}
