class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String description;
  final List<String> requirements;
  final Map<String, dynamic> salary;
  final List<String> skills;
  final String status;
  final DateTime? applicationDeadline;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.description,
    required this.requirements,
    required this.salary,
    required this.skills,
    required this.status,
    this.applicationDeadline,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
      company: json['company']['name'] ?? '',
      location: json['location'],
      type: json['type'],
      description: json['description'],
      requirements: List<String>.from(json['requirements'] ?? []),
      salary: json['salary'] ?? {},
      skills: List<String>.from(json['skills'] ?? []),
      status: json['status'],
      applicationDeadline: json['applicationDeadline'] != null
          ? DateTime.parse(json['applicationDeadline'])
          : null,
    );
  }
}
