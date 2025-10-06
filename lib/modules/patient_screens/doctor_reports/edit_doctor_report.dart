// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/cubit.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/states.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/doctor_reports.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../../shared/components/components.dart';

class DoctorEditReport extends StatefulWidget {
  String? report, patientID;
  int? id;
  List<String>? doctorID;
  DoctorEditReport(
      {Key? key, this.report, this.doctorID, this.patientID, this.id})
      : super(key: key);

  @override
  DoctorEditReportScreenState createState() => DoctorEditReportScreenState();
}

class DoctorEditReportScreenState extends State<DoctorEditReport> {
  bool isReadMore = false;
  var reportController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorReportsCubit, DoctorReports>(
        listener: (BuildContext context, state) {
      if (state is UpdateDoctorReportScuseesState) {
        DoctorReportsCubit.getCubit(context)
            .getAllDoctorReports(patientID: patientId!);
        Fluttertoast.showToast(
          msg: "Data Updated Sucessfully",
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
      reportController.text = widget.report!;
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
            text: 'Doctor Reports',
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
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Container(
                                      alignment: Alignment.centerRight,
                                      child: const Image(
                                        width: 25,
                                        height: 25,
                                        image: AssetImage(
                                          'assets/images/UI-UX-Icons/add-new-report/new-report.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.only(end: 50),
                                  child: TextFormField(
                                    controller: reportController,
                                    decoration: const InputDecoration(
                                      hintText: 'New Text Report',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF000000),
                                      fontFamily: 'Segoe UI',
                                    ),
                                    maxLines: isReadMore ? 2 : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ConditionalBuilder(
                      condition: state is! UpdateDoctorReportLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.only(
                          top: 150,
                        ),
                        child: secondaryDefaultButton(
                            buttonFunction: () {
                              if (formKey.currentState!.validate()) {
                                getCubit.updateDoctorsReport(
                                  title: reportController.text,
                                  id: widget.id!,
                                  patientID: patientId!,
                                  nurseID: doctorOrNurseId!,
                                );
                              }
                            },
                            buttonText: 'Save Report'),
                      ),
                      fallback: (context) {
                        if (state is UpdateDoctorReportErrorState) {
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
                                    getCubit.updateDoctorsReport(
                                      title: reportController.text,
                                      id: widget.id!,
                                      patientID: patientId!,
                                      nurseID: doctorOrNurseId!,
                                    );
                                  }
                                },
                                buttonText: 'Save Report'),
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
                                buttonText: 'Save Report'),
                          );
                        }
                      },
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
