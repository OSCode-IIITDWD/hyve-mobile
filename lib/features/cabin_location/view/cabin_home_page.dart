import 'package:flutter/material.dart';
import 'package:hyve/features/cabin_location/data/models/prof_model.dart';
import 'package:hyve/features/cabin_location/data/professor_data.dart';
import 'package:hyve/features/cabin_location/widgets/hod_card.dart';
import 'package:hyve/features/cabin_location/widgets/professor_card.dart';
import 'package:hyve/features/cabin_location/widgets/faculty_section.dart';
import 'package:hyve/core/theme/app_theme.dart';

class CabinHomePage extends StatefulWidget {
  const CabinHomePage({super.key});

  @override
  State<CabinHomePage> createState() => _CabinHomePageState();
}

class _CabinHomePageState extends State<CabinHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _searchKey = GlobalKey();
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
  List<ProfessorModel> getGlobalSearchResults() {
    if (_searchQuery.isEmpty) {
      return [];
    }
    return professors.where((prof) {
      bool matchesName = prof.name.toLowerCase().contains(_searchQuery);
      bool matchesCabin = prof.cabin.toLowerCase().contains(_searchQuery);
      bool matchesDept = prof.department.toLowerCase().contains(_searchQuery);
      return matchesName || matchesCabin || matchesDept;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isSearching = _searchQuery.isNotEmpty;

    return DefaultTabController(
      length: _floors.length,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surfaceContainerHighest,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Cabin Location',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  key: _searchKey,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search name or dept...',
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
              ),
            ],
          ),
          bottom: isSearching
              ? null
              : TabBar(
            indicatorColor: context.appColors.primary,
            labelColor: context.appColors.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
          ),
        ),
        body: isSearching ? buildSearchResults() : buildTabViews(),
      ),
    );
  }
  Widget buildSearchResults() {
    List<ProfessorModel> results = getGlobalSearchResults();
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
        ProfessorModel currentProf = results[index];

        if (currentProf.isHod) {
          return HodCard(hod: currentProf);
        } else {
          return ProfessorCard(professor: currentProf);
        }
      },
    );
  }
  Widget buildTabViews() {
    return TabBarView(
      children: _floors.map((floorName) {
        return buildFloorPage(floorName);
      }).toList(),
    );
  }
  Widget buildFloorPage(String floorName) {
    List<ProfessorModel> floorProfs = professors.where((p) => p.floor == floorName).toList();
    ProfessorModel? hod;
    for (var prof in floorProfs) {
      if (prof.isHod) {
        hod = prof;
        break;
      }
    }
    List<ProfessorModel> frontSide = [];
    List<ProfessorModel> backSide = [];

    for (var prof in floorProfs) {
      if (!prof.isHod) {
        if (prof.side == "Front") {
          frontSide.add(prof);
        } else if (prof.side == "Back") {
          backSide.add(prof);
        }
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