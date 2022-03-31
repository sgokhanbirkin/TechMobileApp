import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:tech_mobile_app/feature/answerPage/viewmodel/cubit/answer_cubit.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';
import 'package:tech_mobile_app/product/custom_button.dart';

class AnswerView extends StatelessWidget {
  AnswerView({Key? key, required this.question}) : super(key: key);
  Question? question;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnswerCubit>(
      create: (context) => AnswerCubit(),
      child: BlocConsumer<AnswerCubit, AnswerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Answer Page'),
            ),
            body: Container(
              padding: context.paddingLow,
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            context.read<AnswerCubit>().image == null
                                ? Container(
                                    padding: EdgeInsets.all(context.width / 10),
                                    height: context.height / 5,
                                    width: context.width * 2 / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: context.highBorderRadius,
                                      color: Colors.red,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.red,
                                        size: context.width / 7,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: context.height / 5,
                                    width: context.width * 2 / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: context.highBorderRadius,
                                    ),
                                    child: Image.file(
                                        context.read<AnswerCubit>().image!),
                                  ),
                            Container(
                              padding: context.paddingLow,
                              height: context.height / 4,
                              width: context.width / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //selecting event photo
                                  for (var i = 0; i < 3; i++)
                                    InkWell(
                                      onTap: () => i == 0
                                          ? context
                                              .read<AnswerCubit>()
                                              .getCameraImage()
                                          : i == 1
                                              ? context
                                                  .read<AnswerCubit>()
                                                  .getGalleryImage()
                                              : context
                                                  .read<AnswerCubit>()
                                                  .removeImage(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(context
                                              .read<AnswerCubit>()
                                              .icon[i]),
                                          Text(context
                                              .read<AnswerCubit>()
                                              .iconText[i])
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.height / 10,
                        child: TextFormField(
                          // key: ValueKey(valKey),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'null';
                            }
                            return null;
                          },

                          controller: context.read<AnswerCubit>().answerTitle,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20.0),
                            hintText: 'Title',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height / 10,
                        child: TextFormField(
                          // key: ValueKey(valKey),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'null';
                            }
                            return null;
                          },

                          controller:
                              context.read<AnswerCubit>().answerDescription,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20.0),
                            hintText: 'Description',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        text: 'Ekle',
                        isLoading: false,
                        func: () {
                          context.read<AnswerCubit>().pushAnswer(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
