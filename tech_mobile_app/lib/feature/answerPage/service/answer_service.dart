import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_mobile_app/core/constant/models/answer_model.dart';
import 'package:tech_mobile_app/core/constant/services/storages_methods.dart';
import 'package:uuid/uuid.dart';

class AnswerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postComment({
    required String? postId,
    required String description,
    required String uid,
    required String title,
    required String answerUrl,
    required File file,
  }) async {
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        'comments',
        file,
        true,
      );
      if (description.isNotEmpty) {
        await _firestore.collection('answers').doc(postId).set({
          'description': description,
          'id': uid,
          'title': title,
          'postId': postId,
          'answerUrl': photoUrl,
          'datePublished': DateTime.now()
        });
      } else {
        print("Text is empty------------------------------------");
      }
    } catch (err) {
      print(
        err.toString(),
      );
    }
  }

  Future<List<Answer>?> getAnswers() async {
    try {
      var response = await _firestore.collection('answers').get();
      List<Answer> answers = response.docs.map((doc) {
        return Answer.fromMap(doc.data());
      }).toList();
      return answers;
    } catch (err) {
      print(
        err.toString(),
      );
      return [];
    }
  }
}
