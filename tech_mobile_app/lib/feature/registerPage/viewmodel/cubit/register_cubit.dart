import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tech_mobile_app/feature/homePage/view/home_view.dart';
import 'package:tech_mobile_app/feature/registerPage/service/register_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  bool isLoading = false;
  bool isRegisterFail = false;
  GlobalKey<FormState> formKey = GlobalKey();
  RegisterService registerService = RegisterService();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  bool isTeacher = false;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode dobFocus = FocusNode();

  void register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      changeLoading();
      if (nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        registerService
            .signUp(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          phone: phoneController.text,
          dob: dobController.text,
          isTeacher: isTeacher,
        )
            .catchError((e) {
          emit(RegisterFailure(error: e.toString()));
        });
      }
      if (isRegisterFail == false) {
        registerSuccess(context);
      } else {
        changeLoading();
      }
    }
  }

  void changeRadio(String? value) {
    if (value == 'teacher') {
      isTeacher = true;
    } else {
      isTeacher = false;
    }
    print('isTeacher: $isTeacher');
  }

  void changeLoading() {
    isLoading = !isLoading;
    emit(RegisterLoading(isLoading: isLoading));
  }

  void changeError() {
    isRegisterFail = true;
    emit(RegisterFailure(error: 'Registiration is failed'));
  }

  void registerSuccess(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const HomeView()), (route) => false);
  }
}




/*
 .then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePageView()),
          (route) => false,
        );
      }).catchError((error) {
        print(error);
      });*/