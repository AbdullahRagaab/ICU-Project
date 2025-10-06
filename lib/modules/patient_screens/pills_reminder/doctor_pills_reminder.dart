// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, avoid_print

import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/pills_reminder/cubit/cubit.dart';
import 'package:icu_project/modules/patient_screens/pills_reminder/cubit/states.dart';
import 'package:icu_project/modules/patient_screens/pills_reminder/pills_body.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../shared/components/components.dart';

class DoctorPillsReminderScreen extends StatefulWidget {
  const DoctorPillsReminderScreen({Key? key}) : super(key: key);

  @override
  State<DoctorPillsReminderScreen> createState() =>
      _DoctorPillsReminderScreenState();
}

class _DoctorPillsReminderScreenState extends State<DoctorPillsReminderScreen> {
  var selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    print(selectedDate);
    PillsCubit.getCubit(context).getDoctorPills(
        patientID: patientId!, selectedDate: selectedDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PillsCubit, PillsStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
              text: 'Pills Reminder',
              fontSize: 35,
            ),
          ),
          body: Column(
            children: [
              // 1- Calendar
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 15,
                  top: 5,
                ),
                child: SizedBox(
                  height: 105,
                  child: AnimatedHorizontalCalendar(
                    fontSizeOfWeek: 18,
                    tableCalenderButtonColor: const Color(0XFFFFFFFF),
                    date: DateTime.now(),
                    textColor: Colors.black45,
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0XFF229183),
                    unSelectedBoxShadow: const BoxShadow(
                      color: Color(
                        0XFF35BEAD,
                      ),
                      blurRadius: 4,
                      blurStyle: BlurStyle.outer,
                    ),
                    selectedBoxShadow: BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 7,
                      blurStyle: BlurStyle.outer,
                    ),
                    onDateSelected: (date) {
                      selectedDate = date;
                      print(selectedDate);
                      PillsCubit.getCubit(context).getDoctorPills(
                          patientID: patientId!,
                          selectedDate: selectedDate.toString());
                    },
                    tableCalenderIcon: const Icon(
                      Icons.calendar_today,
                      color: Color(0XFF229183),
                      size: 25,
                    ),
                    tableCalenderThemeData: ThemeData.light().copyWith(
                      primaryColor: const Color(0XFF2CBBA9),
                      colorScheme:
                          const ColorScheme.light(primary: Color(0XFF229183)),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                  ),
                ),
              ),
              // 2- Pills
              Expanded(
                child: ConditionalBuilder(
                  condition:
                      PillsCubit.getCubit(context).doctorPillsModel?.data !=
                          null,
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(color: Color(0XFF196A61)),
                  ),
                  builder: (context) =>
                      PillsCubit.getCubit(context).doctorPillsModel!.result != 0
                          ? ListView.builder(
                              itemBuilder: (context, index) =>
                                  PillsReminderBody(
                                visable: false,
                                time: PillsCubit.getCubit(context)
                                    .doctorPillsModel!
                                    .data![index]
                                    .time!,
                                medicineName: PillsCubit.getCubit(context)
                                    .doctorPillsModel!
                                    .data![index]
                                    .name!,
                                details:
                                    '${PillsCubit.getCubit(context).doctorPillsModel!.data![index].dosage!} , take ${PillsCubit.getCubit(context).doctorPillsModel!.data![index].quantity!} pills',
                              ),
                              itemCount: PillsCubit.getCubit(context)
                                  .doctorPillsModel!
                                  .result,
                            )
                          : Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 80, bottom: 10),
                                    child: Lottie.asset(
                                        'assets/images/UI-UX-Photos/77043-search-icon.json',
                                        width: 350,
                                        height: 350),
                                  ),
                                  defaultTextSegoe(
                                    text: 'Not Defined Any Medicine',
                                    fontSize: 30,
                                    color: const Color(0XFF229183),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
