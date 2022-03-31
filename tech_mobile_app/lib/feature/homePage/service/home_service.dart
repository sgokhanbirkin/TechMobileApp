import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';

class HomeService {
  getListQuestions() async {
    var response =
        await FirebaseFirestore.instance.collection('questions').get();

    var allQuestions =
        response.docs.map((e) => Question.fromJson(e.data())).toList();

    return allQuestions;
  }
}
