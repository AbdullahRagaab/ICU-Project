// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/layout/doctors_layout/doctors_layout.dart';
import 'package:icu_project/modules/admin_screens/admin_home/admin_home.dart';
import 'package:icu_project/modules/signin_screen/login_cubit.dart';
import 'package:icu_project/modules/signin_screen/login_states.dart';
import 'package:icu_project/modules/super_admin_screens/super_admin_home.dart';
import '../../layout/nurse_stuff_layout/nurse_stuff_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../forget_password/send_code.dart';
import '../signup_screen/signup_screen.dart';
import '../tablet_app/patient_notification.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // *** USING BLOC ***
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginScusessState) {
            CacheHelper.saveData(
                key: 'name', value: state.loginModel.user!.name);
            CacheHelper.saveData(key: 'token', value: state.loginModel.token)
                .then((value) {
              CacheHelper.saveData(
                  key: 'role', value: state.loginModel.user!.role);
              if (state.loginModel.user!.role == "superuser" ||
                  state.loginModel.user!.role == "super") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuperAdminHomeScreen(),
                    ),
                    (route) => false);
              } else if (state.loginModel.user!.role == "admin") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminHomeScreen(),
                    ),
                    (route) => false);
              } else if (state.loginModel.user!.role == "nurse") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NurseStuffLayout(),
                    ),
                    (route) => false);
              } else if (state.loginModel.user!.role == "doctor") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DoctorsLayout(),
                    ),
                    (route) => false);
              }else if (state.loginModel.user!.role == "headnursing") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NurseDirectorNotificationScreen(),
                    ),
                        (route) => false);
              }

            });
          }
          //   CacheHelper.saveData(
          //       key: "role", value: state.loginModel.user!.role);
          // if (CacheHelper.getData(key: "role") == "superuser" ||
          //     CacheHelper.getData(key: "role") == "super") {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => SuperAdminHomeScreen(),),
          //           (route) => false
          //   );
          // } else if (CacheHelper.getData(key: "role") == "admin") {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => AdminHomeScreen(),),
          //           (route) => false
          //   );
          // } else if (CacheHelper.getData(key: "role") == "nurse") {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => NurseHomeScreen(),),
          //           (route) => false
          //   );
          // } else if (CacheHelper.getData(key: "role") == "doctor") {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => DoctorHomeScreen(),),
          //           (route) => false
          //   );
          // }
          else if (state is LoginErrorState) {
            print(state.error.toString());
          }
        },
        builder: (BuildContext context, Object? state) {
          var getCubit = LoginCubit.getCubit(context);
          // *** STARTING OG OUR BODY ***
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0XFFF2F1F1),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        // 1- Making Logo Image Of App
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                            top: 130,
                          ),
                          alignment: Alignment.center,
                          child: const Image(
                            image: AssetImage(
                                'assets/images/UI-UX-Photos/welcome-page.png'),
                            width: 95,
                            height: 120,
                          ),
                        ),
                        // 2- Making Welcome Back Message
                        defaultTextGabriola(
                          text: 'Welcome Back !',
                          textAlign: TextAlign.center,
                          fontSize: 46,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        // 3- Make Text Form Fields
                        // 3.1- Email
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 20,
                            bottom: 30,
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
                                return ('Email Address Must Contain @gmail.com');
                              }
                              return null;
                            },
                          ),
                        ),
                        // 3.2- Password
                        defaultTextFeild(
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

                        // 4- Making Forget Password Text Button
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                            end: 20,
                            bottom: 100,
                          ),
                          alignment: Alignment.centerRight,
                          // 1- Text Button
                          child: defaultTextButton(
                            text: 'Forget Password ?',
                            textFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SendCodeScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        // 4- Make Sign In Button
                        BlocBuilder<LoginCubit, LoginStates>(
                            builder: (context, state) {
                          return ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) {
                              return Container(
                                alignment: Alignment.center,
                                child: defaultButton(
                                  buttonFunction: () {
                                    if (formKey.currentState!.validate()) {
                                      print(CacheHelper.getData(
                                          key: 'device_token'));
                                      LoginCubit.getCubit(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          deviceToken: CacheHelper.getData(
                                              key: 'device_token'));
                                    }
                                  },
                                  buttonText: 'Sign In',
                                ),
                              );
                            },
                            fallback: (context) {
                              if (state is LoginErrorState) {
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
                                      print(CacheHelper.getData(
                                          key: 'device_token'));
                                      LoginCubit.getCubit(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          deviceToken: CacheHelper.getData(
                                              key: 'device_token'));
                                    }
                                  },
                                  buttonText: 'Sign In',
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
                          );
                        }),
                        // 5-Sign Up Text Button
                        Container(
                          alignment: Alignment.center,
                          // 1- Text Button
                          child: defaultTextButton(
                            text: 'Don\'t have an account ? Sign up',
                            textFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
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
            ),
          );
        },
      ),
    );
  }
}
