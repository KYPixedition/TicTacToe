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
    required this.boardGridLine,
    required this.boardCellRecessedBackground,
    required this.boardCellRecessedInsetShadow,
    required this.boardCellRecessedInsetHighlight,
    required this.playerX,
    required this.playerXMarkShadow,
    required this.playerXMarkHighlight,
    required this.playerO,
    required this.playerOMarkShadow,
    required this.playerOMarkHighlight,
    required this.gameStatusPlaying,
    required this.playerTurnActiveBorder,
    required this.boardCellWinningGlow,
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
  final Color boardGridLine;
  final Color boardCellRecessedBackground;
  final Color boardCellRecessedInsetShadow;
  final Color boardCellRecessedInsetHighlight;
  final Color playerX;
  final Color playerXMarkShadow;
  final Color playerXMarkHighlight;
  final Color playerO;
  final Color playerOMarkShadow;
  final Color playerOMarkHighlight;
  final Color gameStatusPlaying;
  final Color playerTurnActiveBorder;
  final Color boardCellWinningGlow;

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
    boardGridLine: Color(0xFFDCD8F0),
    boardCellRecessedBackground: Color(0xFF9490B0),
    boardCellRecessedInsetShadow: Color(0xFF5A5675),
    boardCellRecessedInsetHighlight: Color(0xFFD8D4EC),
    playerX: Color(0xFF64B5AD),
    playerXMarkShadow: Color(0xFF2E6B64),
    playerXMarkHighlight: Color(0xFF9FE0D8),
    playerO: Color(0xFFF17D52),
    playerOMarkShadow: Color(0xFFB84E24),
    playerOMarkHighlight: Color(0xFFFFD48A),
    gameStatusPlaying: Color(0xFF64B5AD),
    playerTurnActiveBorder: Color(0xFF4ECDC4),
    boardCellWinningGlow: Color(0xFFFDB851),
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
    Color? boardGridLine,
    Color? boardCellRecessedBackground,
    Color? boardCellRecessedInsetShadow,
    Color? boardCellRecessedInsetHighlight,
    Color? playerX,
    Color? playerXMarkShadow,
    Color? playerXMarkHighlight,
    Color? playerO,
    Color? playerOMarkShadow,
    Color? playerOMarkHighlight,
    Color? gameStatusPlaying,
    Color? playerTurnActiveBorder,
    Color? boardCellWinningGlow,
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
      boardGridLine: boardGridLine ?? this.boardGridLine,
      boardCellRecessedBackground:
          boardCellRecessedBackground ?? this.boardCellRecessedBackground,
      boardCellRecessedInsetShadow:
          boardCellRecessedInsetShadow ?? this.boardCellRecessedInsetShadow,
      boardCellRecessedInsetHighlight:
          boardCellRecessedInsetHighlight ??
          this.boardCellRecessedInsetHighlight,
      playerX: playerX ?? this.playerX,
      playerXMarkShadow: playerXMarkShadow ?? this.playerXMarkShadow,
      playerXMarkHighlight: playerXMarkHighlight ?? this.playerXMarkHighlight,
      playerO: playerO ?? this.playerO,
      playerOMarkShadow: playerOMarkShadow ?? this.playerOMarkShadow,
      playerOMarkHighlight: playerOMarkHighlight ?? this.playerOMarkHighlight,
      gameStatusPlaying: gameStatusPlaying ?? this.gameStatusPlaying,
      playerTurnActiveBorder:
          playerTurnActiveBorder ?? this.playerTurnActiveBorder,
      boardCellWinningGlow: boardCellWinningGlow ?? this.boardCellWinningGlow,
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
      boardGridLine: Color.lerp(boardGridLine, other.boardGridLine, t) ?? boardGridLine,
      boardCellRecessedBackground:
          Color.lerp(
            boardCellRecessedBackground,
            other.boardCellRecessedBackground,
            t,
          ) ??
          boardCellRecessedBackground,
      boardCellRecessedInsetShadow:
          Color.lerp(
            boardCellRecessedInsetShadow,
            other.boardCellRecessedInsetShadow,
            t,
          ) ??
          boardCellRecessedInsetShadow,
      boardCellRecessedInsetHighlight:
          Color.lerp(
            boardCellRecessedInsetHighlight,
            other.boardCellRecessedInsetHighlight,
            t,
          ) ??
          boardCellRecessedInsetHighlight,
      playerX: Color.lerp(playerX, other.playerX, t) ?? playerX,
      playerXMarkShadow:
          Color.lerp(playerXMarkShadow, other.playerXMarkShadow, t) ??
          playerXMarkShadow,
      playerXMarkHighlight:
          Color.lerp(playerXMarkHighlight, other.playerXMarkHighlight, t) ??
          playerXMarkHighlight,
      playerO: Color.lerp(playerO, other.playerO, t) ?? playerO,
      playerOMarkShadow:
          Color.lerp(playerOMarkShadow, other.playerOMarkShadow, t) ??
          playerOMarkShadow,
      playerOMarkHighlight:
          Color.lerp(playerOMarkHighlight, other.playerOMarkHighlight, t) ??
          playerOMarkHighlight,
      gameStatusPlaying:
          Color.lerp(gameStatusPlaying, other.gameStatusPlaying, t) ??
          gameStatusPlaying,
      playerTurnActiveBorder:
          Color.lerp(playerTurnActiveBorder, other.playerTurnActiveBorder, t) ??
          playerTurnActiveBorder,
      boardCellWinningGlow:
          Color.lerp(boardCellWinningGlow, other.boardCellWinningGlow, t) ??
          boardCellWinningGlow,
    );
  }
}
