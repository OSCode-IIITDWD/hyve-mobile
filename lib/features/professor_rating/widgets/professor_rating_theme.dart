import 'package:flutter/material.dart';
import 'package:hyve/core/theme/app_theme.dart';

extension ProfessorRatingThemeContext on BuildContext {
  ProfessorRatingPalette get professorPalette =>
      ProfessorRatingPalette.from(this);

  TextStyle get professorHeadline => Theme.of(this).textTheme.headlineLarge!
      .copyWith(fontSize: 28, height: 36 / 28, fontWeight: FontWeight.w700);

  TextStyle get professorMobileTitle => Theme.of(this).textTheme.headlineMedium!
      .copyWith(fontSize: 22, height: 28 / 22, fontWeight: FontWeight.w700);

  TextStyle get professorSectionTitle => Theme.of(this).textTheme.titleLarge!
      .copyWith(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w600);

  TextStyle get professorBody => Theme.of(this).textTheme.bodyMedium!.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
  );

  TextStyle get professorBodyMuted => professorBody.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant,
  );

  TextStyle get professorLabel => Theme.of(this).textTheme.labelMedium!
      .copyWith(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w600);
}

class ProfessorRatingPalette {
  const ProfessorRatingPalette({
    required this.background,
    required this.surface,
    required this.surfaceContainer,
    required this.surfaceVariant,
    required this.primary,
    required this.primarySoft,
    required this.secondary,
    required this.text,
    required this.textMuted,
    required this.outline,
    required this.outlineVariant,
    required this.tertiary,
  });

  factory ProfessorRatingPalette.from(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final semantic = context.appColors;
    return ProfessorRatingPalette(
      background: theme.scaffoldBackgroundColor,
      surface: scheme.surfaceContainerLow,
      surfaceContainer: scheme.surfaceContainerHighest,
      surfaceVariant: scheme.outlineVariant,
      primary: scheme.primary,
      primarySoft: scheme.primaryContainer,
      secondary: semantic.secondary,
      text: scheme.onSurface,
      textMuted: scheme.onSurfaceVariant,
      outline: scheme.outline,
      outlineVariant: scheme.outlineVariant,
      tertiary: semantic.success,
    );
  }

  final Color background;
  final Color surface;
  final Color surfaceContainer;
  final Color surfaceVariant;
  final Color primary;
  final Color primarySoft;
  final Color secondary;
  final Color text;
  final Color textMuted;
  final Color outline;
  final Color outlineVariant;
  final Color tertiary;
}

BoxDecoration professorCardDecoration(
  BuildContext context, {
  double radius = 12,
}) {
  final palette = context.professorPalette;
  return BoxDecoration(
    color: palette.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: palette.surfaceVariant),
    boxShadow: [
      BoxShadow(
        color: palette.primary.withValues(alpha: 0.04),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

class ProfessorWaveBackground extends StatelessWidget {
  const ProfessorWaveBackground({super.key, this.height = 260});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: height,
      child: IgnorePointer(
        child: CustomPaint(
          painter: _WavePainter(baseColor: context.professorPalette.primary),
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  const _WavePainter({required this.baseColor});

  final Color baseColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          baseColor.withValues(alpha: 0.15),
          baseColor.withValues(alpha: 0),
        ],
      ).createShader(Offset.zero & size);

    final path = Path()
      ..lineTo(0, size.height * .46)
      ..cubicTo(
        size.width * .22,
        size.height * .72,
        size.width * .44,
        size.height * .32,
        size.width * .68,
        size.height * .48,
      )
      ..cubicTo(
        size.width * .84,
        size.height * .58,
        size.width * .92,
        size.height * .66,
        size.width,
        size.height * .54,
      )
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) =>
      oldDelegate.baseColor != baseColor;
}
