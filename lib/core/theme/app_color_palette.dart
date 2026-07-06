import 'package:flutter/material.dart';

/// Semantic color palette for the TicTacToe application.
final class AppColorPalette extends ThemeExtension<AppColorPalette> {
  const AppColorPalette({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.onSurface,
    required this.buttonDisabledBackground,
    required this.buttonDisabledForeground,
    required this.boardCellBorder,
    required this.boardCellBackground,
    required this.playerX,
    required this.playerO,
    required this.gameStatusPlaying,
    required this.gameStatusFinished,
  });

  final Color primary;
  final Color onPrimary;
  final Color surface;
  final Color onSurface;
  final Color buttonDisabledBackground;
  final Color buttonDisabledForeground;
  final Color boardCellBorder;
  final Color boardCellBackground;
  final Color playerX;
  final Color playerO;
  final Color gameStatusPlaying;
  final Color gameStatusFinished;

  static const AppColorPalette light = AppColorPalette(
    primary: Color(0xFFE53935),
    onPrimary: Color(0xFFFFFFFF),
    surface: Color(0xFFFCE4EC),
    onSurface: Color(0xFF212121),
    buttonDisabledBackground: Color(0xFFBDBDBD),
    buttonDisabledForeground: Color(0xFF757575),
    boardCellBorder: Color(0xFF9E9E9E),
    boardCellBackground: Color(0xFFFFFFFF),
    playerX: Color(0xFFE53935),
    playerO: Color(0xFF1E88E5),
    gameStatusPlaying: Color(0xFFE53935),
    gameStatusFinished: Color(0xFF43A047),
  );

  @override
  AppColorPalette copyWith({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? onSurface,
    Color? buttonDisabledBackground,
    Color? buttonDisabledForeground,
    Color? boardCellBorder,
    Color? boardCellBackground,
    Color? playerX,
    Color? playerO,
    Color? gameStatusPlaying,
    Color? gameStatusFinished,
  }) {
    return AppColorPalette(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      buttonDisabledBackground: buttonDisabledBackground ?? this.buttonDisabledBackground,
      buttonDisabledForeground: buttonDisabledForeground ?? this.buttonDisabledForeground,
      boardCellBorder: boardCellBorder ?? this.boardCellBorder,
      boardCellBackground: boardCellBackground ?? this.boardCellBackground,
      playerX: playerX ?? this.playerX,
      playerO: playerO ?? this.playerO,
      gameStatusPlaying: gameStatusPlaying ?? this.gameStatusPlaying,
      gameStatusFinished: gameStatusFinished ?? this.gameStatusFinished,
    );
  }

  @override
  AppColorPalette lerp(ThemeExtension<AppColorPalette>? other, double t) {
    if (other is! AppColorPalette) {
      return this;
    }

    return AppColorPalette(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      buttonDisabledBackground:
          Color.lerp(buttonDisabledBackground, other.buttonDisabledBackground, t) ??
          buttonDisabledBackground,
      buttonDisabledForeground:
          Color.lerp(buttonDisabledForeground, other.buttonDisabledForeground, t) ??
          buttonDisabledForeground,
      boardCellBorder: Color.lerp(boardCellBorder, other.boardCellBorder, t) ?? boardCellBorder,
      boardCellBackground:
          Color.lerp(boardCellBackground, other.boardCellBackground, t) ?? boardCellBackground,
      playerX: Color.lerp(playerX, other.playerX, t) ?? playerX,
      playerO: Color.lerp(playerO, other.playerO, t) ?? playerO,
      gameStatusPlaying: Color.lerp(gameStatusPlaying, other.gameStatusPlaying, t) ?? gameStatusPlaying,
      gameStatusFinished: Color.lerp(gameStatusFinished, other.gameStatusFinished, t) ?? gameStatusFinished,
    );
  }
}
