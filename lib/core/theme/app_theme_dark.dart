import 'package:flutter/material.dart';

// ─── Dark Color Tokens ────────────────────────────────────────────────────────

class AppColorsDark {
  AppColorsDark._();
  // dart format off
  static const bgDark      = Color(0xFF030303);
  static const bg          = Color(0xFF0A0A0A);
  static const bgLight     = Color(0xFF171717);
  static const highlight   = Color(0xFF636363);
  static const text        = Color(0xFFF2F2F2);
  static const textMuted   = Color(0xFFB0B0B0);
  static const border      = Color(0xFF474747);
  static const borderMuted = Color(0xFF2E2E2E);
  static const primary     = Color(0xFFE99595);
  static const secondary   = Color(0xFF58C5CA);
  static const danger      = Color(0xFFBB928B);
  static const warning     = Color(0xFFA6A17D);
  static const success     = Color(0xFF85A894);
  static const info        = Color(0xFF8DA0BF);
  // dart format on

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: bgDark,
      primaryContainer: bgLight,
      onPrimaryContainer: primary,
      secondary: secondary,
      onSecondary: bgDark,
      secondaryContainer: bgLight,
      onSecondaryContainer: secondary,
      error: danger,
      onError: bgDark,
      surface: bg,
      onSurface: text,
      onSurfaceVariant: textMuted,
      outline: border,
      outlineVariant: borderMuted,
      surfaceContainerHighest: bgDark,
      surfaceContainerHigh: bgDark,
      surfaceContainer: bg,
      surfaceContainerLow: bgLight,
      surfaceContainerLowest: highlight,
      shadow: Colors.black54,
      scrim: Colors.black87,
    ),
    scaffoldBackgroundColor: bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: bgDark,
      foregroundColor: text,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: text,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: text),
    ),
    cardTheme: CardThemeData(
      color: bgLight,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: borderMuted),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: bgDark,
        disabledBackgroundColor: borderMuted,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: border),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: bgLight,
      hintStyle: const TextStyle(color: textMuted, fontSize: 14),
      labelStyle: const TextStyle(color: textMuted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: danger, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dividerTheme: const DividerThemeData(
      color: borderMuted,
      thickness: 1,
      space: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: bgDark,
      labelStyle: const TextStyle(color: text, fontSize: 12),
      side: const BorderSide(color: borderMuted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: secondary,
      contentTextStyle: const TextStyle(color: bgDark, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),
    textTheme: const TextTheme(
      displayLarge:  TextStyle(color: text, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: text, fontWeight: FontWeight.bold),
      displaySmall:  TextStyle(color: text, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: text, fontWeight: FontWeight.w700),
      headlineMedium:TextStyle(color: text, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: text, fontWeight: FontWeight.w600),
      titleLarge:    TextStyle(color: text, fontWeight: FontWeight.w600),
      titleMedium:   TextStyle(color: text, fontWeight: FontWeight.w500),
      titleSmall:    TextStyle(color: text, fontWeight: FontWeight.w500),
      bodyLarge:     TextStyle(color: text),
      bodyMedium:    TextStyle(color: text),
      bodySmall:     TextStyle(color: textMuted),
      labelLarge:    TextStyle(color: text,      fontWeight: FontWeight.w600),
      labelMedium:   TextStyle(color: textMuted, fontWeight: FontWeight.w500),
      labelSmall:    TextStyle(color: textMuted),
    ),
    iconTheme: const IconThemeData(color: text, size: 22),
  );
}
