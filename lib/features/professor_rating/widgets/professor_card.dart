import 'package:flutter/material.dart';
import 'package:hyve/features/professor_rating/data/models/professor.dart';
import 'package:hyve/features/professor_rating/widgets/professor_avatar.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';

class ProfessorCard extends StatelessWidget {
  const ProfessorCard({
    super.key,
    required this.professor,
    required this.onTap,
  });

  final Professor professor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mutedRating = professor.rating < 4;
    final palette = context.professorPalette;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: professorCardDecoration(context),
          child: Stack(
            children: [
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: palette.primary.withValues(alpha: .05),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(64),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfessorAvatar(imageUrl: professor.imageUrl),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              professor.name,
                              style: context.professorSectionTitle,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              professor.department,
                              style: context.professorLabel,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: mutedRating
                              ? palette.surfaceContainer
                              : palette.primary.withValues(
                                  alpha: .08,
                                ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: mutedRating
                                  ? palette.tertiary
                                  : palette.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              professor.rating.toStringAsFixed(1),
                              style: context.professorLabel.copyWith(
                                color: mutedRating
                                    ? palette.text
                                    : palette.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${professor.reviewCount} reviews',
                          style: context.professorLabel.copyWith(
                            color: palette.outline,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 22,
                        color: palette.outlineVariant,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
