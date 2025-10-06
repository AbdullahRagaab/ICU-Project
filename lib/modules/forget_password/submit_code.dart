// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/forget_password/reset_password.dart';
import 'package:pinput/pinput.dart';
import 'package:icu_project/modules/forget_password/send_code.dart';
import '../../shared/components/components.dart';
import '../../shared/components/global_variables.dart';
import 'cubit/forget_password_cubit.dart';
import 'cubit/forget_password_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';

class SubmitCodeScreen extends StatelessWidget {
  SubmitCodeScreen({Key? key}) : super(key: key);

  late FocusNode pin2FocusNode;
  var formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (BuildContext context, state) {
          if (state is SubmitCodeScusessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(),
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
                    children: [
                      // 1- Making Code Text
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 120,
                          bottom: 40,
                        ),
                        child: defaultTextSegoe(
                          text: 'Please enter the code',
                        ),
                      ),
                      // 2- Making Pin Code
                      Pinput(
                        length: 4,
                        controller: controller,
                        defaultPinTheme: PinTheme(
                          width: 65,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF6D6A6A),
                            fontFamily: 'Segoe UI',
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        errorTextStyle: TextStyle(
                          color: Colors.red[400],
                          backgroundColor: const Color(0xFFf5c6c0),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ('Please enter code');
                          }
                          return null;
                        },
                        onCompleted: (value) {
                          otp = value.characters.string;
                        },
                      ),
                      // 3- Making Submit Code Button
                      ConditionalBuilder(
                        condition: state is! SubmitCodeLoadingState,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsetsDirectional.only(
                              top: 150,
                              bottom: 40,
                            ),
                            alignment: Alignment.center,
                            child: defaultButton(
                              buttonFunction: () {
                                if (formKey.currentState!.validate()) {
                                  ForgetPasswordCubit.getCubit(context)
                                      .userSubmitCode(
                                    email: email!,
                                    otp: otp!,
                                  );
                                }
                              },
                              buttonText: 'Submit Code',
                            ),
                          );
                        },
                        fallback: (context) {
                          if (state is SubmitCodeErrorState) {
                            String errorMessage =
                                'An error occurred. Please try again.';
                            if (state.error is DioError) {
                              final dioError = state.error as DioError;
                              if (dioError.response?.statusCode == 400) {
                                errorMessage = 'Invalid email or password.';
                              }
                            }
                            return Container(
                              padding: const EdgeInsetsDirectional.only(
                                top: 150,
                                bottom: 40,
                              ),
                              alignment: Alignment.center,
                              child: defaultButton(
                                buttonFunction: () {
                                  if (formKey.currentState!.validate()) {
                                    ForgetPasswordCubit.getCubit(context)
                                        .userSubmitCode(
                                      email: email!,
                                      otp: otp!,
                                    );
                                  }
                                },
                                buttonText: 'Submit Code',
                              ),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: 150,
                                bottom: 40,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Color(0XFF196A61)),
                              ),
                            );
                          }
                          // return const Center(
                          //   child: CircularProgressIndicator(
                          //       color: Color(0XFF196A61)),
                          // );
                        },
                      ),

                      // 3- Making Resend Code Button
                      Container(
                        alignment: Alignment.center,
                        child: defaultButton(
                          buttonFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SendCodeScreen(),
                              ),
                            );
                          },
                          buttonText: 'Resend Code',
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
