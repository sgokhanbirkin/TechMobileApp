import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tech_mobile_app/core/constant/app/app_constants.dart';
import 'package:tech_mobile_app/core/constant/language_manager.dart';
import 'package:tech_mobile_app/core/providers/user_provider.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/view/ask_question_view.dart';
import 'package:tech_mobile_app/feature/basketPage/view/basket_view.dart';
import 'package:tech_mobile_app/feature/homePage/view/home_view.dart';
import 'package:tech_mobile_app/feature/loginPage/service/login_service.dart';
import 'package:tech_mobile_app/feature/loginPage/view/login_view.dart';
import 'package:tech_mobile_app/feature/myQuestionsPage/view/my_questions_view.dart';
import 'package:tech_mobile_app/feature/profilePage/view/profileView.dart';
import 'package:tech_mobile_app/feature/registerPage/view/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AsyncSnapshot? snapshot =
    //     Provider.of<UserProvider>(context, listen: false).snapshot;
    // String uid = snapshot?.data.uid ?? "";
    return Provider<LoginService>(
      create: (context) => LoginService(),
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          "/": (context) => LoginView(),
        },
        onGenerateRoute: (settings) {
          List<String> filtered = settings.name!.split('/');
          switch (filtered[1]) {
            case "/homePage":
              return PageTransition(
                child: const HomeView(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: const Duration(seconds: 0),
              );
            case "profilePage":
              return PageTransition(
                child: ProfileView(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: const Duration(seconds: 0),
              );
            case "askQuestionPage":
              return PageTransition(
                child: AskQuestionView(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: const Duration(seconds: 0),
              );
            case "registerPage":
              return PageTransition(
                child: RegisterView(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: const Duration(seconds: 0),
              );
            case "loginPage":
              return PageTransition(
                child: LoginView(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: const Duration(seconds: 0),
              );
            case "myQuestionsPage":
              return PageTransition(
                child: const MyQuestionsView(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: const Duration(seconds: 0),
              );
            case "basketPage":
              return PageTransition(
                child: const BasketView(),
                type: PageTransitionType.fade,
                settings: settings,
                reverseDuration: const Duration(seconds: 0),
              );
          }
        },
      ),
    );
  }
}
