import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:tech_mobile_app/core/constant/models/category_model.dart';
import 'package:tech_mobile_app/core/constant/services/firestore_methods.dart';
import 'package:tech_mobile_app/core/providers/user_provider.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/viewmodel/cubit/addquestion_cubit.dart';
import 'package:tech_mobile_app/feature/registerPage/model/user.dart';
import 'package:tech_mobile_app/product/bottom_navbar.dart';
import 'package:tech_mobile_app/product/custom_button.dart';
import 'package:tech_mobile_app/product/utils.dart';

class AskQuestionView extends StatefulWidget {
  const AskQuestionView({Key? key}) : super(key: key);

  @override
  State<AskQuestionView> createState() => _AskQuestionViewState();
}

class _AskQuestionViewState extends State<AskQuestionView> {
  List<CategoryModel> categories = [
    CategoryModel(name: 'math', id: '1'),
    CategoryModel(name: 'physics', id: '2'),
    CategoryModel(name: 'chemistry', id: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddquestionCubit>(
      create: (context) => AddquestionCubit(),
      child: BlocConsumer<AddquestionCubit, AddquestionState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
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
                            context.read<AddquestionCubit>().image == null
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
                                    child: Image.file(context
                                        .read<AddquestionCubit>()
                                        .image!),
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
                                              .read<AddquestionCubit>()
                                              .getCameraImage()
                                          : i == 1
                                              ? context
                                                  .read<AddquestionCubit>()
                                                  .getGalleryImage()
                                              : context
                                                  .read<AddquestionCubit>()
                                                  .removeImage(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(context
                                              .read<AddquestionCubit>()
                                              .icon[i]),
                                          Text(context
                                              .read<AddquestionCubit>()
                                              .iconText[i])
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      DropdownButton(
                        value:
                            context.read<AddquestionCubit>().selectedCategory,
                        items: categories
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e.name,
                                ))
                            .toList(),
                        onChanged: (String? value) => context
                            .read<AddquestionCubit>()
                            .changeSelectedCategory(value),
                        isExpanded: true,
                        hint: Text(
                          'Category',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(''),
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

                              controller: context
                                  .read<AddquestionCubit>()
                                  .questionTitle,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0),
                                hintText: 'Adı',
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall,
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

                              controller: context
                                  .read<AddquestionCubit>()
                                  .questionPoint,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0),
                                hintText: 'Puanı',
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall,
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
                            height: context.height / 5,
                            child: TextFormField(
                              // key: ValueKey(valKey),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'null';
                                }
                                return null;
                              },

                              controller: context
                                  .read<AddquestionCubit>()
                                  .questionDescription,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0),
                                hintText: 'Açıklama',
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall,
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
                              context
                                  .read<AddquestionCubit>()
                                  .pushQuestion(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavbar(
              pageid: 1,
            ),
          );
        },
      ),
    );
  }
}
