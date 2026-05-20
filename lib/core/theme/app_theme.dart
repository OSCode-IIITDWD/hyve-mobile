import 'package:flutter/material.dart';
import 'app_theme_light.dart';
import 'app_theme_dark.dart';

export 'app_theme_light.dart';
export 'app_theme_dark.dart';

// ─── AppTheme ─────────────────────────────────────────────────────────────────

class AppTheme {
  AppTheme._();
  static ThemeData get light => AppColors.theme;
  static ThemeData get dark  => AppColorsDark.theme;
}

// ─── Semantic Color Extension ─────────────────────────────────────────────────

extension AppColorsContext on BuildContext {
  SemanticColors get appColors => SemanticColors.of(this);
}

class SemanticColors {
  const SemanticColors._({
    required this.danger,
    required this.warning,
    required this.success,
    required this.info,
    required this.primary,
    required this.secondary,
  });

  factory SemanticColors.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? const SemanticColors._(
            danger:    AppColorsDark.danger,
            warning:   AppColorsDark.warning,
            success:   AppColorsDark.success,
            info:      AppColorsDark.info,
            primary:   AppColorsDark.primary,
            secondary: AppColorsDark.secondary,
          )
        : const SemanticColors._(
            danger:    AppColors.danger,
            warning:   AppColors.warning,
            success:   AppColors.success,
            info:      AppColors.info,
            primary:   AppColors.primary,
            secondary: AppColors.secondary,
          );
  }

  final Color danger;
  final Color warning;
  final Color success;
  final Color info;
  final Color primary;
  final Color secondary;
}
