import 'dart:convert';

class Answer {
  String? title;
  String? id;
  String? postId;
  String? answerUrl;
  String? description;
  Answer({
    required this.title,
    required this.id,
    required this.postId,
    required this.answerUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'postId': postId,
      'answerUrl': answerUrl,
      'description': description,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      title: map['title'],
      id: map['id'],
      postId: map['postId'],
      answerUrl: map['answerUrl'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));
}
