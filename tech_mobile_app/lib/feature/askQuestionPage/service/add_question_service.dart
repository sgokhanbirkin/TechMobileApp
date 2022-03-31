import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_mobile_app/core/constant/services/storages_methods.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';
import 'package:uuid/uuid.dart';

class AddQuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addQuestion(Question question, File file) async {
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        'questions',
        file,
        true,
      );

      final user = FirebaseAuth.instance.currentUser!;
      var uid = user.uid;

      String id = const Uuid().v1();
      question.postUrl = photoUrl;
      question.postId = id;
      question.id = id;
      question.userId = uid;
      _firestore.collection('questions').doc(id).set(question.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
