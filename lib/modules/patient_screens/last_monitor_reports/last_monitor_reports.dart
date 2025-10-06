// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';

class LastMonitorReportScreen extends StatelessWidget {
  LastMonitorReportScreen({Key? key}) : super(key: key);

  var selectedDate;

  @override
  Widget build(BuildContext context) {
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
          text: 'Last Monitor Reports',
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
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
              ),
            ),
          ),
          // 2- Last Monitor Reports
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => LastMonitorReports(
                time: '6 hours ago',
              ),
              itemCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
