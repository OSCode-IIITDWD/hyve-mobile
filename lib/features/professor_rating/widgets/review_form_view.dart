import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/features/professor_rating/bloc/professor_rating_bloc.dart';
import 'package:hyve/features/professor_rating/data/models/professor.dart';
import 'package:hyve/features/professor_rating/widgets/professor_avatar.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';
import 'package:hyve/features/professor_rating/widgets/rating_stars.dart';

class ReviewFormView extends StatelessWidget {
  const ReviewFormView({
    super.key,
    required this.professor,
    required this.form,
    required this.isSubmitting,
  });

  final Professor professor;
  final ProfessorRatingForm form;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        children: [
          const SizedBox(height: 24),
          _TargetProfessorCard(professor: professor),
          const SizedBox(height: 24),
          _CourseSelector(
            courses: professor.courses,
            selectedCourse: form.course,
          ),
          const SizedBox(height: 24),
          _OverallRating(value: form.overall),
          const SizedBox(height: 24),
          Text('Category Breakdown', style: context.professorSectionTitle),
          const SizedBox(height: 16),
          _SegmentRatingCard(
            label: 'Clarity',
            lowLabel: 'Confusing',
            highLabel: 'Crystal Clear',
            value: form.clarity,
            category: ReviewCategory.clarity,
          ),
          const SizedBox(height: 16),
          _SegmentRatingCard(
            label: 'Helpful',
            lowLabel: 'Unavailable',
            highLabel: 'Very Supportive',
            value: form.helpful,
            category: ReviewCategory.helpful,
          ),
          const SizedBox(height: 16),
          _SegmentRatingCard(
            label: 'Difficulty',
            lowLabel: 'Easy A',
            highLabel: 'Intense Workload',
            value: form.difficulty,
            category: ReviewCategory.difficulty,
          ),
          const SizedBox(height: 16),
          _SegmentRatingCard(
            label: 'Grading',
            lowLabel: 'Harsh',
            highLabel: 'Fair',
            value: form.grading,
            category: ReviewCategory.grading,
          ),
          const SizedBox(height: 24),
          _ReviewTextField(initialText: form.review),
          const SizedBox(height: 24),
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: form.isValid && !isSubmitting
                  ? () => context.read<ProfessorRatingBloc>().add(
                      ProfessorRatingReviewSubmitted(),
                    )
                  : null,
              icon: isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send, size: 20),
              label: Text(isSubmitting ? 'Submitting' : 'Submit Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: palette.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                disabledBackgroundColor: palette.outlineVariant,
                textStyle: context.professorSectionTitle,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your review will be posted anonymously.',
            textAlign: TextAlign.center,
            style: context.professorLabel.copyWith(color: palette.outline),
          ),
        ],
      ),
    );
  }
}

class _TargetProfessorCard extends StatelessWidget {
  const _TargetProfessorCard({required this.professor});

  final Professor professor;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: professorCardDecoration(context, radius: 16),
      child: Row(
        children: [
          ProfessorAvatar(imageUrl: professor.imageUrl, size: 64),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instructor',
                  style: context.professorLabel.copyWith(
                    color: palette.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(professor.name, style: context.professorSectionTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseSelector extends StatelessWidget {
  const _CourseSelector({required this.courses, required this.selectedCourse});

  final Map<String, String> courses;
  final String selectedCourse;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;
    final selectedValue = courses.keys.contains(selectedCourse)
        ? selectedCourse
        : null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: professorCardDecoration(context, radius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course', style: context.professorSectionTitle),
          const SizedBox(height: 6),
          Text(
            'Choose the course this review is based on.',
            style: context.professorBody.copyWith(color: palette.outline),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: selectedValue,

            isExpanded: true,
            hint: Text(
              'Select course',
              style: context.professorBody.copyWith(color: palette.outline),
            ),

            items: courses.entries
                .map(
                  (entry) => DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(
                      "${entry.key} - ${entry.value}",
                      style: context.professorBody,
                    ),
                  ),
                )
                .toList(),

            onChanged: courses.isEmpty
                ? null
                : (course) {
                    if (course == null) return;
                    context.read<ProfessorRatingBloc>().add(
                      ProfessorRatingCourseChanged(course),
                    );
                  },

            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: palette.primary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverallRating extends StatelessWidget {
  const _OverallRating({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: professorCardDecoration(context, radius: 16),
      child: Column(
        children: [
          Text('Overall Rating', style: context.professorSectionTitle),
          const SizedBox(height: 8),
          Text(
            'How would you rate your overall experience?',
            textAlign: TextAlign.center,
            style: context.professorBody.copyWith(color: palette.outline),
          ),
          const SizedBox(height: 14),
          RatingStars(
            rating: value.toDouble(),
            size: 40,
            onChanged: (rating) => context.read<ProfessorRatingBloc>().add(
              ProfessorRatingValueChanged(
                category: ReviewCategory.overall,
                value: rating,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentRatingCard extends StatelessWidget {
  const _SegmentRatingCard({
    required this.label,
    required this.lowLabel,
    required this.highLabel,
    required this.value,
    required this.category,
  });

  final String label;
  final String lowLabel;
  final String highLabel;
  final int value;
  final ReviewCategory category;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: professorCardDecoration(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: context.professorBody.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                value == 0 ? 'Select' : '$value/5',
                style: context.professorLabel.copyWith(
                  color: value == 0 ? palette.outline : palette.primary,
                  fontWeight: value == 0 ? FontWeight.w500 : FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              final rating = index + 1;
              final selected = rating == value;
              // Category ratings use explicit 1-5 buttons instead of stars
              // so each dimension reads as a deliberate score selection.
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: rating == 5 ? 0 : 8),
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () => context.read<ProfessorRatingBloc>().add(
                        ProfessorRatingValueChanged(
                          category: category,
                          value: rating,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: selected
                            ? palette.primary
                            : Theme.of(
                                context,
                              ).colorScheme.surfaceContainerLowest,
                        foregroundColor: selected
                            ? Theme.of(context).colorScheme.onPrimary
                            : palette.textMuted,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('$rating'),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lowLabel, style: context.professorLabel),
              Text(highLabel, style: context.professorLabel),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewTextField extends StatefulWidget {
  const _ReviewTextField({required this.initialText});

  final String initialText;

  @override
  State<_ReviewTextField> createState() => _ReviewTextFieldState();
}

class _ReviewTextFieldState extends State<_ReviewTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return TextField(
      controller: _controller,
      maxLines: 6,
      onChanged: (value) => context.read<ProfessorRatingBloc>().add(
        ProfessorRatingReviewTextChanged(value),
      ),
      style: context.professorBody,
      decoration: InputDecoration(
        hintText:
            'Share your experience... What did you like? What could be improved? Did the professor rely heavily on the textbook?',
        hintStyle: context.professorBody.copyWith(color: palette.outline),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: palette.primary, width: 1.5),
        ),
      ),
    );
  }
}
