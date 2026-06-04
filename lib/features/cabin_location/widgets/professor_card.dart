import 'package:flutter/material.dart';
import 'package:hyve/features/cabin_location/data/models/prof_model.dart';
import 'package:hyve/features/cabin_location/view/professor_detail_page.dart';
import 'package:hyve/core/theme/app_theme.dart';

class ProfessorCard extends StatelessWidget {
  final ProfessorModel professor;

  const ProfessorCard({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appColors = context.appColors;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfessorDetailPage(professor: professor),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: appColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  image: professor.photo != null && professor.photo!.isNotEmpty
                      ? DecorationImage(
                    image: NetworkImage(professor.photo!), // Change to AssetImage if using local files
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: professor.photo == null || professor.photo!.isEmpty
                    ? Icon(
                  Icons.person_outline_rounded,
                  size: 24,
                  color: appColors.primary,
                )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  professor.name,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: appColors.secondary.withOpacity(0.3)),
                ),
                child: Text(
                  professor.cabin,
                  style: textTheme.labelLarge?.copyWith(
                    color: appColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}