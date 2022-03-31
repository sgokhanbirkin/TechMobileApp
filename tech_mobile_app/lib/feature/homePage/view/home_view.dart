import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:tech_mobile_app/feature/answerPage/viewmodel/cubit/answer_cubit.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';
import 'package:tech_mobile_app/feature/homePage/viewmodel/cubit/homeview_cubit.dart';
import 'package:tech_mobile_app/feature/questionDetailPage/view/question_detail_view.dart';
import 'package:tech_mobile_app/product/bottom_navbar.dart';
import 'package:tech_mobile_app/product/card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewCubit>(
      create: (context) => HomeViewCubit(),
      child: BlocConsumer<HomeViewCubit, HomeViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Home Page'),
            ),
            bottomNavigationBar: BottomNavbar(
              pageid: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: allQuestions(
                          context, context.read<HomeViewCubit>().allQuestions)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget allQuestions(BuildContext context, List<Question>? questions) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: questions?.length ?? 0,
      itemBuilder: (context, index) {
        return CardWidget(
          category: questions?[index].category,
          description: questions?[index].description,
          title: questions?[index].name,
          url: questions?[index].postUrl ?? '',
          value: questions?[index].value,
          date: questions?[index].datePublished,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionDetailView(
                  question: questions?[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
