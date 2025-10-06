// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/cubit.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/states.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/doctor_no_report_screen.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../../shared/components/components.dart';
import 'doctor_add_report.dart';
import 'doctor_current_report.dart';

class DoctorReportScreen extends StatefulWidget {
  String? patientID;
  List<String>? doctorID;
  DoctorReportScreen({Key? key, this.doctorID, this.patientID})
      : super(key: key);

  @override
  DoctorReportScreenState createState() => DoctorReportScreenState();
}

class DoctorReportScreenState extends State<DoctorReportScreen> {
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DoctorReportsCubit.getCubit(context)
        .getAllDoctorReports(patientID: patientId!);
    DoctorReportsCubit.getCubit(context).getAdminProfileData();
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
                text: 'Dr Reports',
                fontSize: 35,
              ),
            ),
            body: ConditionalBuilder(
              fallback: (context) => const Center(
                child: CircularProgressIndicator(color: Color(0XFF196A61)),
              ),
              condition: getCubit.doctotReportsModel?.data != null,
              builder: (context) => getCubit.doctotReportsModel?.result != 0
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: Column(
                          children: [
                            // 1- Reports
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    ReportContainerBody(
                                  onTapFunction: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorCurrentReportScreen(
                                          id: getCubit.doctotReportsModel
                                              ?.data?[index].id,
                                          patientID: patientId,
                                          doctorID: doctorOrNurseId,
                                          report: getCubit.doctotReportsModel
                                              ?.data?[index].title,
                                        ),
                                      ),
                                    );
                                  },
                                  text:
                                      'Report ${getCubit.doctotReportsModel!.result! - index}',
                                  date: getCubit
                                      .doctotReportsModel?.data?[index].created
                                      ?.substring(0, 10),
                                ),
                                itemCount: getCubit.doctotReportsModel!.result,
                              ),
                            ),
                            // 2- Add New Reports
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30,
                              ),
                              child: Visibility(
                                visible: (getCubit.getAdminData?.data?.role) ==
                                            'nurse' ||
                                        (getCubit.getAdminData?.data?.role) ==
                                            'Nurse'
                                    ? false
                                    : true,
                                child: secondaryDefaultButton(
                                    buttonFunction: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorAddReport(
                                            patientID: patientId,
                                            doctorID: doctorOrNurseId,
                                          ),
                                        ),
                                      );
                                    },
                                    buttonText: 'Add New Report'),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const NoReport(),
            ),
          );
        });
  }
}
