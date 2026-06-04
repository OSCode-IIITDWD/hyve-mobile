import 'package:flutter/material.dart';
import 'package:hyve/features/cabin_location/data/models/prof_model.dart';
import 'professor_card.dart';
import 'package:hyve/core/theme/app_theme.dart';

class FacultySection extends StatelessWidget {
  final String title;
  final List<ProfessorModel> professors;

  const FacultySection({
    super.key,
    required this.title,
    required this.professors,
  });

  @override
  Widget build(BuildContext context) {
    if (professors.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appColors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
          child: Row(
            children: [
              Icon(
                Icons.meeting_room_outlined,
                size: 20,
                color: appColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: textTheme.titleSmall?.copyWith(
                  color: appColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Divider(
                  color: colorScheme.outlineVariant,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: professors.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return ProfessorCard(professor: professors[index]);
          },
        ),
      ],
    );
  }
}