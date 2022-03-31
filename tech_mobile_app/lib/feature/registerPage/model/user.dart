import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  String name;
  String email;
  String password;
  String phone;
  String dob;
  bool isTeacher;
  String id;
  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.dob,
      required this.isTeacher,
      required this.id});

  AsyncSnapshot get snapshot => {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'dob': dob,
        'isTeacher': isTeacher,
        'id': id,
      } as AsyncSnapshot<Object?>;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'dob': dob,
      'isTeacher': isTeacher,
      'id': id
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        phone: map['phone'] ?? '',
        dob: map['dob'] ?? '',
        isTeacher: map['isTeacher'] ?? false,
        id: map['id'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'dob': dob,
        'isTeacher': isTeacher,
        'id': id
      };

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        name: snapshot['name'] ?? '',
        email: snapshot['email'] ?? '',
        password: snapshot['password'] ?? '',
        phone: snapshot['phone'] ?? '',
        dob: snapshot['dob'] ?? '',
        isTeacher: snapshot['isTeacher'] ?? false,
        id: snapshot['id'] ?? '');
  }
}
