// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_cubit.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/global_variables.dart';
import 'doctor_add_report.dart';

class DoctorAddXray extends StatefulWidget {
  const DoctorAddXray({Key? key}) : super(key: key);

  @override
  State<DoctorAddXray> createState() => _DoctorAddXrayState();
}

class _DoctorAddXrayState extends State<DoctorAddXray> {
  var xrayController = TextEditingController();

  var medicalTestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (context, state) {
        if (state is AddXrayScusessState) {
          Fluttertoast.showToast(
            msg: UserSignUpCubit.getCubit(context).addXray!.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorAddReport(),
              )));
        }
        if (state is AddMedicalScusessState) {
          Fluttertoast.showToast(
            msg: UserSignUpCubit.getCubit(context).addMedicalTest!.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorAddReport(),
              )));
        }
      },
      builder: (context, state) {
        var getCubit = UserSignUpCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            // 1- Icon
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DoctorAddReport()));
              },
              color: const Color(0XFF2CBBA9),
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
            // 2- App Bar Tittle
            title: defaultTextGabriola(
              text: 'Add X-Ray And Medical Test',
              fontSize: 34,
            ),
          ),
          body: ConditionalBuilder(
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
            condition: true,
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    defaultTextSegoe(
                        text: 'X-ray Name',
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 5,
                      ),
                      child: Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: xrayController,
                            autofocus: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              labelStyle: TextStyle(
                                color: Color(0xFF6D6A6A),
                                fontFamily: 'Segoe UI',
                                fontSize: 15,
                              ),
                            ),
                            cursorColor: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! AddXrayLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            secondaryDefaultButton(
                              buttonFunction: () {
                                UserSignUpCubit.getCubit(context).postAddXray(
                                    patientID: patientId!,
                                    name: xrayController.text);
                              },
                              buttonText: 'ADD',
                              buttonwidth: 120,
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) {
                        if (state is AddXrayErrorState) {
                          String errorMessage =
                              'An error occurred. Please try again.';
                          if (state.error is DioError) {
                            final dioError = state.error as DioError;
                            if (dioError.response?.statusCode == 400) {
                              errorMessage = 'Invalid email or password.';
                            }
                          }
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                secondaryDefaultButton(
                                  buttonFunction: () {
                                    UserSignUpCubit.getCubit(context)
                                        .postAddXray(
                                            patientID: patientId!,
                                            name: xrayController.text);
                                  },
                                  buttonText: 'ADD',
                                  buttonwidth: 120,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                secondaryDefaultButton(
                                  buttonColors: [Colors.grey, Colors.grey],
                                  textColor: Colors.black,
                                  buttonFunction: () {},
                                  buttonText: 'ADD',
                                  buttonwidth: 120,
                                ),
                              ],
                            ),
                          );
                        }
                        // return const Center(
                        //   child: CircularProgressIndicator(
                        //       color: Color(0XFF196A61)),
                        // );
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.only(
                    //     end: 15,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       secondaryDefaultButton(
                    //         buttonFunction: () {
                    //           UserSignUpCubit.getCubit(context).postAddXray(
                    //               patientID: patientId!,
                    //               name: xrayController.text);
                    //         },
                    //         buttonText: 'ADD',
                    //         buttonwidth: 120,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 80,
                    ),
                    defaultTextSegoe(
                      text: 'Medical Test Name',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 5,
                      ),
                      child: Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: medicalTestController,
                            autofocus: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              labelStyle: TextStyle(
                                color: Color(0xFF6D6A6A),
                                fontFamily: 'Segoe UI',
                                fontSize: 15,
                              ),
                            ),
                            cursorColor: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! AddMedicalLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            secondaryDefaultButton(
                              buttonFunction: () async {
                                UserSignUpCubit.getCubit(context)
                                    .postAddMedicalTest(
                                        patientID: patientId!,
                                        name: medicalTestController.text);

                                // here we will send notification
                              },
                              buttonText: 'ADD',
                              buttonwidth: 120,
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) {
                        if (state is AddMedicalErrorState) {
                          String errorMessage =
                              'An error occurred. Please try again.';
                          if (state.error is DioError) {
                            final dioError = state.error as DioError;
                            if (dioError.response?.statusCode == 400) {
                              errorMessage = 'Invalid email or password.';
                            }
                          }
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                secondaryDefaultButton(
                                  buttonFunction: () async {
                                    UserSignUpCubit.getCubit(context)
                                        .postAddMedicalTest(
                                            patientID: patientId!,
                                            name: medicalTestController.text);

                                    // here we will send notification
                                  },
                                  buttonText: 'ADD',
                                  buttonwidth: 120,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                secondaryDefaultButton(
                                  buttonColors: [Colors.grey, Colors.grey],
                                  textColor: Colors.black,
                                  buttonFunction: () {},
                                  buttonText: 'ADD',
                                  buttonwidth: 120,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.only(
                    //     end: 15,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       secondaryDefaultButton(
                    //         buttonFunction: () async {
                    //           UserSignUpCubit.getCubit(context)
                    //               .postAddMedicalTest(
                    //                   patientID: patientId!,
                    //                   name: medicalTestController.text);

                    //           // here we will send notification
                    //         },
                    //         buttonText: 'ADD',
                    //         buttonwidth: 120,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
