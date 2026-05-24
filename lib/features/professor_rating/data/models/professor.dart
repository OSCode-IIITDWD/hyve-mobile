class Professor {
  const Professor({
    required this.id,
    required this.name,
    required this.department,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.breakdown,
    required this.courses,
    required this.reviews,
    this.isVerified = true,
  });

  final String id;
  final String name;
  final String department;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final RatingBreakdown breakdown;
  final List<ProfessorReview> reviews;
  final Map<String, String> courses;
  final bool isVerified;

  Professor copyWith({
    double? rating,
    int? reviewCount,
    RatingBreakdown? breakdown,
    List<ProfessorReview>? reviews,
  }) {
    return Professor(
      id: id,
      name: name,
      department: department,
      imageUrl: imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      breakdown: breakdown ?? this.breakdown,
      courses: courses,
      reviews: reviews ?? this.reviews,
      isVerified: isVerified,
    );
  }
}

class RatingBreakdown {
  const RatingBreakdown({
    required this.clarity,
    required this.helpful,
    required this.difficulty,
    required this.grading,
  });

  final double clarity;
  final double helpful;
  final double difficulty;
  final double grading;
}

class ProfessorReview {
  const ProfessorReview({
    required this.initial,
    required this.rating,
    required this.clarity,
    required this.helpful,
    required this.difficulty,
    required this.grading,
    required this.course,
    required this.createdAt,
    required this.body,
    this.tags = const [],
  });

  final String initial;
  final int rating;
  final int clarity;
  final int helpful;
  final int difficulty;
  final int grading;
  final String course;
  final DateTime createdAt;
  final String body;
  final List<String> tags;

  String formattedDate({DateTime? now}) {
    final currentTime = now ?? DateTime.now();
    final difference = currentTime.difference(createdAt);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
    if (difference.inHours < 24) return '${difference.inHours} hr ago';
    if (difference.inDays < 7) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    }
    if (difference.inDays < 30) {
      final weeks = difference.inDays ~/ 7;
      return weeks == 1 ? '1 wk ago' : '$weeks wk ago';
    }

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[createdAt.month - 1]} ${createdAt.day}, ${createdAt.year}';
  }
}
