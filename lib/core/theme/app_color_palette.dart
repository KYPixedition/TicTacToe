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
    required this.buttonSecondaryBackground,
    required this.buttonSecondaryForeground,
    required this.buttonSecondaryBorder,
    required this.boardCellBorder,
    required this.boardCellBackground,
    required this.playerX,
    required this.playerO,
    required this.gameStatusPlaying,
  });

  final Color primary;
  final Color onPrimary;
  final Color surface;
  final Color onSurface;
  final Color buttonDisabledBackground;
  final Color buttonDisabledForeground;
  final Color buttonSecondaryBackground;
  final Color buttonSecondaryForeground;
  final Color buttonSecondaryBorder;
  final Color boardCellBorder;
  final Color boardCellBackground;
  final Color playerX;
  final Color playerO;
  final Color gameStatusPlaying;

  static const AppColorPalette light = AppColorPalette(
    primary: Color(0xFFE53935),
    onPrimary: Color(0xFFFFFFFF),
    surface: Color(0xFFFCE4EC),
    onSurface: Color(0xFF212121),
    buttonDisabledBackground: Color(0xFFBDBDBD),
    buttonDisabledForeground: Color(0xFF757575),
    buttonSecondaryBackground: Color(0xFFFFFFFF),
    buttonSecondaryForeground: Color(0xFFE53935),
    buttonSecondaryBorder: Color(0xFFE53935),
    boardCellBorder: Color(0xFF9E9E9E),
    boardCellBackground: Color(0xFFFFFFFF),
    playerX: Color(0xFFE53935),
    playerO: Color(0xFF1E88E5),
    gameStatusPlaying: Color(0xFFE53935),
  );

  @override
  AppColorPalette copyWith({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? onSurface,
    Color? buttonDisabledBackground,
    Color? buttonDisabledForeground,
    Color? buttonSecondaryBackground,
    Color? buttonSecondaryForeground,
    Color? buttonSecondaryBorder,
    Color? boardCellBorder,
    Color? boardCellBackground,
    Color? playerX,
    Color? playerO,
    Color? gameStatusPlaying,
  }) {
    return AppColorPalette(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      buttonDisabledBackground:
          buttonDisabledBackground ?? this.buttonDisabledBackground,
      buttonDisabledForeground:
          buttonDisabledForeground ?? this.buttonDisabledForeground,
      buttonSecondaryBackground:
          buttonSecondaryBackground ?? this.buttonSecondaryBackground,
      buttonSecondaryForeground:
          buttonSecondaryForeground ?? this.buttonSecondaryForeground,
      buttonSecondaryBorder:
          buttonSecondaryBorder ?? this.buttonSecondaryBorder,
      boardCellBorder: boardCellBorder ?? this.boardCellBorder,
      boardCellBackground: boardCellBackground ?? this.boardCellBackground,
      playerX: playerX ?? this.playerX,
      playerO: playerO ?? this.playerO,
      gameStatusPlaying: gameStatusPlaying ?? this.gameStatusPlaying,
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
          Color.lerp(
            buttonDisabledBackground,
            other.buttonDisabledBackground,
            t,
          ) ??
          buttonDisabledBackground,
      buttonDisabledForeground:
          Color.lerp(
            buttonDisabledForeground,
            other.buttonDisabledForeground,
            t,
          ) ??
          buttonDisabledForeground,
      buttonSecondaryBackground:
          Color.lerp(
            buttonSecondaryBackground,
            other.buttonSecondaryBackground,
            t,
          ) ??
          buttonSecondaryBackground,
      buttonSecondaryForeground:
          Color.lerp(
            buttonSecondaryForeground,
            other.buttonSecondaryForeground,
            t,
          ) ??
          buttonSecondaryForeground,
      buttonSecondaryBorder:
          Color.lerp(buttonSecondaryBorder, other.buttonSecondaryBorder, t) ??
          buttonSecondaryBorder,
      boardCellBorder:
          Color.lerp(boardCellBorder, other.boardCellBorder, t) ??
          boardCellBorder,
      boardCellBackground:
          Color.lerp(boardCellBackground, other.boardCellBackground, t) ??
          boardCellBackground,
      playerX: Color.lerp(playerX, other.playerX, t) ?? playerX,
      playerO: Color.lerp(playerO, other.playerO, t) ?? playerO,
      gameStatusPlaying:
          Color.lerp(gameStatusPlaying, other.gameStatusPlaying, t) ??
          gameStatusPlaying,
    );
  }
}
