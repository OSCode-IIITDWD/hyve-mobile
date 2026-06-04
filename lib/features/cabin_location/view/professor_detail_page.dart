import 'package:flutter/material.dart';
import 'package:hyve/features/cabin_location/data/models/prof_model.dart';
import 'package:hyve/core/theme/app_theme.dart';

class ProfessorDetailPage extends StatelessWidget {
  final ProfessorModel professor;

  const ProfessorDetailPage({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Professor Profile'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 24,)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: appColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
                image: professor.photo != null && professor.photo!.isNotEmpty
                    ? DecorationImage(
                  image: NetworkImage(professor.photo!),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: professor.photo == null || professor.photo!.isEmpty
                  ? Icon(
                Icons.person_outline_rounded,
                size: 75,
                color: appColors.primary,
              )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              professor.name,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (professor.isHod) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: appColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Head of Department',
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
            Text(
              professor.department == 'null' || professor.department == '-'
                  ? 'Department Not Assigned'
                  : '${professor.department} Department',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOCATION DETAILS',
                    style: textTheme.titleSmall?.copyWith(
                      color: appColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _LocationRow(
                    icon: Icons.meeting_room_outlined,
                    label: 'Cabin Number',
                    value: professor.cabin,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),
                  ),
                  _LocationRow(
                    icon: Icons.layers_outlined,
                    label: 'Floor',
                    value: professor.floor,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),
                  ),
                  _LocationRow(
                    icon: Icons.explore_outlined,
                    label: 'Building Side',
                    value: '${professor.side} Side',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _LocationRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appColors = context.appColors;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: appColors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: appColors.secondary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}