import 'package:flutter/material.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';

class ProfessorAvatar extends StatelessWidget {
  const ProfessorAvatar({
    super.key,
    required this.imageUrl,
    this.size = 56,
    this.borderWidth = 2,
  });

  final String imageUrl;
  final double size;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: palette.surfaceVariant,
          width: borderWidth,
        ),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => ColoredBox(
            color: palette.primarySoft,
            child: Icon(
              Icons.person,
              size: size * .48,
              color: palette.primary,
            ),
          ),
        ),
      ),
    );
  }
}
