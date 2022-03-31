part of 'answer_cubit.dart';

@immutable
abstract class AnswerState {}

class AnswerInitial extends AnswerState {}

class AddAnswerState extends AnswerState {
  final File? image;
  AddAnswerState({
    this.image,
  });
}

class AddAnswerComplateState extends AnswerState {
  final File? image;
  AddAnswerComplateState({
    this.image,
  });
}

class GetAnswersState extends AnswerState {
  final List<Answer>? allAnswers;
  GetAnswersState({
    this.allAnswers,
  });
}
