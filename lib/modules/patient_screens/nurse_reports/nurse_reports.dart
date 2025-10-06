// ignore_for_file: unused_local_variable, must_be_immutable, unrelated_type_equality_checks

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/patient_screens/nurse_reports/nurse_add_report.dart';
import 'package:icu_project/modules/patient_screens/nurse_reports/nurse_no_report_screen.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'nurse_current_report.dart';

class NurseReportScreen extends StatefulWidget {
  String? patientID;
  List<String>? doctorID;
  NurseReportScreen({Key? key, this.doctorID, this.patientID})
      : super(key: key);

  @override
  NurseReportScreenState createState() => NurseReportScreenState();
}

class NurseReportScreenState extends State<NurseReportScreen> {
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    NurseReportsCubit.getCubit(context)
        .getAllNurseReports(patientID: patientId!);
    NurseReportsCubit.getCubit(context).getAdminProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NurseReportsCubit, NurseReports>(
        listener: (BuildContext context, state) {
      if (state is AddReportScusessState) {
        Fluttertoast.showToast(
          msg: NurseReportsCubit.getCubit(context).addReport!.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0,
        ).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NurseReportScreen(),
            )));
      }
    }, builder: (BuildContext context, Object? state) {
      var getCubit = NurseReportsCubit.getCubit(context);

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
            text: 'Nurse Reports',
            fontSize: 35,
          ),
        ),
        body: ConditionalBuilder(
          fallback: (context) => const Center(
            child: CircularProgressIndicator(color: Color(0XFF196A61)),
          ),
          condition: getCubit.nurseReportsModel?.data != null,
          builder: (context) => getCubit.nurseReportsModel?.result != 0
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NurseCurrentReportScreen(
                                      id: getCubit
                                          .nurseReportsModel?.data?[index].id,
                                      patientID: patientId,
                                      doctorID: doctorOrNurseId,
                                      report: getCubit.nurseReportsModel
                                          ?.data?[index].title,
                                    ),
                                  ),
                                );
                              },
                              text:
                                  'Report ${getCubit.nurseReportsModel!.result! - index}',
                              date: getCubit
                                  .nurseReportsModel?.data?[index].created
                                  ?.substring(0, 10),
                            ),
                            itemCount: getCubit.nurseReportsModel!.result,
                          ),
                        ),
                        // 2- Add New Reports
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                          ),
                          child: Visibility(
                            visible: (getCubit.getAdminData?.data?.role) ==
                                        'doctor' ||
                                    (getCubit.getAdminData?.data?.role) ==
                                        'Doctor'
                                ? false
                                : true,
                            child: secondaryDefaultButton(
                                buttonFunction: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NurseAddReport(
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
              : const NoNurseReport(),
        ),
      );
    });
  }
}
