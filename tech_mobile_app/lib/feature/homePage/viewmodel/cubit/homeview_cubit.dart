import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tech_mobile_app/core/constant/models/answer_model.dart';
import 'package:tech_mobile_app/feature/answerPage/service/answer_service.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';
import 'package:tech_mobile_app/feature/homePage/service/home_service.dart';

part 'homeview_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit() : super(HomeViewInitial()) {
    _init();
  }

  List<Question>? allQuestions;
  List<Answer>? answers;

  Future<void> _init() async {
    allQuestions = await HomeService().getListQuestions();
    emit(
      HomeViewComplate(allQuestions: allQuestions),
    );
  }

  Future<void> getAnswers() async {
    AnswerService service = AnswerService();
    answers = await service.getAnswers();
  }
}
