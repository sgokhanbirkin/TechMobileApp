import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kartal/kartal.dart';
import 'package:tech_mobile_app/feature/registerPage/viewmodel/cubit/register_cubit.dart';
import 'package:tech_mobile_app/product/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: registerForm(),
      ),
    );
  }

  Widget registerForm() {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: context.height * 0.25,
                  margin: context.paddingMedium,
                  padding: context.paddingMedium,
                  child: Text(
                    'Create Your Account',
                    style: context.textTheme.displaySmall?.copyWith(
                      color: Colors.pink,
                    ),
                  ),
                ),
                Form(
                  key: context.read<RegisterCubit>().formKey,
                  child: Padding(
                    padding: context.horizontalPaddingLow,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller:
                              context.read<RegisterCubit>().emailController,
                          hintText: 'Email',
                          node: context.read<RegisterCubit>().emailFocus,
                          changeObscureCallBack: () {},
                          validator:
                              RequiredValidator(errorText: 'Required Email'),
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextFormField(
                          controller:
                              context.read<RegisterCubit>().passwordController,
                          hintText: 'Password',
                          isObsecure: true,
                          changeObscureCallBack: () {},
                          node: context.read<RegisterCubit>().passwordFocus,
                          validator:
                              RequiredValidator(errorText: "Required password"),
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextFormField(
                          controller: context
                              .read<RegisterCubit>()
                              .confirmPasswordController,
                          hintText: 'Confirm Password',
                          node: context
                              .read<RegisterCubit>()
                              .confirmPasswordFocus,
                          isObsecure: true,
                          changeObscureCallBack: () {},
                          validator: RequiredValidator(
                            errorText: 'Required Confirm Password',
                          ),
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextFormField(
                          changeObscureCallBack: () {},
                          controller:
                              context.read<RegisterCubit>().nameController,
                          hintText: 'Name',
                          node: context.read<RegisterCubit>().nameFocus,
                          validator: RequiredValidator(
                            errorText: 'Required Name',
                          ),
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextFormField(
                          changeObscureCallBack: () {},
                          controller:
                              context.read<RegisterCubit>().phoneController,
                          hintText: 'Phone',
                          node: context.read<RegisterCubit>().phoneFocus,
                          validator: RequiredValidator(
                            errorText: 'Required Phone',
                          ),
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextFormField(
                          changeObscureCallBack: () {},
                          controller:
                              context.read<RegisterCubit>().dobController,
                          hintText: 'Date of Birth',
                          node: context.read<RegisterCubit>().dobFocus,
                          validator: RequiredValidator(
                            errorText: 'Required Date of Birth',
                          ),
                        ),
                        SizedBox(height: context.height * 0.02),
                        SizedBox(
                          height: context.height * 0.02,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Text('Teacher'),
                                    Radio(
                                      value: context
                                          .read<RegisterCubit>()
                                          .isTeacher,
                                      groupValue: context
                                          .read<RegisterCubit>()
                                          .isTeacher,
                                      onChanged: (value) {
                                        context
                                            .read<RegisterCubit>()
                                            .changeRadio('teacher');
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Text('Student'),
                                    Radio(
                                      value: !context
                                          .read<RegisterCubit>()
                                          .isTeacher,
                                      groupValue: context
                                          .read<RegisterCubit>()
                                          .isTeacher,
                                      onChanged: (value) {
                                        context
                                            .read<RegisterCubit>()
                                            .changeRadio('student');
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.height * 0.02),
                        BlocConsumer<RegisterCubit, RegisterState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                context.read<RegisterCubit>().register(context);
                              },
                              child: Text('Register'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
/**
 * SizedBox(
                        height: context.height * 0.02,
                        child: Row(
                          children: [
                            ListTile(
                              title: Text('Teacher'),
                              leading: Radio(
                                value: 'teacher',
                                groupValue:
                                    context.read<RegisterCubit>().isTeacher
                                        ? 'teacher'
                                        : 'student',
                                onChanged: (value) {
                                  context.read<RegisterCubit>().changeRadio();
                                },
                              ),
                            ),
                            ListTile(
                              title: Text('Student'),
                              leading: Radio(
                                value: 'student',
                                groupValue:
                                    context.read<RegisterCubit>().isTeacher
                                        ? 'teacher'
                                        : 'student',
                                onChanged: (value) {
                                  context.read<RegisterCubit>().changeRadio();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
 */