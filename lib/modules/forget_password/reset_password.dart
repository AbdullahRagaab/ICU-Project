// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/forget_password/cubit/forget_password_states.dart';
import 'package:icu_project/modules/signin_screen/signin_screen.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../shared/components/components.dart';
import 'cubit/forget_password_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (BuildContext context, state) {
          if (state is ChangePasswordScusessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
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
                text: 'Reset your password',
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
                            // 1- Email
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 80,
                                bottom: 20,
                              ),
                              child: defaultTextFeild(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                isPassword: getCubit.isPassword,
                                labelText: 'Password',
                                prefix: const AssetImage(
                                  'assets/images/UI-UX-Icons/login,signup/lock.png',
                                ),
                                suffix: getCubit.isPassword
                                    ? const AssetImage(
                                        'assets/images/UI-UX-Icons/login,signup/invisable.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/UI-UX-Icons/login,signup/eye.png',
                                      ),
                                onTapSuffixIconFunction: () {
                                  getCubit.isPasswordShown();
                                },
                                submitFunction: (String? value) {
                                  return value;
                                },
                                validFunction: (String? value) {
                                  if (value!.isEmpty) {
                                    return ('Password mustn\'t be empty');
                                  }
                                  return null;
                                },
                              ),
                            ),

                            // 2- Password
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 30,
                                bottom: 100,
                              ),
                              child: defaultTextFeild(
                                isPassword: getCubit.isConfirmPassword,
                                controller: confirmPasswordController,
                                type: TextInputType.visiblePassword,
                                labelText: 'Confirm Password',
                                prefix: const AssetImage(
                                  'assets/images/UI-UX-Icons/login,signup/lock.png',
                                ),
                                suffix: getCubit.isConfirmPassword
                                    ? const AssetImage(
                                        'assets/images/UI-UX-Icons/login,signup/invisable.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/UI-UX-Icons/login,signup/eye.png',
                                      ),
                                onTapSuffixIconFunction: () {
                                  getCubit.isConfirmPasswordShown();
                                },
                                submitFunction: (String? value) {
                                  return value;
                                },
                                validFunction: (String? value) {
                                  if (value!.isEmpty) {
                                    return ('Password mustn\'t be empty');
                                  } else if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    return ('Password does\'t match');
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // 3- Change Your Password Button
                            ConditionalBuilder(
                              condition: state is! ChangePasswordLoadingState,
                              builder: (context) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: defaultButton(
                                    buttonFunction: () {
                                      if (formKey.currentState!.validate()) {
                                        ForgetPasswordCubit.getCubit(context)
                                            .userChangePassword(
                                          email: email!,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    buttonText: 'Change Your Password',
                                  ),
                                );
                              },
                              fallback: (context) {
                                if (state is ChangePasswordErrorState) {
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
                                        if (formKey.currentState!.validate()) {
                                          ForgetPasswordCubit.getCubit(context)
                                              .userChangePassword(
                                            email: email!,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                      buttonText: 'Change Your Password',
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: Color(0XFF196A61)),
                                  );
                                }
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
