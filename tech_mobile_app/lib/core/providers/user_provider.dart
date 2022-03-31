import 'package:flutter/material.dart';
import 'package:tech_mobile_app/feature/loginPage/service/login_service.dart';
import 'package:tech_mobile_app/feature/registerPage/model/user.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  final LoginService _authMethod = LoginService();

  User get getUser => user!;

  AsyncSnapshot? get snapshot => user?.snapshot;

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    user = user;
    notifyListeners();
  }
}
