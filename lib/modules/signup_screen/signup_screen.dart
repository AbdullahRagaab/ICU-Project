// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/signup_screen/signup_cubit.dart';
import 'package:icu_project/modules/signup_screen/signup_states.dart';
import '../../shared/components/components.dart';
import '../signin_screen/signin_screen.dart';

class SignUpScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var userNameController = TextEditingController();

  var telephoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // *** USING BLOC ***
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (BuildContext context, state) {
          if (state is SignUpScusessState) {
            Fluttertoast.showToast(
              msg: state.loginModel.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          var getSignUpCubit = SignUpCubit.getCubit(context);
          // *** STARTING OG OUR BODY ***
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0XFFF2F1F1),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 1- Making Logo Image Of App
                      Container(
                        padding: const EdgeInsets.only(
                          top: 90,
                        ),
                        alignment: Alignment.center,
                        child: const Image(
                          image: AssetImage(
                            'assets/images/UI-UX-Photos/welcome-page.png',
                          ),
                          width: 95,
                          height: 120,
                        ),
                      ),
                      // 2- Making Create Account Message
                      defaultTextGabriola(
                        text: 'Create your account',
                        textAlign: TextAlign.center,
                        fontSize: 46,
                      ),
                      // 3- Make Text Form Fields
                      // 3.1- Name
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 30,
                          end: 30,
                          top: 20,
                        ),
                        child: defaultTextFeild(
                          controller: nameController,
                          type: TextInputType.name,
                          labelText: 'Name',
                          prefix: const AssetImage(
                            'assets/images/UI-UX-Icons/login,signup/name.png',
                          ),
                          submitFunction: (String? value) {
                            return value;
                          },
                          validFunction: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name mustn\'t be empty';
                            } else if (value.length < 3) {
                              return ('This name is too short');
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 30,
                          end: 30,
                          top: 30,
                        ),
                        child: defaultTextFeild(
                          controller: userNameController,
                          type: TextInputType.name,
                          labelText: 'UserName',
                          prefix: const AssetImage(
                            'assets/images/UI-UX-Icons/login,signup/name.png',
                          ),
                          submitFunction: (String? value) {
                            return value;
                          },
                          validFunction: (String? value) {
                            if (value!.isEmpty) {
                              return 'User Name mustn\'t be empty';
                            } else if (value.length < 3) {
                              return ('This user name is too short');
                            }
                            return null;
                          },
                        ),
                      ),
                      // 3.2- Email
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 30,
                          end: 30,
                          bottom: 30,
                          top: 30,
                        ),
                        child: defaultTextFeild(
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
                              return ('Email Address mustn\'t be empty');
                            } else if (!value.contains('@gmail.com')) {
                              return ('Email Address must contain @gmail.com ');
                            } else if (!value.contains(RegExp(r'[0-9]'))) {
                              return ('Email Address must contain at least one number');
                            }
                            return null;
                          },
                        ),
                      ),
                      // 3.3- Telephone Number
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 30,
                          end: 30,
                        ),
                        child: defaultTextFeild(
                          controller: telephoneController,
                          type: TextInputType.number,
                          labelText: 'Telephone Number',
                          prefix: const AssetImage(
                            'assets/images/UI-UX-Icons/login,signup/telephone_number.png',
                          ),
                          submitFunction: (String? value) {
                            return value;
                          },
                          validFunction: (String? value) {
                            if (value!.isEmpty) {
                              return 'Telephone Number mustn\'t be empty';
                            } else if (value.length < 11) {
                              return ('This is non valid number');
                            }
                            return null;
                          },
                        ),
                      ),
                      // 3.4- Password
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 30,
                          end: 30,
                          top: 30,
                          bottom: 30,
                        ),
                        child: defaultTextFeild(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: getSignUpCubit.isPassword,
                          labelText: 'Password',
                          prefix: const AssetImage(
                            'assets/images/UI-UX-Icons/login,signup/lock.png',
                          ),
                          suffix: getSignUpCubit.isPassword
                              ? const AssetImage(
                                  'assets/images/UI-UX-Icons/login,signup/invisable.png',
                                )
                              : const AssetImage(
                                  'assets/images/UI-UX-Icons/login,signup/eye.png',
                                ),
                          onTapSuffixIconFunction: () {
                            getSignUpCubit.isPasswordShown();
                          },
                          submitFunction: (String? value) {
                            return value;
                          },
                          validFunction: (String? value) {
                            if (value!.isEmpty) {
                              return ('Password mustn\'t be empty');
                            } else if (value.length < 10) {
                              return ('Password is too short');
                            } else if (!value.contains(RegExp(r'[A-Z]'))) {
                              return ('Password must contain at least one upper char');
                            } else if (!value.contains(RegExp(r'[a-z]'))) {
                              return ('Password must contain at least one lower char');
                            }
                            return null;
                          },
                        ),
                      ),
                      // 3.5- Confirm Password
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 30,
                          end: 30,
                          bottom: 30,
                        ),
                        child: defaultTextFeild(
                          isPassword: getSignUpCubit.isConfirmPassword,
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          labelText: 'Confirm Password',
                          prefix: const AssetImage(
                            'assets/images/UI-UX-Icons/login,signup/lock.png',
                          ),
                          suffix: getSignUpCubit.isConfirmPassword
                              ? const AssetImage(
                                  'assets/images/UI-UX-Icons/login,signup/invisable.png',
                                )
                              : const AssetImage(
                                  'assets/images/UI-UX-Icons/login,signup/eye.png',
                                ),
                          onTapSuffixIconFunction: () {
                            getSignUpCubit.isConfirmPasswordShown();
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

                      // 4- Make Sign Up Button
                      ConditionalBuilder(
                        condition: state is! SignUpLoadingState,
                        builder: (context) => Container(
                          alignment: Alignment.center,
                          child: defaultButton(
                            buttonFunction: () {
                              if (formKey.currentState!.validate()) {
                                getSignUpCubit.userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    userName: userNameController.text,
                                    phone: telephoneController.text,
                                    password: passwordController.text);
                              }
                            },
                            buttonText: 'Sign Up',
                          ),
                        ),
                        fallback: (context) {
                          if (state is SignUpErrorState) {
                            String errorMessage =
                                'An error occurred. Please try again.';
                            if (state.error is DioError) {
                              final dioError = state.error as DioError;
                              if (dioError.response?.statusCode == 400) {
                                errorMessage = 'Invalid email or password.';
                              }
                            }
                            return Container(
                              alignment: Alignment.center,
                              child: defaultButton(
                                buttonFunction: () {
                                  if (formKey.currentState!.validate()) {
                                    getSignUpCubit.userRegister(
                                        email: emailController.text,
                                        name: nameController.text,
                                        userName: userNameController.text,
                                        phone: telephoneController.text,
                                        password: passwordController.text);
                                  }
                                },
                                buttonText: 'Sign Up',
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
                      ),
                      // 5- Sign In Text Button
                      Container(
                        alignment: Alignment.center,
                        // 1- Text Button
                        child: defaultTextButton(
                          text: 'Already have an account ? Sign in',
                          textFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
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
