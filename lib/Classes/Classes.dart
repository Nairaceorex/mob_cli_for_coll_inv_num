// for dropdownlist
class Company {
  final int id;
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return new Company(id: json['id'], name: json['name']);
  }
}

class User {
  final int id;
  final String fullname;
  final String email;
  final int is_confirm;
  final String company;

  const User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.is_confirm,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
        id: json['id'],
        fullname: json['fullname'],
        email: json['email'],
        is_confirm: json['is_confirm'],
        company: json['company']);
  }
}
