import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/features/professor_rating/data/models/professor.dart';
import 'package:hyve/features/professor_rating/data/services/professor_rating_service.dart';

part 'professor_rating_event.dart';
part 'professor_rating_state.dart';

class ProfessorRatingBloc
    extends Bloc<ProfessorRatingEvent, ProfessorRatingState> {
  ProfessorRatingBloc({ProfessorRatingService? service})
    : _service = service ?? ProfessorRatingService(),
      super(const ProfessorRatingState()) {
    on<ProfessorRatingStarted>(_onStarted);
    on<ProfessorRatingSearchChanged>(_onSearchChanged);
    on<ProfessorRatingDepartmentSelected>(_onDepartmentSelected);
    on<ProfessorRatingProfessorSelected>(_onProfessorSelected);
    on<ProfessorRatingBackTapped>(_onBackTapped);
    on<ProfessorRatingWriteReviewTapped>(_onWriteReviewTapped);
    on<ProfessorRatingSeeAllReviewsTapped>(_onSeeAllReviewsTapped);
    on<ProfessorRatingValueChanged>(_onValueChanged);
    on<ProfessorRatingCourseChanged>(_onCourseChanged);
    on<ProfessorRatingReviewTextChanged>(_onReviewTextChanged);
    on<ProfessorRatingReviewSubmitted>(_onReviewSubmitted);
    on<ProfessorRatingSubmissionMessageDismissed>(
      _onSubmissionMessageDismissed,
    );
  }

  final ProfessorRatingService _service;

  Future<void> _onStarted(
    ProfessorRatingStarted event,
    Emitter<ProfessorRatingState> emit,
  ) async {
    final professors = await _service.fetchProfessors();
    emit(
      state.copyWith(
        professors: professors,
        selectedProfessorId: professors.isEmpty ? null : professors.first.id,
      ),
    );
  }

  void _onSearchChanged(
    ProfessorRatingSearchChanged event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(state.copyWith(query: event.query));
  }

  void _onDepartmentSelected(
    ProfessorRatingDepartmentSelected event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(state.copyWith(department: event.department));
  }

  void _onProfessorSelected(
    ProfessorRatingProfessorSelected event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(
      state.copyWith(
        selectedProfessorId: event.professorId,
        view: ProfessorRatingView.details,
        didSubmit: false,
        showAllReviews: false,
      ),
    );
  }

  void _onBackTapped(
    ProfessorRatingBackTapped event,
    Emitter<ProfessorRatingState> emit,
  ) {
    if (state.view == ProfessorRatingView.review) {
      emit(state.copyWith(view: ProfessorRatingView.details));
      return;
    }
    if (state.view == ProfessorRatingView.details) {
      emit(
        state.copyWith(
          view: ProfessorRatingView.list,
          didSubmit: false,
          showAllReviews: false,
        ),
      );
    }
  }

  void _onWriteReviewTapped(
    ProfessorRatingWriteReviewTapped event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(
      state.copyWith(
        view: ProfessorRatingView.review,
        form: const ProfessorRatingForm(),
        didSubmit: false,
      ),
    );
  }

  void _onSeeAllReviewsTapped(
    ProfessorRatingSeeAllReviewsTapped event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(state.copyWith(showAllReviews: !state.showAllReviews));
  }

  void _onValueChanged(
    ProfessorRatingValueChanged event,
    Emitter<ProfessorRatingState> emit,
  ) {
    final form = state.form;
    final nextForm = switch (event.category) {
      ReviewCategory.overall => form.copyWith(overall: event.value),
      ReviewCategory.clarity => form.copyWith(clarity: event.value),
      ReviewCategory.helpful => form.copyWith(helpful: event.value),
      ReviewCategory.difficulty => form.copyWith(difficulty: event.value),
      ReviewCategory.grading => form.copyWith(grading: event.value),
    };
    emit(state.copyWith(form: nextForm));
  }

  void _onReviewTextChanged(
    ProfessorRatingReviewTextChanged event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(state.copyWith(form: state.form.copyWith(review: event.text)));
  }

  void _onCourseChanged(
    ProfessorRatingCourseChanged event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(state.copyWith(form: state.form.copyWith(course: event.course)));
  }

  Future<void> _onReviewSubmitted(
    ProfessorRatingReviewSubmitted event,
    Emitter<ProfessorRatingState> emit,
  ) async {
    final professor = state.selectedProfessor;
    if (professor == null || !state.form.isValid || state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true));
    final updated = await _service.submitReview(
      professor: professor,
      overall: state.form.overall,
      clarity: state.form.clarity,
      helpful: state.form.helpful,
      difficulty: state.form.difficulty,
      grading: state.form.grading,
      course: state.form.course,
      body: state.form.review,
    );
    final updatedProfessors = [
      for (final item in state.professors)
        if (item.id == updated.id) updated else item,
    ];

    // After submit we return to the details page so the user can
    // immediately see the updated averages and newest review.
    emit(
      state.copyWith(
        professors: updatedProfessors,
        view: ProfessorRatingView.details,
        form: const ProfessorRatingForm(),
        isSubmitting: false,
        didSubmit: true,
      ),
    );
  }

  void _onSubmissionMessageDismissed(
    ProfessorRatingSubmissionMessageDismissed event,
    Emitter<ProfessorRatingState> emit,
  ) {
    emit(state.copyWith(didSubmit: false));
  }
}
