import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/features/professor_rating/bloc/professor_rating_bloc.dart';
import 'package:hyve/features/professor_rating/widgets/professor_app_bar.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';
import 'package:hyve/features/professor_rating/widgets/review_form_view.dart';

class ProfessorReviewPage extends StatelessWidget {
  const ProfessorReviewPage({super.key, required this.professorId});

  final String professorId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfessorRatingBloc, ProfessorRatingState>(
      listenWhen: (previous, current) =>
          previous.didSubmit != current.didSubmit,
      listener: (context, state) {
        if (!state.didSubmit) return;

        final messenger = ScaffoldMessenger.of(context);
        final navigator = Navigator.of(context);
        context.read<ProfessorRatingBloc>().add(
          ProfessorRatingSubmissionMessageDismissed(),
        );
        if (navigator.canPop()) {
          navigator.pop();
        }
        messenger.showSnackBar(
          const SnackBar(content: Text('Review submitted anonymously.')),
        );
      },
      builder: (context, state) {
        final professor = state.professorById(professorId);
        final palette = context.professorPalette;

        return Scaffold(
          backgroundColor: palette.background,
          body: Stack(
            children: [
              const ProfessorWaveBackground(),
              Column(
                children: [
                  ProfessorAppBar(
                    title: 'Write a Review',
                    onBack: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: professor == null
                        ? const Center(child: CircularProgressIndicator())
                        : ReviewFormView(
                            professor: professor,
                            form: state.form,
                            isSubmitting: state.isSubmitting,
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
