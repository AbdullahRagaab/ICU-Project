// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/cubit.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/edit_doctor_report.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../../shared/components/components.dart';
import 'cubit/states.dart';
import 'doctor_reports.dart';

class DoctorCurrentReportScreen extends StatefulWidget {
  String? report, patientID;
  int? id;
  List<String>? doctorID;
  DoctorCurrentReportScreen(
      {Key? key, this.report, this.doctorID, this.patientID, this.id})
      : super(key: key);

  @override
  DoctorCurrentReportScreenState createState() =>
      DoctorCurrentReportScreenState();
}

class DoctorCurrentReportScreenState extends State<DoctorCurrentReportScreen> {
  bool isReadMore = true;

  @override
  void initState() {
    super.initState();
    DoctorReportsCubit.getCubit(context)
        .getAllDoctorReports(patientID: patientId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorReportsCubit, DoctorReports>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
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
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 50),
                                    child: Text(
                                      widget.report!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF000000),
                                        fontFamily: 'Segoe UI',
                                      ),
                                      maxLines: isReadMore ? 2 : null,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // more Button
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              bottom: 20,
                              end: 30,
                            ),
                            child: Container(
                              height: 20,
                              width: 60,
                              decoration: BoxDecoration(
                                color: const Color(0XFFF2F1F1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 6,
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    isReadMore = !isReadMore;
                                  });
                                },
                                child: Text(
                                  isReadMore ? 'more' : 'less',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF6D6A6A),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 150,
                        ),
                        child: Visibility(
                          visible: (getCubit.getAdminData?.data?.role) ==
                                      'nurse' ||
                                  (getCubit.getAdminData?.data?.role) == 'Nurse'
                              ? false
                              : true,
                          child: secondaryDefaultButton(
                              buttonFunction: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorEditReport(
                                      report: widget.report,
                                      id: widget.id,
                                      patientID: patientId,
                                      doctorID: doctorOrNurseId,
                                    ),
                                  ),
                                );
                              },
                              buttonText: 'Edit Report'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
