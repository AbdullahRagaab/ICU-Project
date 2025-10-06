import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/nurse_reports/cubit/cubit.dart';
import 'package:lottie/lottie.dart';
import '../../../shared/components/components.dart';
import 'cubit/states.dart';
import 'nurse_add_report.dart';

class NoNurseReport extends StatefulWidget {
  const NoNurseReport({Key? key}) : super(key: key);

  @override
  NoNurseReportScreenState createState() => NoNurseReportScreenState();
}

class NoNurseReportScreenState extends State<NoNurseReport> {
  @override
  void initState() {
    super.initState();

    NurseReportsCubit.getCubit(context).getAdminProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NurseReportsCubit, NurseReports>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = NurseReportsCubit.getCubit(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: SingleChildScrollView(
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
                          visible:
                              (getCubit.getAdminData?.data?.role) == 'doctor' ||
                                      (getCubit.getAdminData?.data?.role) ==
                                          'Doctor'
                                  ? false
                                  : true,
                          child: secondaryDefaultButton(
                              buttonFunction: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NurseAddReport(),
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
