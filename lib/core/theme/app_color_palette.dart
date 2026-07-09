import 'package:flutter/material.dart';

/// Semantic color palette for the TicTacToe application.
final class AppColorPalette extends ThemeExtension<AppColorPalette> {
  const AppColorPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.logoBorder,
    required this.surface,
    required this.onSurface,
    required this.homeBackgroundStart,
    required this.homeBackgroundEnd,
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
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;
  final Color logoBorder;
  final Color surface;
  final Color onSurface;
  final Color homeBackgroundStart;
  final Color homeBackgroundEnd;
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
    primary: Color(0xFF64B5AD),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFFDB851),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFFE8938F),
    onTertiary: Color(0xFFFFFFFF),
    logoBorder: Color(0xFF4A4891),
    surface: Color(0xFFE8E5F5),
    onSurface: Color(0xFF212121),
    homeBackgroundStart: Color(0xFFD0CEE8),
    homeBackgroundEnd: Color(0xFF72709A),
    buttonDisabledBackground: Color(0xFFBDBDBD),
    buttonDisabledForeground: Color(0xFF757575),
    buttonSecondaryBackground: Color(0xFFFDB851),
    buttonSecondaryForeground: Color(0xFFFFFFFF),
    buttonSecondaryBorder: Color(0xFFFDB851),
    boardCellBorder: Color(0xFF9E9E9E),
    boardCellBackground: Color(0xFFFFFFFF),
    playerX: Color(0xFF64B5AD),
    playerO: Color(0xFFF17D52),
    gameStatusPlaying: Color(0xFF64B5AD),
  );

  @override
  AppColorPalette copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? tertiary,
    Color? onTertiary,
    Color? logoBorder,
    Color? surface,
    Color? onSurface,
    Color? homeBackgroundStart,
    Color? homeBackgroundEnd,
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
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      logoBorder: logoBorder ?? this.logoBorder,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      homeBackgroundStart: homeBackgroundStart ?? this.homeBackgroundStart,
      homeBackgroundEnd: homeBackgroundEnd ?? this.homeBackgroundEnd,
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
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t) ?? onSecondary,
      tertiary: Color.lerp(tertiary, other.tertiary, t) ?? tertiary,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t) ?? onTertiary,
      logoBorder: Color.lerp(logoBorder, other.logoBorder, t) ?? logoBorder,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      homeBackgroundStart:
          Color.lerp(homeBackgroundStart, other.homeBackgroundStart, t) ??
          homeBackgroundStart,
      homeBackgroundEnd:
          Color.lerp(homeBackgroundEnd, other.homeBackgroundEnd, t) ??
          homeBackgroundEnd,
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
