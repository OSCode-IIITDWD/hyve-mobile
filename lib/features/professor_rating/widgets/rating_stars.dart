import 'package:flutter/material.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.size = 20,
    this.onChanged,
  });

  final double rating;
  final double size;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;
    final normalizedRating = ((rating * 2).round() / 2).clamp(0.0, 5.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final value = index + 1;
        final icon = _iconForIndex(index, normalizedRating);
        final isActive = icon != Icons.star_border;
        return GestureDetector(
          onTap: onChanged == null ? null : () => onChanged!(value),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: onChanged == null ? 0 : 3,
            ),
            child: Icon(
              icon,
              color: isActive ? palette.primary : palette.surfaceContainer,
              size: size,
            ),
          ),
        );
      }),
    );
  }

  IconData _iconForIndex(int index, double normalizedRating) {
    final starPosition = index + 1;
    if (normalizedRating >= starPosition) return Icons.star;
    if (normalizedRating >= starPosition - 0.5) return Icons.star_half;
    return Icons.star_border;
  }
}
