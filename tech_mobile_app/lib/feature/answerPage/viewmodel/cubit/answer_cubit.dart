import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tech_mobile_app/core/constant/models/answer_model.dart';
import 'package:tech_mobile_app/feature/answerPage/service/answer_service.dart';
import 'package:tech_mobile_app/feature/homePage/view/home_view.dart';

part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> {
  AnswerCubit() : super(AnswerInitial()) {
    _init();
  }

  void _init() async {}

  TextEditingController answerDescription = TextEditingController();
  TextEditingController answerTitle = TextEditingController();

  List icon = [Icons.camera_alt, Icons.image, Icons.remove_circle];
  List iconText = ["Camera", "Gallery", "Remove"];
  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> getCameraImage() async {
    final temporaryImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (temporaryImage == null) return;
    image = File(temporaryImage.path);
    emit(AddAnswerState(image: image));
  }

  Future getGalleryImage() async {
    final temporaryImage = await _picker.pickImage(source: ImageSource.gallery);
    if (temporaryImage == null) return;
    image = File(temporaryImage.path);
    emit(AddAnswerState(image: image));
  }

  void removeImage() {
    image = null;
    emit(AddAnswerState(image: image!));
  }

  Future<void> pushAnswer(BuildContext context) async {
    final user = await FirebaseAuth.instance.currentUser!;

    AnswerService service = AnswerService();
    Answer answer = Answer(
      id: user.uid,
      answerUrl: image?.path,
      postId: "",
      title: answerTitle.text,
      description: answerDescription.text,
    );
    service
        .postComment(
            answerUrl: image?.path ?? "",
            postId: "",
            title: answerTitle.text,
            description: answerDescription.text,
            uid: user.uid)
        .whenComplete(
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => HomeView())),
              (route) => false),
        );
    emit(AddAnswerComplateState(image: image));
  }

  Future<void> getAnswers(BuildContext context) async {
    AnswerService service = AnswerService();
    List<Answer>? answers = await service.getAnswers();
    print('answers: $answers');
    emit(GetAnswersState(allAnswers: answers));
  }
}
