// for dropdownlist
class Company {
  int? id;
  String? name;

  Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return new Company(id: json['id'], name: json['name']);
  }
}

class User {
  final int id;
  final String fullname;
  final String email;
  final bool confirm;
  final String company;

  const User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.confirm,
    required this.company,
  });
}
