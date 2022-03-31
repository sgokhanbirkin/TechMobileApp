part of 'homeview_cubit.dart';

@immutable
abstract class HomeViewState {}

class HomeViewInitial extends HomeViewState {}

class HomeViewComplate extends HomeViewState {
  final List<Question>? allQuestions;
  final List<Answer>? answers;
  HomeViewComplate({this.allQuestions, this.answers});
}
