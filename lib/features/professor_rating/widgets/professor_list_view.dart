import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyve/features/professor_rating/bloc/professor_rating_bloc.dart';
import 'package:hyve/features/professor_rating/widgets/professor_card.dart';
import 'package:hyve/features/professor_rating/widgets/professor_rating_theme.dart';

class ProfessorListView extends StatelessWidget {
  const ProfessorListView({
    super.key,
    required this.state,
    this.searchFocusNode,
  });

  final ProfessorRatingState state;
  final FocusNode? searchFocusNode;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      children: [
        Text('Rate Professor', style: context.professorHeadline),
        const SizedBox(height: 8),
        Text(
          'Find and review academic staff across all departments.',
          style: context.professorBodyMuted,
        ),
        const SizedBox(height: 16),
        _SearchField(initialValue: state.query, focusNode: searchFocusNode),
        const SizedBox(height: 24),
        _DepartmentChips(state: state),
        const SizedBox(height: 22),
        if (state.filteredProfessors.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Text(
              'No professors found :(',
              textAlign: TextAlign.center,
              style: context.professorBodyMuted,
            ),
          )
        else
          ...state.filteredProfessors.map(
            (professor) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProfessorCard(
                professor: professor,
                onTap: () => context.read<ProfessorRatingBloc>().add(
                  ProfessorRatingProfessorSelected(professor.id),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({required this.initialValue, this.focusNode});

  final String initialValue;
  final FocusNode? focusNode;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
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
      focusNode: widget.focusNode,
      onChanged: (value) => context.read<ProfessorRatingBloc>().add(
        ProfessorRatingSearchChanged(value),
      ),
      style: context.professorBody,
      decoration: InputDecoration(
        hintText: 'Search by name or department',
        hintStyle: context.professorBodyMuted,
        prefixIcon: Icon(
          Icons.search,
          color: palette.textMuted,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: palette.primary),
        ),
      ),
    );
  }
}

class _DepartmentChips extends StatelessWidget {
  const _DepartmentChips({required this.state});

  final ProfessorRatingState state;

  @override
  Widget build(BuildContext context) {
    final palette = context.professorPalette;

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.departments.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final department = state.departments[index];
          final selected = department == state.department;
          return ChoiceChip(
            selected: selected,
            onSelected: (_) => context.read<ProfessorRatingBloc>().add(
              ProfessorRatingDepartmentSelected(department),
            ),
            showCheckmark: false,
            label: Text(department),
            labelStyle: context.professorLabel.copyWith(
              color: selected ? Theme.of(context).colorScheme.onPrimary : palette.textMuted,
            ),
            selectedColor: palette.primary,
            backgroundColor: palette.surface,
            side: BorderSide(
              color: selected
                  ? palette.primary
                  : palette.surfaceVariant,
            ),
            shape: const StadiumBorder(),
          );
        },
      ),
    );
  }
}
