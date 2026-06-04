class ProfessorModel {
  final String name;
  final String cabin;
  final String floor;
  final String department;
  final String side;
  final bool isHod;
  final String photo;

  const ProfessorModel({
    required this.name,
    required this.cabin,
    required this.floor,
    required this.department,
    required this.side,
    this.isHod = false,
    required this.photo
  });
}