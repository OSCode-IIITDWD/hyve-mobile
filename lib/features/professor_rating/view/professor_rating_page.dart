import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/features/professor_rating/bloc/professor_rating_bloc.dart';
import 'package:hyve/features/professor_rating/widgets/professor_app_bar.dart';
import 'package:hyve/features/professor_rating/widgets/professor_details_view.dart';
import 'package:hyve/features/professor_rating/widgets/professor_list_view.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';
import 'package:hyve/features/professor_rating/widgets/review_form_view.dart';

class ProfessorRatingPage extends StatelessWidget {
  const ProfessorRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfessorRatingBloc()..add(ProfessorRatingStarted()),
      child: const _ProfessorRatingView(),
    );
  }
}

class _ProfessorRatingView extends StatefulWidget {
  const _ProfessorRatingView();

  @override
  State<_ProfessorRatingView> createState() => _ProfessorRatingViewState();
}

class _ProfessorRatingViewState extends State<_ProfessorRatingView> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfessorRatingBloc, ProfessorRatingState>(
      listenWhen: (previous, current) =>
          previous.didSubmit != current.didSubmit,
      listener: (context, state) {
        if (!state.didSubmit) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review submitted anonymously.')),
        );
        context.read<ProfessorRatingBloc>().add(
          ProfessorRatingSubmissionMessageDismissed(),
        );
      },
      builder: (context, state) {
        final professor = state.selectedProfessor;
        final palette = context.professorPalette;

        return Scaffold(
          backgroundColor: palette.background,
          bottomNavigationBar: state.view == ProfessorRatingView.details
              ? const WriteReviewBar()
              : null,
          body: Stack(
            children: [
              ProfessorWaveBackground(),

              Column(
                children: [
                  if (state.view == ProfessorRatingView.list)
                    ProfessorAppBar(
                      onSearch: () => _searchFocusNode.requestFocus(),
                    )
                  else if (state.view == ProfessorRatingView.details)
                    ProfessorAppBar(
                      onBack: () => context.read<ProfessorRatingBloc>().add(
                        ProfessorRatingBackTapped(),
                      ),
                      onShare: () {
                        // Add share options later
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Share link copied.')),
                        );
                      },
                    )
                  else if (state.view == ProfessorRatingView.review)
                    ProfessorAppBar(
                      title: 'Write a Review',
                      onBack: () => context.read<ProfessorRatingBloc>().add(
                        ProfessorRatingBackTapped(),
                      ),
                    ),

                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      // The selected view is entirely driven by BLoC state.
                      child: switch (state.view) {
                        ProfessorRatingView.list => ProfessorListView(
                          key: const ValueKey('professor-list'),
                          state: state,
                          searchFocusNode: _searchFocusNode,
                        ),
                        ProfessorRatingView.details when professor != null =>
                          ProfessorDetailsView(
                            key: const ValueKey('professor-details'),
                            professor: professor,
                            showAllReviews: state.showAllReviews,
                          ),
                        ProfessorRatingView.review when professor != null =>
                          ReviewFormView(
                            key: const ValueKey('review-form'),
                            professor: professor,
                            form: state.form,
                            isSubmitting: state.isSubmitting,
                          ),
                        _ => const Center(child: CircularProgressIndicator()),
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
