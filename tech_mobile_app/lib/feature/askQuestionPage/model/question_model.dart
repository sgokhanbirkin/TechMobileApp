import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_mobile_app/core/constant/models/answer_model.dart';

class Question {
  String? id;
  String? description;
  String? name;
  String? postId;
  var datePublished;
  String? postUrl;
  String? value;
  String? category;
  List<Answer>? answers = [];
  String? userId;
  Question({
    required this.id,
    required this.description,
    required this.name,
    required this.postId,
    required this.postUrl,
    required this.value,
    required this.datePublished,
    required this.category,
    required this.userId,
    this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'username': name,
      'postId': postId,
      'postUrl': postUrl,
      'value': value,
      'datePublished': datePublished,
      'category': category,
      'answers': [],
      'userId': userId,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      description: map['description'],
      name: map['username'],
      postId: map['postId'],
      postUrl: map['postUrl'],
      value: map['value'],
      datePublished: map['datePublished'],
      category: map['category'],
      userId: map['userId'],
      answers: map['answer']
          .map<Answer>((answer) => Answer.fromMap(answer))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'username': name,
        'postId': postId,
        'postUrl': postUrl,
        'value': value,
        'datePublished': datePublished,
        'category': category,
        'answers': answers,
        'userId': userId,
      };

  static Question fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Question(
      id: snapshot['id'],
      description: snapshot['description'],
      name: snapshot['username'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      value: snapshot['value'],
      datePublished: snapshot['datePublished'],
      category: snapshot['category'],
      userId: snapshot['userId'],
      answers: snapshot['answer']
          .map<Answer>((answer) => Answer.fromMap(answer))
          .toList(),
    );
  }

  Question.fromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var _imageData;
    if (json["postUrl"] is String) {
      _imageData = [json["postUrl"]];
    } else {
      _imageData = json["postUrl"];
    }
    id = json['id'];
    description = json['description'];
    name = json['username'];
    postId = json['postId'];
    postUrl = json['postUrl'];
    value = json['value'];
    datePublished = json['datePublished'];
    category = json['category'];
    userId = json['userId'];
  }
}
