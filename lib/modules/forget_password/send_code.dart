// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/forget_password/cubit/forget_password_states.dart';
import 'package:icu_project/modules/forget_password/submit_code.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../shared/components/components.dart';
import 'cubit/forget_password_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';

class SendCodeScreen extends StatelessWidget {
  SendCodeScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (BuildContext context, state) {
          if (state is ForgetPasswordScusessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubmitCodeScreen(),
              ),
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          var getCubit = ForgetPasswordCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(
              // 1- Icon
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: const Color(0XFF2CBBA9),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
              // 2- App Bar Tittle
              title: defaultTextGabriola(
                text: 'Recover your password',
                fontSize: 35,
              ),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0XFFF2F1F1),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            // 1- Email Text
                            defaultTextSegoe(
                              text: 'Enter your email address',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            // 2- Email
                            defaultTextFeild(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              labelText: 'Email Address',
                              prefix: const AssetImage(
                                'assets/images/UI-UX-Icons/login,signup/email.png',
                              ),
                              submitFunction: (String? value) {
                                return value;
                              },
                              validFunction: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 150,
                            ),
                            // 3- Text
                            defaultTextSegoe(
                              text: 'A code will be send to your',
                            ),
                            defaultTextSegoe(
                              text: 'email address',
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            // 4- Send Code Button
                            ConditionalBuilder(
                              condition: state is! ForgetPasswordLoadingState,
                              builder: (context) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: defaultButton(
                                    buttonFunction: () {
                                      email = emailController.text;
                                      if (formKey.currentState!.validate()) {
                                        ForgetPasswordCubit.getCubit(context)
                                            .userSendCode(
                                          email: emailController.text,
                                        );
                                      }
                                    },
                                    buttonText: 'Send Code',
                                  ),
                                );
                              },
                              fallback: (context) {
                                if (state is ForgetPasswordErrorState) {
                                  String errorMessage =
                                      'An error occurred. Please try again.';
                                  if (state.error is DioError) {
                                    final dioError = state.error as DioError;
                                    if (dioError.response?.statusCode == 400) {
                                      errorMessage =
                                          'Invalid email or password.';
                                    }
                                  }
                                  return Container(
                                    alignment: Alignment.center,
                                    child: defaultButton(
                                      buttonFunction: () {
                                        email = emailController.text;
                                        if (formKey.currentState!.validate()) {
                                          ForgetPasswordCubit.getCubit(context)
                                              .userSendCode(
                                            email: emailController.text,
                                          );
                                        }
                                      },
                                      buttonText: 'Send Code',
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: Color(0XFF196A61)),
                                  );
                                }
                                // return const Center(
                                //   child: CircularProgressIndicator(
                                //       color: Color(0XFF196A61)),
                                // );
                              },
                            )
                          ],
                        ),
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
