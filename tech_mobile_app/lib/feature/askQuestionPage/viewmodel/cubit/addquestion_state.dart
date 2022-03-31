part of 'addquestion_cubit.dart';

@immutable
abstract class AddquestionState {}

class AddquestionInitial extends AddquestionState {}

class AddQuestionComplate extends AddquestionState {
  final File? image;
  AddQuestionComplate(this.image);
}

class CategoryDropDown extends AddquestionState {
  final String? selectedCategory;
  CategoryDropDown(this.selectedCategory);
}
