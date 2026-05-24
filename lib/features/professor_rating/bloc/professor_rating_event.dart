part of 'professor_rating_bloc.dart';

sealed class ProfessorRatingEvent {}

class ProfessorRatingStarted extends ProfessorRatingEvent {}

class ProfessorRatingSearchChanged extends ProfessorRatingEvent {
  ProfessorRatingSearchChanged(this.query);

  final String query;
}

class ProfessorRatingDepartmentSelected extends ProfessorRatingEvent {
  ProfessorRatingDepartmentSelected(this.department);

  final String department;
}

class ProfessorRatingProfessorSelected extends ProfessorRatingEvent {
  ProfessorRatingProfessorSelected(this.professorId);

  final String professorId;
}

class ProfessorRatingBackTapped extends ProfessorRatingEvent {}

class ProfessorRatingWriteReviewTapped extends ProfessorRatingEvent {}

class ProfessorRatingSeeAllReviewsTapped extends ProfessorRatingEvent {}

class ProfessorRatingValueChanged extends ProfessorRatingEvent {
  ProfessorRatingValueChanged({required this.category, required this.value});

  final ReviewCategory category;
  final int value;
}

class ProfessorRatingCourseChanged extends ProfessorRatingEvent {
  ProfessorRatingCourseChanged(this.course);

  final String course;
}

class ProfessorRatingReviewTextChanged extends ProfessorRatingEvent {
  ProfessorRatingReviewTextChanged(this.text);

  final String text;
}

class ProfessorRatingReviewSubmitted extends ProfessorRatingEvent {}

class ProfessorRatingSubmissionMessageDismissed extends ProfessorRatingEvent {}
