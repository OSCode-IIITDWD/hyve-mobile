import 'package:hyve/features/professor_rating/data/models/professor.dart';

class ProfessorRatingService {
  Future<List<Professor>> fetchProfessors() async {
    return _professors;
  }

  Future<Professor> submitReview({
    required Professor professor,
    required int overall,
    required int clarity,
    required int helpful,
    required int difficulty,
    required int grading,
    required String course,
    required String body,
  }) async {
    final review = ProfessorReview(
      initial: 'Y',
      rating: overall,
      clarity: clarity,
      helpful: helpful,
      difficulty: difficulty,
      grading: grading,
      course: course.trim(),
      createdAt: DateTime.now(),
      body: body.trim(),
    );

    final nextReviews = [review, ...professor.reviews];

    return professor.copyWith(
      rating: _averageReviewValue(nextReviews, (item) => item.rating),
      reviewCount: nextReviews.length,
      breakdown: RatingBreakdown(
        clarity: _averageReviewValue(nextReviews, (item) => item.clarity),
        helpful: _averageReviewValue(nextReviews, (item) => item.helpful),
        difficulty: _averageReviewValue(nextReviews, (item) => item.difficulty),
        grading: _averageReviewValue(nextReviews, (item) => item.grading),
      ),
      reviews: nextReviews,
    );
  }
}

double _averageReviewValue(
  List<ProfessorReview> reviews,
  int Function(ProfessorReview review) selector,
) {
  final total = reviews.fold<int>(0, (sum, review) => sum + selector(review));
  return double.parse((total / reviews.length).toStringAsFixed(1));
}

final _professors = [
  Professor(
    id: 'animesh-roy',
    name: 'Dr. Animesh Roy',
    department: 'Computer Science and Engineering',
    imageUrl: 'https://iiitdwd.ac.in/images/Dr.AnimeshRoy.jpg',
    rating: 4.7,
    reviewCount: 3,
    breakdown: RatingBreakdown(
      clarity: 4.7,
      helpful: 4.7,
      difficulty: 3.3,
      grading: 4.7,
    ),
    courses: {
      'CS 206': "Theory of Computing (Sem-IV)",
      'CS 165': "Mathematical Foundations of Computing (Sem-II)",
      'CS 303': "Computer Networks (Sem-V)",
    },
    reviews: [
      ProfessorReview(
        initial: 'S',
        rating: 5,
        clarity: 5,
        helpful: 5,
        difficulty: 3,
        grading: 5,
        course: 'CS 240',
        createdAt: DateTime(2023, 10, 12),
        body:
            'Incredible professor. He actually takes the time to explain complex data structures until everyone gets it. Exams are fair, mostly based on lecture slides and assignments. Highly recommend going to office hours!',
      ),
      ProfessorReview(
        initial: 'A',
        rating: 4,
        clarity: 4,
        helpful: 4,
        difficulty: 3,
        grading: 4,
        course: 'CS 101',
        createdAt: DateTime(2023, 9, 28),
        body:
            'Great intro class. The projects are actually fun and relevant to real-world coding. He talks a bit fast sometimes, but all lectures are recorded so you can review them later.',
      ),
      ProfessorReview(
        initial: 'N',
        rating: 5,
        clarity: 5,
        helpful: 5,
        difficulty: 4,
        grading: 5,
        course: 'CS 206',
        createdAt: DateTime(2023, 8, 18),
        body:
            'Theory-heavy course, but the examples made automata and reductions much easier to follow. Assignments were challenging without feeling random.',
      ),
    ],
  ),
  Professor(
    id: 'pramod-yelmewad',
    name: 'Dr. Pramod Yelmewad',
    department: 'Computer Science and Engineering',
    imageUrl: 'https://iiitdwd.ac.in/images/Dr.PramodYelmewad.jpg',
    rating: 5.0,
    reviewCount: 1,
    breakdown: RatingBreakdown(
      clarity: 5.0,
      helpful: 5.0,
      difficulty: 3.0,
      grading: 5.0,
    ),
    courses: {
      'CS 310': "Database Management System",
      'CS 207': "Object Oriented Programming",
      'CS 463': "Parallel Computing",
    },
    reviews: [
      ProfessorReview(
        initial: 'M',
        rating: 5,
        clarity: 5,
        helpful: 5,
        difficulty: 3,
        grading: 5,
        course: 'UX 402',
        createdAt: DateTime(2023, 11, 2),
        body:
            'The critiques are direct but always useful. Every project leaves you with a stronger portfolio piece.',
      ),
    ],
  ),
  Professor(
    id: 'ramesh-athe',
    name: 'Dr. Ramesh Athe',
    department: 'Data Science and Artificial Intelligence',
    imageUrl: 'https://iiitdwd.ac.in/images/Dr.RameshAthe.jpg',
    rating: 4.0,
    reviewCount: 1,
    breakdown: RatingBreakdown(
      clarity: 4.0,
      helpful: 4.0,
      difficulty: 4.0,
      grading: 3.0,
    ),
    courses: {'MA 201': "Statistics"},
    reviews: [
      ProfessorReview(
        initial: 'R',
        rating: 4,
        clarity: 4,
        helpful: 4,
        difficulty: 4,
        grading: 3,
        course: 'BUS 330',
        createdAt: DateTime(2023, 8, 18),
        body:
            'Case studies are excellent, but the workload stacks up quickly near finals.',
      ),
    ],
  ),
];
