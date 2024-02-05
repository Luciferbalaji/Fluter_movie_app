class CrewMemberDetails {
  final int id;
  final String name;
  final String profilePath;
  final double rating; // Change the type to double
  final String job;
  final String workingDepartment;

  CrewMemberDetails({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.rating,
    required this.job,
    required this.workingDepartment,
  });

  factory CrewMemberDetails.fromJson(Map<String, dynamic> json) {
    return CrewMemberDetails(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      profilePath: json['profile_path'] as String? ?? '',
      rating: (json['popularity'] as num?)?.toDouble() ?? 0.0, // Convert to double
      job: json['job'] as String? ?? '',
      workingDepartment: json['known_for_department'] as String? ?? '',
    );
  }
}
