// Класс Компания
class Company {
  final int id;
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return new Company(id: json['id'], name: json['name']);
  }
}

// Класс Пользователь
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

// Класс Отчет
class Report{
  final String name;
  final String inv_num;
  final String datetime_inv;

  Report({required this.name,required this.inv_num, required this.datetime_inv});

  factory Report.fromJson(Map<String, dynamic> json) {
    return new Report(name: json['name'], inv_num: json['inv_num'], datetime_inv: json['datetime_inv']);
  }
}