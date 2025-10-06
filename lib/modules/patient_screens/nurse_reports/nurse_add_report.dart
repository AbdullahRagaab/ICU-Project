// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../shared/components/components.dart';
import '../add_x_ray_and_medical_tests/medical_test.dart';
import '../add_x_ray_and_medical_tests/x_ray.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'nurse_reports.dart';

class NurseAddReport extends StatefulWidget {
  String? patientID;
  List<String>? doctorID;
  NurseAddReport({Key? key, this.doctorID, this.patientID}) : super(key: key);

  @override
  NurseCurrentReportScreenState createState() =>
      NurseCurrentReportScreenState();
}

class NurseCurrentReportScreenState extends State<NurseAddReport> {
  bool isReadMore = false;
  var reportController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var isListening = false;
  SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NurseReportsCubit, NurseReports>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = NurseReportsCubit.getCubit(context);

          return Scaffold(
            appBar: AppBar(
              // 1- Icon
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NurseReportScreen(),
                    ),
                  );
                },
                color: const Color(0XFF2CBBA9),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
              // 2- App Bar Tittle
              title: defaultTextGabriola(
                text: 'Nurse Reports',
                fontSize: 35,
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 20,
                  bottom: 20,
                  start: 30,
                  end: 30,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                top: 20,
                                start: 20,
                                bottom: 80,
                              ),
                              width: 400,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsetsDirectional.only(
                                        end: 20,
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: FloatingActionButton(
                                          backgroundColor:
                                              const Color(0XFF196A61),
                                          mini: true,
                                          onPressed: () {},
                                          child: GestureDetector(
                                            onTapDown: (details) async {
                                              if (!isListening) {
                                                var available =
                                                    await speechToText
                                                        .initialize();
                                                if (available) {
                                                  setState(() {
                                                    isListening = true;
                                                    speechToText.listen(
                                                      onResult: (result) {
                                                        setState(() {
                                                          reportController
                                                                  .text =
                                                              result
                                                                  .recognizedWords;
                                                        });
                                                      },
                                                    );
                                                  });
                                                }
                                              }
                                            },
                                            onTapUp: (details) {
                                              setState(() {
                                                isListening = false;
                                              });
                                              speechToText.stop();
                                            },
                                            child: Icon(
                                              isListening
                                                  ? Icons.mic
                                                  : Icons.mic_off,
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 50),
                                      child: TextFormField(
                                        controller: reportController,
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Add New Text Report Using Recording Or Typing...',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF000000),
                                          fontFamily: 'Segoe UI',
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ConditionalBuilder(
                          condition: state is! AddReportLoadingState,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(
                              top: 150,
                            ),
                            child: secondaryDefaultButton(
                                buttonFunction: () {
                                  if (formKey.currentState!.validate()) {
                                    print(reportController.text);
                                    print(patientId);
                                    print(doctorOrNurseId);
                                    getCubit.AddNurseReport(
                                      title: reportController.text,
                                      patientID: patientId!,
                                      // doctorID: doctorOrNurseId!,
                                    );
                                  }
                                },
                                buttonText: 'Add Report'),
                          ),
                          fallback: (context) {
                            if (state is AddReportErrorState) {
                              String errorMessage =
                                  'An error occurred. Please try again.';
                              if (state.error is DioError) {
                                final dioError = state.error as DioError;
                                if (dioError.response?.statusCode == 400) {
                                  errorMessage = 'Invalid email or password.';
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 150,
                                ),
                                child: secondaryDefaultButton(
                                    buttonFunction: () {
                                      if (formKey.currentState!.validate()) {
                                        print(reportController.text);
                                        print(patientId);
                                        print(doctorOrNurseId);
                                        getCubit.AddNurseReport(
                                          title: reportController.text,
                                          patientID: patientId!,
                                          // doctorID: doctorOrNurseId!,
                                        );
                                      }
                                    },
                                    buttonText: 'Add Report'),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 150,
                                ),
                                child: secondaryDefaultButton(
                                  buttonColors: [Colors.grey, Colors.grey],
                                  textColor: Colors.black,
                                  buttonFunction: () {},
                                  buttonText: 'Add Report',
                                ),
                              );
                            }
                            // return const Center(
                            //   child: CircularProgressIndicator(
                            //       color: Color(0XFF196A61)),
                            // );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                          ),
                          child: secondaryDefaultButton(
                              buttonFunction: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            title: Center(
                                              child: defaultTextSegoe(
                                                text:
                                                    "Add XRay Or Medical Test",
                                                color: const Color(0XFF43494B),
                                                fontSize: 20,
                                              ),
                                            ),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .only(
                                                        top: 10,
                                                        bottom: 30,
                                                      ),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const XRayScreen(),
                                                              ));
                                                        },
                                                        child: Container(
                                                            width: 150,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  blurRadius: 6,
                                                                  blurStyle:
                                                                      BlurStyle
                                                                          .outer,
                                                                )
                                                              ],
                                                            ),
                                                            child: const Center(
                                                                child: Text(
                                                                    'XRay'))),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MedicalTestScreen(),
                                                            ));
                                                      },
                                                      child: Container(
                                                          width: 150,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                blurRadius: 6,
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .outer,
                                                              )
                                                            ],
                                                          ),
                                                          child: const Center(
                                                              child: Text(
                                                                  'Medical Tests'))),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    });
                              },
                              buttonText: 'Add X-Ray'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
