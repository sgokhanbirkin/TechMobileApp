import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:tech_mobile_app/core/constant/models/answer_model.dart';
import 'package:tech_mobile_app/feature/answerPage/view/answer_view.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';
import 'package:tech_mobile_app/product/comment_card.dart';
import 'package:tech_mobile_app/product/custom_button.dart';

class QuestionDetailView extends StatelessWidget {
  QuestionDetailView({
    Key? key,
    required this.question,
  }) : super(key: key);
  Question? question;
  List<Answer>? answers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Detail'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: card(context),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('answers')
                  .where('postId', isEqualTo: question?.postId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) => CommentCard(
                    snap: (snapshot.data! as dynamic).docs[index],
                  ),
                  itemCount: (snapshot.data! as dynamic).docs.length,
                );
              },
            ),
          ),
          CustomButton(
            text: 'Add Answer',
            isLoading: false,
            func: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnswerView(question: question),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Column localCard(BuildContext context) {
    return Column(
      children: [
        Text(
          question?.name ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: context.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(question?.postUrl ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          question?.description ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget card(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  question?.name ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Column(
                  children: [
                    Text('Category : ${question?.category}'),
                    Text(
                      'Value : ${question?.value}',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: context.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(question?.postUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              question?.description ?? '',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
