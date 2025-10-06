// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/cubit.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/states.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../shared/components/components.dart';
import 'doctor_add_medicine.dart';
import 'doctor_add_x_ray_and_medical_tests.dart';
import 'doctor_reports.dart';

class DoctorAddReport extends StatefulWidget {
  String? patientID;
  List<String>? doctorID;
  DoctorAddReport({Key? key, this.doctorID, this.patientID}) : super(key: key);

  @override
  DoctorCurrentReportScreenState createState() =>
      DoctorCurrentReportScreenState();
}

class DoctorCurrentReportScreenState extends State<DoctorAddReport> {
  bool isReadMore = false;
  var reportController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var isListening = false;
  SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorReportsCubit, DoctorReports>(
        listener: (BuildContext context, state) {
      if (state is AddDoctorReportScusessState) {
        Fluttertoast.showToast(
          msg: DoctorReportsCubit.getCubit(context).adddoctorReport!.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0,
        ).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorReportScreen(),
            )));
      }
    }, builder: (BuildContext context, Object? state) {
      var getCubit = DoctorReportsCubit.getCubit(context);
      return Scaffold(
        appBar: AppBar(
          // 1- Icon
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorReportScreen(),
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
            text: 'Dr Reports',
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
                                      backgroundColor: const Color(0XFF196A61),
                                      mini: true,
                                      onPressed: () {},
                                      child: GestureDetector(
                                        onTapDown: (details) async {
                                          if (!isListening) {
                                            var available =
                                                await speechToText.initialize();
                                            if (available) {
                                              setState(() {
                                                isListening = true;
                                                speechToText.listen(
                                                  onResult: (result) {
                                                    setState(() {
                                                      reportController.text =
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
                                  padding:
                                      const EdgeInsetsDirectional.only(end: 50),
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
                      condition: state is! AddDoctorReportLoadingState,
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
                                getCubit.AddDoctorsReport(
                                  title: reportController.text,
                                  patientID: patientId!,
                                  nurseID: doctorOrNurseId!,
                                );
                              }
                            },
                            buttonText: 'Add Report'),
                      ),
                      fallback: (context) {
                        if (state is AddDoctorReportErrorState) {
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
                                    getCubit.AddDoctorsReport(
                                      title: reportController.text,
                                      patientID: patientId!,
                                      nurseID: doctorOrNurseId!,
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
                                buttonText: 'Add Report'),
                          );
                        }
                        // return const Center(
                        //   child: CircularProgressIndicator(
                        //       color: Color(0XFF196A61)),
                        // );
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 150,
                    //   ),
                    //   child: secondaryDefaultButton(
                    //       buttonFunction: () {
                    //         if (formKey.currentState!.validate()) {
                    //           print(reportController.text);
                    //           print(patientId);
                    //           print(doctorOrNurseId);
                    //           getCubit.AddDoctorsReport(
                    //             title: reportController.text,
                    //             patientID: patientId!,
                    //             nurseID: doctorOrNurseId!,
                    //           );
                    //         }
                    //       },
                    //       buttonText: 'Add Report'),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: secondaryDefaultButton(
                          buttonFunction: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DoctorAddMedicine(),
                              ),
                            );
                          },
                          buttonText: 'Add Medicine'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: secondaryDefaultButton(
                          buttonFunction: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DoctorAddXray(),
                              ),
                            );
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
