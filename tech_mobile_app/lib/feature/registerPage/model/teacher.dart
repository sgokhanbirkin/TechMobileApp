import 'dart:convert';

class Teacher {
  String name;
  String email;
  String password;
  String phone;
  String dob;
  Teacher({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.dob,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'dob': dob,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      dob: map['dob'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source));
}
