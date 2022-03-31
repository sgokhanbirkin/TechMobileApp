import 'dart:convert';

class Student {
  String name;
  String email;
  String password;
  String phone;
  String dob;
  Student({
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

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      dob: map['dob'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));
}
