import 'package:flutter/material.dart';
import 'package:hyve/features/cabin_location/data/models/prof_model.dart';
import 'package:hyve/features/cabin_location/view/professor_detail_page.dart';
import 'package:hyve/core/theme/app_theme.dart';

class HodCard extends StatelessWidget {
  final ProfessorModel hod;

  const HodCard({super.key, required this.hod});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appColors = context.appColors;

    return Card(
      elevation: 0,
      color: appColors.primary.withOpacity(0.05),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: appColors.primary.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfessorDetailPage(professor: hod),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: appColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Head of Department",
                    style: textTheme.labelLarge?.copyWith(
                      color: appColors.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: appColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: appColors.primary.withOpacity(0.3),
                        width: 2,
                      ),
                      image: hod.photo != null && hod.photo!.isNotEmpty
                          ? DecorationImage(
                        image: NetworkImage(hod.photo!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: hod.photo == null || hod.photo!.isEmpty
                        ? Icon(
                      Icons.person_outline_rounded,
                      size: 28,
                      color: appColors.primary,
                    )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hod.name,
                          style: textTheme.headlineSmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "${hod.department} Dept  •  Cabin: ",
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              hod.cabin,
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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