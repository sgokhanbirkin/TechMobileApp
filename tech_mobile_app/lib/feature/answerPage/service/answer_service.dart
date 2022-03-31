import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_mobile_app/core/constant/models/answer_model.dart';
import 'package:uuid/uuid.dart';

class AnswerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postComment({
    required String postId,
    required String description,
    required String uid,
    required String title,
    required String answerUrl,
  }) async {
    try {
      if (description.isNotEmpty) {
        String postId = const Uuid().v1();
        await _firestore.collection('answers').doc(postId).set({
          'description': description,
          'id': uid,
          'title': title,
          'postId': postId,
          'answerUrl': answerUrl,
          'datePublished': DateTime.now()
        });
      } else {
        print("Text is empty");
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
      print("RESPONSEEEEEEEEE ::::::: $response");
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
