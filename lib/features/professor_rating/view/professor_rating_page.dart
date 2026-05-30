import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/features/professor_rating/bloc/professor_rating_bloc.dart';
import 'package:hyve/features/professor_rating/view/professor_details_page.dart';
import 'package:hyve/features/professor_rating/widgets/professor_app_bar.dart';
import 'package:hyve/features/professor_rating/widgets/professor_list_view.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';

class ProfessorRatingPage extends StatelessWidget {
  const ProfessorRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfessorRatingBloc()..add(ProfessorRatingStarted()),
      child: const _ProfessorListPage(),
    );
  }
}

class _ProfessorListPage extends StatefulWidget {
  const _ProfessorListPage();

  @override
  State<_ProfessorListPage> createState() => _ProfessorListPageState();
}

class _ProfessorListPageState extends State<_ProfessorListPage> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessorRatingBloc, ProfessorRatingState>(
      builder: (context, state) {
        final palette = context.professorPalette;

        return Scaffold(
          backgroundColor: palette.background,
          body: Stack(
            children: [
              const ProfessorWaveBackground(),

              Column(
                children: [
                  ProfessorAppBar(
                    onSearch: () => _searchFocusNode.requestFocus(),
                  ),

                  Expanded(
                    child: ProfessorListView(
                      state: state,
                      searchFocusNode: _searchFocusNode,
                      onProfessorTap: (professorId) {
                        final bloc = context.read<ProfessorRatingBloc>()
                          ..add(ProfessorRatingProfessorSelected(professorId));

                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => BlocProvider.value(
                              value: bloc,
                              child: ProfessorDetailsPage(
                                professorId: professorId,
                              ),
                            ),
                          ),
                        );
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
