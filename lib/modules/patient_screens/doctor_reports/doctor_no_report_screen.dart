import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/cubit.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/doctor_add_report.dart';
import 'package:lottie/lottie.dart';
import '../../../shared/components/components.dart';
import 'cubit/states.dart';

class NoReport extends StatefulWidget {
  const NoReport({Key? key}) : super(key: key);

  @override
  NoReportScreenState createState() => NoReportScreenState();
}

class NoReportScreenState extends State<NoReport> {
  @override
  void initState() {
    super.initState();

    DoctorReportsCubit.getCubit(context).getAdminProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorReportsCubit, DoctorReports>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = DoctorReportsCubit.getCubit(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                                'assets/images/UI-UX-Photos/135714-report-scanning-crm-leads.json'),
                            defaultTextSegoe(
                              text: 'Not Defined Any Report',
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                          ]),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 150, bottom: 30),
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
                                    builder: (context) => DoctorAddReport(),
                                  ),
                                );
                              },
                              buttonText: 'Add Report'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
