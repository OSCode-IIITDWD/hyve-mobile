import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/core/theme/app_theme.dart';
import 'package:hyve/features/professor_rating/bloc/professor_rating_bloc.dart';
import 'package:hyve/features/professor_rating/data/models/professor.dart';
import 'package:hyve/features/professor_rating/widgets/professor_avatar.dart';
import 'package:hyve/features/professor_rating/widgets/rating_stars.dart';

class ProfessorDetailsView extends StatelessWidget {
  const ProfessorDetailsView({
    super.key,
    required this.professor,
    required this.showAllReviews,
  });

  final Professor professor;
  final bool showAllReviews;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final semanticColors = context.appColors;
    final visibleReviews = showAllReviews
        ? professor.reviews
        : professor.reviews.take(2).toList(growable: false);

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 112),
      children: [
        Column(
          children: [
            ProfessorAvatar(imageUrl: professor.imageUrl, size: 96),
            const SizedBox(height: 16),
            Text(
              professor.name,
              textAlign: TextAlign.center,
              style: _mobileTitleStyle(context),
            ),
            const SizedBox(height: 4),
            Text(
              'Department of ${professor.department}',
              textAlign: TextAlign.center,
              style: _bodyStyle(
                context,
              ).copyWith(color: semanticColors.secondary),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _RatingSummary(professor: professor),
        const SizedBox(height: 24),
        Text('Courses Taught', style: _sectionTitleStyle(context)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: professor.courses.keys.toList().map((course) {
            return Chip(
              label: Text(course),
              labelStyle: _labelStyle(context),
              backgroundColor: colors.surfaceContainerHighest,
              side: BorderSide(color: colors.outlineVariant),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Reviews', style: _sectionTitleStyle(context)),
            TextButton(
              onPressed: professor.reviews.isEmpty
                  ? null
                  : () => context.read<ProfessorRatingBloc>().add(
                      ProfessorRatingSeeAllReviewsTapped(),
                    ),
              child: Text(
                showAllReviews ? 'Show Less' : 'See All',
                style: _labelStyle(context).copyWith(color: colors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...visibleReviews.map(
          (review) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ReviewCard(review: review),
          ),
        ),
      ],
    );
  }
}

class WriteReviewBar extends StatelessWidget {
  const WriteReviewBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor.withValues(alpha: 0.9),
          border: Border(top: BorderSide(color: colors.outlineVariant)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          height: 54,
          child: ElevatedButton.icon(
            onPressed: () => context.read<ProfessorRatingBloc>().add(
              ProfessorRatingWriteReviewTapped(),
            ),
            icon: const Icon(Icons.edit_square, size: 20),
            label: const Text('Write a Review'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              textStyle: _sectionTitleStyle(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingSummary extends StatelessWidget {
  const _RatingSummary({required this.professor});

  final Professor professor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final semanticColors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                professor.rating.toStringAsFixed(1),
                style: _headlineStyle(
                  context,
                ).copyWith(color: colors.primary, fontSize: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingStars(rating: professor.rating, size: 21),
                    const SizedBox(height: 4),
                    Text(
                      'Based on ${professor.reviewCount} ratings',
                      style: _labelStyle(
                        context,
                      ).copyWith(color: semanticColors.secondary),
                    ),
                  ],
                ),
              ),
              if (professor.isVerified)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: colors.onSurfaceVariant,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text('Verified', style: _labelStyle(context)),
                    ],
                  ),
                ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1),
          ),
          _BreakdownRow(label: 'Clarity', value: professor.breakdown.clarity),
          _BreakdownRow(label: 'Helpful', value: professor.breakdown.helpful),
          _BreakdownRow(
            label: 'Difficulty',
            value: professor.breakdown.difficulty,
            color: semanticColors.success,
          ),
          _BreakdownRow(label: 'Grading', value: professor.breakdown.grading),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value, this.color});

  final String label;
  final double value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Text(label, style: _bodyMutedStyle(context)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: value / 5,
                color: color ?? colors.primary,
                backgroundColor: colors.outlineVariant,
              ),
            ),
          ),
          SizedBox(
            width: 38,
            child: Text(
              value.toStringAsFixed(1),
              textAlign: TextAlign.end,
              style: _labelStyle(context).copyWith(color: colors.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final ProfessorReview review;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final semanticColors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: colors.primaryContainer,
                child: Text(
                  review.initial,
                  style: _labelStyle(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingStars(rating: review.rating.toDouble(), size: 18),
                  Text(
                    'Took ${review.course} - ${review.formattedDate()}',
                    style: _labelStyle(
                      context,
                    ).copyWith(color: semanticColors.secondary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review.body, style: _bodyMutedStyle(context)),
          if (review.tags.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: review.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: _labelStyle(
                      context,
                    ).copyWith(color: semanticColors.secondary, fontSize: 10),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

TextStyle _headlineStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineLarge!.copyWith(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w700,
  );
}

TextStyle _mobileTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium!.copyWith(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w700,
  );
}

TextStyle _sectionTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
  );
}

TextStyle _bodyStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
  );
}

TextStyle _bodyMutedStyle(BuildContext context) {
  return _bodyStyle(
    context,
  ).copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);
}

TextStyle _labelStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelMedium!.copyWith(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
  );
}

BoxDecoration _cardDecoration(BuildContext context) {
  final colors = Theme.of(context).colorScheme;
  return BoxDecoration(
    color: colors.surfaceContainerLow,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: colors.outlineVariant),
    boxShadow: [
      BoxShadow(
        color: colors.primary.withValues(alpha: 0.04),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
