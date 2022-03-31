import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/service/add_question_service.dart';
import 'package:tech_mobile_app/feature/homePage/view/home_view.dart';
part 'addquestion_state.dart';

class AddquestionCubit extends Cubit<AddquestionState> {
  AddquestionCubit() : super(AddquestionInitial()) {
    _init();
  }
  final formKey = GlobalKey<FormState>();
  TextEditingController questionDescription = TextEditingController();
  TextEditingController questionTitle = TextEditingController();
  TextEditingController questionPoint = TextEditingController();
  String? selectedCategory;

  List icon = [Icons.camera_alt, Icons.image, Icons.remove_circle];
  List iconText = ["Camera", "Gallery", "Remove"];
  File? image;
  final ImagePicker _picker = ImagePicker();
  _init() async {}

  Future<void> changeSelectedCategory(String? value) async {
    selectedCategory = value;
    emit(CategoryDropDown(selectedCategory));
  }

  Future<void> getCameraImage() async {
    final temporaryImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (temporaryImage == null) return;
    image = File(temporaryImage.path);
    emit(AddQuestionComplate(image));
  }

  Future getGalleryImage() async {
    final temporaryImage = await _picker.pickImage(source: ImageSource.gallery);
    if (temporaryImage == null) return;
    image = File(temporaryImage.path);
    emit(AddQuestionComplate(image));
  }

  void removeImage() {
    image = null;
    emit(AddQuestionComplate(image!));
  }

  Future<void> pushQuestion(BuildContext context) async {
    final user = await FirebaseAuth.instance.currentUser!;

    AddQuestionService service = AddQuestionService();
    Question question = Question(
      description: questionDescription.text,
      postUrl: image!.path,
      datePublished: DateTime.now(),
      value: questionPoint.text,
      id: user.uid,
      name: questionTitle.text,
      postId: '',
      category: selectedCategory,
      userId: '',
    );
    service.addQuestion(question, image!).whenComplete(
          () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: ((context) => HomeView()),
            ),
            (route) => false,
          ),
        );
    emit(AddQuestionComplate(image));
  }
}
