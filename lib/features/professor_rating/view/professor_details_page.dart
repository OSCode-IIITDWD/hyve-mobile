import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/features/professor_rating/bloc/professor_rating_bloc.dart';
import 'package:hyve/features/professor_rating/view/professor_review_page.dart';
import 'package:hyve/features/professor_rating/widgets/professor_app_bar.dart';
import 'package:hyve/features/professor_rating/widgets/professor_details_view.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';

class ProfessorDetailsPage extends StatelessWidget {
  const ProfessorDetailsPage({super.key, required this.professorId});

  final String professorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessorRatingBloc, ProfessorRatingState>(
      builder: (context, state) {
        final professor = state.professorById(professorId);
        final palette = context.professorPalette;

        return Scaffold(
          backgroundColor: palette.background,
          bottomNavigationBar: professor == null
              ? null
              : WriteReviewBar(
                  onPressed: () {
                    final bloc = context.read<ProfessorRatingBloc>()
                      ..add(ProfessorRatingReviewStarted());
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider.value(
                          value: bloc,
                          child: ProfessorReviewPage(professorId: professorId),
                        ),
                      ),
                    );
                  },
                ),

          body: Stack(
            children: [
              const ProfessorWaveBackground(),

              Column(
                children: [
                  ProfessorAppBar(
                    onBack: () => Navigator.of(context).pop(),
                    onShare: () {
                      // this will be implemented in the future when we have a proper link to share
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share link copied.')),
                      );
                    },
                  ),

                  Expanded(
                    child: professor == null
                        ? const Center(child: CircularProgressIndicator())
                        : ProfessorDetailsView(
                            professor: professor,
                            showAllReviews: state.showAllReviews,
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
