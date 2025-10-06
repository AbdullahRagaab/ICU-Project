// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:icu_project/modules/patient_screens/last_monitor_reports/last_monitor_reports.dart';
import 'package:icu_project/modules/patient_screens/monitor_reading/monitor_reading.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/global_variables.dart';
import '../../socket/socket.dart';
import 'package:provider/provider.dart';
import '../doctor_reports/doctor_reports.dart';
import '../get_x_ray_and_medical_tests/get_medical_test.dart';
import '../get_x_ray_and_medical_tests/get_xray.dart';
import '../nurse_reports/nurse_reports.dart';
import '../pills_reminder/doctor_pills_reminder.dart';
import '../pills_reminder/nurse_pills_reminder.dart';

class PatientHome extends StatefulWidget {
  String? name, age, disease, patientID, roll;
  List<String>? doctorID;
  int? room;

  PatientHome(
      {Key? key,
      this.name,
      this.age,
      this.disease,
      this.doctorID,
      this.patientID,
      this.roll,
      this.room})
      : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

// ignore: constant_identifier_names
enum SingingCharacter { English, Arabic }

class _PatientHomeState extends State<PatientHome> {
  var selectedDate;

  bool switchValue = true;
  bool isEnglish = true;
  bool isArabic = true;
  String? language;

  @override
  void initState() {
    super.initState();
    print("**************************************************");
    print(ecg);
    print(resp);
    print(spo2);
    print(co2);
    print(ibp);
    print(nibp);
    print("**************************************************");
  }

  @override
  Widget build(BuildContext context) {
    final socketData = Provider.of<SocketData>(context);

    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: IconButton(
        //       icon: const Image(
        //         image: AssetImage(
        //           'assets/images/UI-UX-Icons/chat/chat-icon/chat.png',
        //         ),
        //         width: 25,
        //         height: 25,
        //         opacity: AlwaysStoppedAnimation(
        //           0.7,
        //         ),
        //       ),
        //       onPressed: () {
        //         //   Navigator.push(
        //         //     context,
        //         //     MaterialPageRoute(
        //         //       builder: (context) => ,
        //         //     ),
        //         //   );
        //       },
        //     ),
        //   ),
        // ],
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                // 1- Making Patient Photo
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 30,
                    end: 20,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const ClipOval(
                      child: Image(
                        image: AssetImage(
                          'assets/images/UI-UX-Photos/patient-1.png',
                        ),
                        width: 81,
                        height: 81,
                      ),
                    ),
                  ),
                ),
                // 2- Making Patient Data
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1- Patient Name
                    defaultTextSegoe(
                      text: '${widget.name}',
                      color: const Color(0xFF4F4B4B),
                    ),
                    //2-patient Age
                    defaultTextSegoe(
                      text: 'Age: ${widget.age} years ',
                      fontSize: 15,
                      color: const Color(0xFF9A9292),
                    ),
                    // 3- Patient Disease
                    defaultTextSegoe(
                      text: 'Disease: ${widget.disease}',
                      fontSize: 15,
                      color: const Color(0xFF9A9292),
                    ),
                  ],
                ),
              ],
            ),
            // 2- Last Monitor Reports
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Column(
                children: [
                  Center(
                    // 1- Outer Container
                    child: Consumer<SocketData>(
                      builder: (context, data, _) => Container(
                        padding: const EdgeInsetsDirectional.only(
                          top: 5,
                        ),
                        width: 350,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0XFF2CBBA9),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        // 2- Container Content
                        child: Column(
                          children: [
                            // 2.2- Reports
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 30,
                                top: 8,
                                end: 30,
                                bottom: 10,
                              ),
                              child: Column(
                                children: [
                                  // 1- First Row
                                  Row(
                                    children: [
                                      PatientMonitorReads(
                                        image: const AssetImage(
                                          'assets/images/UI-UX-Icons/patient-screen/monitor-icons/ECG.png',
                                        ),
                                        type: 'ECG',
                                        value: ecg.toString(),
                                      ),
                                      const SizedBox(
                                        width: 44,
                                      ),
                                      PatientMonitorReads(
                                        image: const AssetImage(
                                          'assets/images/UI-UX-Icons/patient-screen/monitor-icons/RESP.png',
                                        ),
                                        type: 'RESP',
                                        value: resp.toString(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // 1- Second Row
                                  Row(
                                    children: [
                                      PatientMonitorReads(
                                        image: const AssetImage(
                                          'assets/images/UI-UX-Icons/patient-screen/monitor-icons/SPO2.png',
                                        ),
                                        type: 'SPO2',
                                        value: spo2.toString(),
                                      ),
                                      const SizedBox(
                                        width: 44,
                                      ),
                                      PatientMonitorReads(
                                        image: const AssetImage(
                                          'assets/images/UI-UX-Icons/patient-screen/monitor-icons/CO2.png',
                                        ),
                                        type: 'CO2',
                                        value: co2.toString(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // 1- third Row
                                  Row(
                                    children: [
                                      PatientMonitorReads(
                                        image: const AssetImage(
                                          'assets/images/UI-UX-Icons/patient-screen/monitor-icons/IBP&NIBP.png',
                                        ),
                                        type: 'IBP',
                                        value: ibp.toString(),
                                      ),
                                      const SizedBox(
                                        width: 44,
                                      ),
                                      PatientMonitorReads(
                                        image: const AssetImage(
                                          'assets/images/UI-UX-Icons/patient-screen/monitor-icons/IBP&NIBP.png',
                                        ),
                                        type: 'NIBP',
                                        value: nibp.toString(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // 1- Fourth Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PatientMonitorReads(
                                        image: const AssetImage(
                                          'assets/images/UI-UX-Icons/patient-screen/monitor-icons/TEMP.png',
                                        ),
                                        type: 'TEMP',
                                        value: '37',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 3- Other Reports
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Column(
                children: [
                  Center(
                    // 1- Outer Container
                    child: Container(
                      padding: const EdgeInsetsDirectional.only(
                        top: 5,
                      ),
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0XFF2CBBA9),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      // 2- Container Content
                      child: Column(
                        children: [
                          // 2.2- Reports
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 30,
                              top: 8,
                              end: 30,
                              bottom: 10,
                            ),
                            child: Column(
                              children: [
                                //1-last monitor report
                                Row(
                                  children: [
                                    // 1- Dr Report
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LastMonitorReportScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 114,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 6,
                                              blurStyle: BlurStyle.outer,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // 1- Icon
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/UI-UX-Icons/patient-screen/other-icons/last_monitor_reports.png',
                                                ),
                                                width: 25,
                                                height: 25,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // 2- Text
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // 2.1 Type
                                                  defaultTextSegoe(
                                                    text: 'Last Monitor',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  defaultTextSegoe(
                                                    text: 'Report',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 55,
                                    ),
                                    // 2- Nurse Report
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MonitorImageRead(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 114,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 6,
                                              blurStyle: BlurStyle.outer,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // 1- Icon
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/UI-UX-Icons/patient-screen/other-icons/last_monitor_reports.png',
                                                ),
                                                width: 25,
                                                height: 25,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // 2- Text
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // 2.1 Type
                                                  defaultTextSegoe(
                                                    text: 'Monitor',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  defaultTextSegoe(
                                                    text: 'Reading',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // 1- Second Row
                                Row(
                                  children: [
                                    // 1- Dr Report
                                    InkWell(
                                      onTap: () {
                                        patientId = widget.patientID!;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorReportScreen(
                                              patientID: patientId,
                                              doctorID: doctorOrNurseId,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 114,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 6,
                                              blurStyle: BlurStyle.outer,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // 1- Icon
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/UI-UX-Icons/patient-screen/other-icons/report.png',
                                                ),
                                                width: 25,
                                                height: 25,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // 2- Text
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // 2.1 Type
                                                  defaultTextSegoe(
                                                    text: 'DR-Reports',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 55,
                                    ),
                                    // 2- Nurse Report
                                    InkWell(
                                      onTap: () {
                                        patientId = widget.patientID!;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NurseReportScreen(
                                              patientID: patientId,
                                              doctorID: doctorOrNurseId,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 114,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 6,
                                              blurStyle: BlurStyle.outer,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // 1- Icon
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/UI-UX-Icons/patient-screen/other-icons/report.png',
                                                ),
                                                width: 25,
                                                height: 25,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // 2- Text
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // 2.1 Type
                                                  defaultTextSegoe(
                                                    text: 'Nurse-Report',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // 1- third Row
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        patientId = widget.patientID!;
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0))),
                                                    title: Center(
                                                      child: defaultTextSegoe(
                                                        text:
                                                            "Show XRay Or Medical Test",
                                                        color: const Color(
                                                            0XFF43494B),
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    content: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                              child:
                                                                  MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const GetXRayScreen(),
                                                                      ));
                                                                },
                                                                child:
                                                                    Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            50,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey.shade400,
                                                                              blurRadius: 6,
                                                                              blurStyle: BlurStyle.outer,
                                                                            )
                                                                          ],
                                                                        ),
                                                                        child: const Center(
                                                                            child:
                                                                                Text('XRay'))),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const GetMedicalTestScreen(),
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
                                                                        blurRadius:
                                                                            6,
                                                                        blurStyle:
                                                                            BlurStyle.outer,
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
                                      child: Container(
                                        width: 114,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 6,
                                              blurStyle: BlurStyle.outer,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // 1- Icon
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/UI-UX-Icons/patient-screen/other-icons/x-rays.png',
                                                ),
                                                width: 25,
                                                height: 25,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // 2- Text
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // 2.1 Type
                                                  defaultTextSegoe(
                                                    text: 'X-Ray',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  defaultTextSegoe(
                                                    text: 'Medical Tests',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 55,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        patientId = widget.patientID!;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => widget.roll ==
                                                        'nurse' ||
                                                    widget.roll == 'Nurse'
                                                ? const NursePillsReminderScreen()
                                                : const DoctorPillsReminderScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 114,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 6,
                                              blurStyle: BlurStyle.outer,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // 1- Icon
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/UI-UX-Icons/patient-screen/other-icons/pill.png',
                                                ),
                                                width: 25,
                                                height: 25,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              // 2- Text
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // 2.1 Type
                                                  defaultTextSegoe(
                                                    text: 'Pills Reminder',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
