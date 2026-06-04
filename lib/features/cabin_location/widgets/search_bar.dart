import 'package:flutter/material.dart';
import 'package:hyve/features/cabin_location/data/models/prof_model.dart';
import 'package:hyve/features/cabin_location/data/professor_data.dart';
import 'hod_card.dart';
import 'professor_card.dart';
import 'faculty_section.dart';
import 'package:hyve/core/theme/app_theme.dart';

class CabinHomeScreen extends StatefulWidget {
  const CabinHomeScreen({super.key});

  @override
  State<CabinHomeScreen> createState() => _CabinHomeScreenState();
}

class _CabinHomeScreenState extends State<CabinHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<String> _floors = [
    "Upper Ground Floor",
    "First Floor",
    "Second Floor",
    "Third Floor"
  ];

  final List<String> _tabLabels = ["UG", "1st", "2nd", "3rd"];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  List<ProfessorModel> getSearchResults() {
    if (_searchQuery.isEmpty) return [];

    return professors.where((prof) {
      bool matchName = prof.name.toLowerCase().contains(_searchQuery);
      bool matchCabin = prof.cabin.toLowerCase().contains(_searchQuery);
      bool matchDept = prof.department.toLowerCase().contains(_searchQuery);

      return matchName || matchCabin || matchDept;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColors;
    bool isSearching = _searchQuery.isNotEmpty;

    return DefaultTabController(
      length: _floors.length,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surfaceContainerHighest,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search name, cabin, or dept...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: isSearching
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  FocusScope.of(context).unfocus();
                },
              )
                  : null,
            ),
          ),
          bottom: isSearching
              ? null
              : TabBar(
            indicatorColor: appColors.primary,
            labelColor: appColors.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
          ),
        ),
        body: isSearching ? buildSearchResults() : buildTabViews(),
      ),
    );
  }
  Widget buildSearchResults() {
    List<ProfessorModel> results = getSearchResults();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No faculty found matching "$_searchQuery"',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: results.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        ProfessorModel prof = results[index];
        return prof.isHod ? HodCard(hod: prof) : ProfessorCard(professor: prof);
      },
    );
  }
  Widget buildTabViews() {
    return TabBarView(
      children: _floors.map((floor) {
        return buildFloorPage(floor);
      }).toList(),
    );
  }
  Widget buildFloorPage(String floorName) {
    List<ProfessorModel> floorProfs = professors.where((p) => p.floor == floorName).toList();
    ProfessorModel? hod;
    List<ProfessorModel> frontSide = [];
    List<ProfessorModel> backSide = [];
    for (var prof in floorProfs) {
      if (prof.isHod) {
        hod = prof;
      } else if (prof.side == "Front") {
        frontSide.add(prof);
      } else if (prof.side == "Back") {
        backSide.add(prof);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hod != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: HodCard(hod: hod),
            ),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: FacultySection(title: "Front Side", professors: frontSide)),
                    const SizedBox(width: 24),
                    Expanded(child: FacultySection(title: "Back Side", professors: backSide)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    FacultySection(title: "Front Side", professors: frontSide),
                    const SizedBox(height: 24),
                    FacultySection(title: "Back Side", professors: backSide),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}