class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final List<String> skills;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.skills,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'role': role,
      'skills': skills,
    };
  }
}
