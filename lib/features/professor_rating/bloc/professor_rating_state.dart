part of 'professor_rating_bloc.dart';

enum ProfessorRatingView { list, details, review }

enum ReviewCategory { overall, clarity, helpful, difficulty, grading }

// Collects the transient inputs for the review form before submit.
class ProfessorRatingForm {
  const ProfessorRatingForm({
    this.overall = 0,
    this.clarity = 0,
    this.helpful = 0,
    this.difficulty = 0,
    this.grading = 0,
    this.course = '',
    this.review = '',
  });

  final int overall;
  final int clarity;
  final int helpful;
  final int difficulty;
  final int grading;
  final String course;
  final String review;

  bool get isValid {
    return overall > 0 &&
        clarity > 0 &&
        helpful > 0 &&
        difficulty > 0 &&
        grading > 0 &&
        course.trim().isNotEmpty &&
        review.trim().length >= 10;
  }

  ProfessorRatingForm copyWith({
    int? overall,
    int? clarity,
    int? helpful,
    int? difficulty,
    int? grading,
    String? course,
    String? review,
  }) {
    return ProfessorRatingForm(
      overall: overall ?? this.overall,
      clarity: clarity ?? this.clarity,
      helpful: helpful ?? this.helpful,
      difficulty: difficulty ?? this.difficulty,
      grading: grading ?? this.grading,
      course: course ?? this.course,
      review: review ?? this.review,
    );
  }
}

class ProfessorRatingState {
  const ProfessorRatingState({
    this.professors = const [],
    this.query = '',
    this.department = 'All',
    this.view = ProfessorRatingView.list,
    this.selectedProfessorId,
    this.form = const ProfessorRatingForm(),
    this.isSubmitting = false,
    this.didSubmit = false,
    this.showAllReviews = false,
  });

  final List<Professor> professors;
  final String query;
  final String department;
  final ProfessorRatingView view;
  final String? selectedProfessorId;
  final ProfessorRatingForm form;
  final bool isSubmitting;
  final bool didSubmit;
  final bool showAllReviews;

  // Resolves the selected professor directly from the current in-memory list.
  Professor? get selectedProfessor {
    for (final professor in professors) {
      if (professor.id == selectedProfessorId) return professor;
    }
    return professors.isEmpty ? null : professors.first;
  }

  List<String> get departments {
    final values = <String>{'All'};
    for (final professor in professors) {
      if (professor.department.contains('Computer')) {
        values.add('Computer Science');
      } else if (professor.department.contains('Design')) {
        values.add('Arts, Science & Design');
      } else if (professor.department.contains('Artificial')) {
        values.add('Data Science and Artificial Intelligence');
      } else if (professor.department.contains('Electronics')) {
        values.add('Electronics');
      }
    }
    return values.toList(growable: false);
  }

  List<Professor> get filteredProfessors {
    final normalizedQuery = query.trim().toLowerCase();
    return professors
        .where((professor) {
          final matchesDepartment =
              department == 'All' ||
              professor.department.toLowerCase().contains(
                department.toLowerCase(),
              );
          final matchesQuery =
              normalizedQuery.isEmpty ||
              professor.name.toLowerCase().contains(normalizedQuery) ||
              professor.department.toLowerCase().contains(normalizedQuery);
          return matchesDepartment && matchesQuery;
        })
        .toList(growable: false);
  }

  ProfessorRatingState copyWith({
    List<Professor>? professors,
    String? query,
    String? department,
    ProfessorRatingView? view,
    String? selectedProfessorId,
    ProfessorRatingForm? form,
    bool? isSubmitting,
    bool? didSubmit,
    bool? showAllReviews,
  }) {
    return ProfessorRatingState(
      professors: professors ?? this.professors,
      query: query ?? this.query,
      department: department ?? this.department,
      view: view ?? this.view,
      selectedProfessorId: selectedProfessorId ?? this.selectedProfessorId,
      form: form ?? this.form,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      didSubmit: didSubmit ?? this.didSubmit,
      showAllReviews: showAllReviews ?? this.showAllReviews,
    );
  }
}
