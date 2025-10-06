// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:icu_project/models/notifcation/get_noticatin_model.dart';

import '../../models/notifcation_tablet.dart';

// Primary Text Form Field For Sign In And Sign Up
Widget defaultTextFeild({
  required TextEditingController controller,
  required TextInputType type,
  String? labelText,
  String? hintText,
  String? Function(String?)? submitFunction,
  String? Function(String?)? validFunction,
  void Function()? onEditingComplete,
  void Function()? onTapFunction,
  void Function(String?)? onChangeFunction,
  void Function()? onTapSuffixIconFunction,
  ImageProvider<Object>? suffix,
  Color suffixIconColor = const Color(0XFF2CBBA9),
  required ImageProvider<Object> prefix,
  Color prefixIconColor = const Color(0XFF2CBBA9),
  bool isPassword = false,
  Animation<double>? opacity = const AlwaysStoppedAnimation(.7),
  double borderRaduis = 3.0,
  double width = 350,
  bool readOnly = false,
  FocusNode? focusNode,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          borderRaduis,
        ),
      ),
      child: TextFormField(
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        onChanged: onChangeFunction,
        controller: controller,
        keyboardType: type,
        readOnly: readOnly,
        onFieldSubmitted: submitFunction,
        validator: validFunction,
        obscureText: isPassword,
        onTap: onTapFunction,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          prefixIcon: Image(
            image: prefix,
            opacity: opacity,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: onTapSuffixIconFunction,
                  icon: Image(
                    image: suffix,
                    opacity: const AlwaysStoppedAnimation(.7),
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF707070),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(
              borderRaduis,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF707070),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(
              borderRaduis,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.red[400],
            backgroundColor: const Color(0xFFf5c6c0),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(
              borderRaduis,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(
              borderRaduis,
            ),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF6D6A6A),
            fontFamily: 'Segoe UI',
            fontSize: 15,
          ),
        ),
        cursorColor: Colors.black,
      ),
    );

// Primary Button For Sign In And Sign Up
Widget defaultButton({
  required void Function() buttonFunction,
  required String buttonText,
  Color textColor = const Color(0xFFFFFFFF),
  double buttonwidth = 320,
  double borderRadius = 20,
  double fontSize = 25,
}) =>
    Container(
      height: 40,
      width: buttonwidth,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0XFF2CBBA9),
            Color(0XFF196A61),
          ],
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: MaterialButton(
        onPressed: buttonFunction,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );

// Primary Font For App Bar
Widget defaultTextGabriola({
  String? text,
  double fontSize = 35,
  TextAlign? textAlign,
}) =>
    Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Gabriola',
        fontSize: fontSize,
        color: const Color(0xFF000000),
      ),
      maxLines: 1,
    );

// Secondary Font For Other Screens
Widget defaultTextSegoe({
  String? text,
  double fontSize = 25,
  Color color = const Color(0xFF000000),
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = 'Segoe UI',
}) =>
    Text(
      text!,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

// Third Font For Other Screens
Widget defaultTextCairo({
  String? text,
  double fontSize = 14,
  Color color = const Color(0xFF000000),
}) =>
    Text(
      text!,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: fontSize,
        color: color,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

// The Text Button Used In Sign In And Sign Up
Widget defaultTextButton({
  required String text,
  required void Function() textFunction,
}) =>
    TextButton(
      onPressed: textFunction,
      child: defaultTextSegoe(
        text: text,
        fontSize: 20,
      ),
    );

// Secondary Button For Other Screens
Widget secondaryDefaultButton({
  required void Function() buttonFunction,
  required String buttonText,
  List<Color> buttonColors = const [
    Color(0XFF2CBBA9),
    Color(0XFF196A61),
  ],
  Color textColor = const Color(0xFFFFFFFF),
  double buttonwidth = 170,
  double borderRadius = 20,
  double fontSize = 20,
}) =>
    Container(
      height: 35,
      width: buttonwidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: buttonColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 6,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: MaterialButton(
        onPressed: buttonFunction,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
        ),
      ),
    );

// We Use This In Home Screen For Super Admin And Admin
Widget usersHomeDefaultButton({
  required String buttonText,
  required void Function() buttonFunction,
}) =>
    Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 25,
      ),
      child: Container(
        width: 300,
        height: 30,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 6,
              blurStyle: BlurStyle.outer,
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: MaterialButton(
          onPressed: buttonFunction,
          child: defaultTextSegoe(
            text: buttonText,
            fontSize: 15,
          ),
        ),
      ),
    );

// Secondary Text Form Field For About Me Screen For All Users
Widget secondaryDefaultTextFeild({
  required TextEditingController controller,
  required TextInputType type,
  String? hintText,
  String? Function(String?)? submitFunction,
  String? Function(String?)? validFunction,
  void Function()? onTapFunction,
  bool enabled = true,
  double borderRadius = 15,
}) =>
    Container(
      alignment: Alignment.center,
      width: 250,
      height: 30,
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
          borderRadius,
        ),
      ),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: submitFunction,
        validator: validFunction,
        onTap: onTapFunction,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 15,
            // color: enabled ? const Color(0XFFFFFFFF) : Colors.black,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 15,
          ),
          // contentPadding: const EdgeInsetsDirectional.only(bottom: 10),
          border: InputBorder.none,
          alignLabelWithHint: true,
        ),
      ),
    );

// We Use This In About Me Screen For All Users
Widget defaultAboutMeInformation({
  required TextEditingController controller,
  required String mainText,
  String? data,
  bool enabled = false,
}) =>
    Row(
      children: [
        // 1- Field Name
        Expanded(
          child: defaultTextSegoe(
            text: mainText,
            fontSize: 20,
            fontFamily: 'Segoe UI Bold',
          ),
        ),
        // 2- Value
        secondaryDefaultTextFeild(
          controller: controller,
          type: TextInputType.text,
          hintText: data,
          enabled: enabled,
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );

// We Use This In Current And Pending Admin Screens
Widget currentAndPendingAdminBody({
  required String? adminName,
  void Function()? onPressedFunction,
  required ImageProvider<Object> suffixIcon,
  bool? isSelected,
}) =>
    Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 30,
        end: 30,
        bottom: 25,
      ),
      child: Column(
        children: [
          // 1- Make Container
          Container(
            width: 350,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: const Color(0XFFF2F1F1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 6,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                // 1- Making Icon
                const Image(
                  image: AssetImage(
                    'assets/images/UI-UX-Icons/current-and-pending-admins/pending_admins.png',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // 2- Making Admin Name
                Expanded(
                  child: defaultTextSegoe(
                    text: adminName!,
                    fontSize: 20,
                  ),
                ),
                // 3- Making Confrim Icon
                IconButton(
                  onPressed: onPressedFunction,
                  icon: Image(
                    width: 24,
                    height: 24,
                    image: isSelected!
                        ? const AssetImage(
                            'assets/images/UI-UX-Icons/check-marks/empty_checked_mark.png',
                          )
                        : const AssetImage(
                            'assets/images/UI-UX-Icons/check-marks/check_mark.png',
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

// We Use This In Super Admin Medicine Screen
Widget medicineScreenComponent({
  required String medicineName,
}) =>
    Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 30,
        end: 30,
        bottom: 25,
      ),
      child: Column(
        children: [
          // 1- Make Container
          Container(
            width: 350,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: const Color(0XFFF2F1F1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 6,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                // 1- Making Icon
                const Image(
                  image: AssetImage(
                    'assets/images/UI-UX-Icons/medicine/pill.png',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // 2- Making Medicine Name
                Expanded(
                  child: defaultTextSegoe(
                    text: medicineName,
                    fontSize: 20,
                  ),
                ),
                // 3- Making In Stock Text
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    end: 10,
                    bottom: 10,
                  ),
                  alignment: AlignmentDirectional.bottomEnd,
                  child: defaultTextSegoe(
                    text: 'In Stock',
                    fontSize: 14,
                    color: const Color(0xFF9A9292),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

// We Use This In Available Doctor And Nurse Screen
Widget doctorAndNurseContainer({
  required void Function()? onTapFunction,
  String? name,
  String? specialist,
  String? image,
}) =>
    Column(
      children: [
        InkWell(
          onTap: onTapFunction,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // 1- Making The Outer Container
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F1F1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        30,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 6,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  // 2- Making Th Inner Container Content
                  child: Row(
                    children: [
                      // 1- Making Doctor Photo
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 10,
                          end: 20,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0XFFE0D7D7),
                                  Color(0XFFFFFFFF),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              )),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image(
                                image: AssetImage(
                                  image!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // 2- Making Doctor Data
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1- Doctor Name
                          defaultTextSegoe(
                            text: name!,
                            color: const Color(0xFF4F4B4B),
                          ),
                          // 2- Doctor Specialist
                          defaultTextSegoe(
                            text: specialist!,
                            fontSize: 20,
                            color: const Color(0xFF9A9292),
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
      ],
    );

// We Use This In Available Patient Screen
Widget patientContainer({
  required void Function()? onTapFunction,
  ImageProvider<Object>? image,
  required String? name,
  required String? diseaseType,
  int? age,
}) =>
    Column(
      children: [
        InkWell(
          onTap: onTapFunction,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // 1- Making The Outer Container
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F1F1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        30,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 6,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  // 2- Making Th Inner Container Content
                  child: Row(
                    children: [
                      // 1- Making Patient Photo
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 10,
                          end: 20,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: ClipOval(
                            child: Image(
                              image: image!,
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
                            text: name!,
                            color: const Color(0xFF4F4B4B),
                          ),
                          // 2- Patient Disease
                          defaultTextSegoe(
                            text: '${age!} y . ${diseaseType!}',
                            fontSize: 20,
                            color: const Color(0xFF9A9292),
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
      ],
    );

// Notification Body
Widget notificationBody({
  required void Function()? onTapFunction,
  GetNotificationModel? notificationModel,
  int? index,
  // required ImageProvider<Object> icon,
  required bool isSelected,
}) =>
    Column(
      children: [
        // 2- Making Notification Body
        // 2.1 Line Separator
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
            end: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: const Color(0XFF707070),
          ),
        ),
        // 2.2 Notification
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              // 1- Notification Icon
              const Image(
                width: 24,
                height: 24,
                image: AssetImage(
                  'assets/images/UI-UX-Icons/notification-screen/notification.png',
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              // 2- Notification Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultTextSegoe(
                      text: notificationModel!.data![index!].title,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    defaultTextSegoe(
                      text: notificationModel.data![index].message,
                      fontSize: 15,
                      color: const Color(
                        0XFF9A9292,
                      ),
                    ),
                  ],
                ),
              ),
              // 3- Notification Done
              // IconButton(
              //   onPressed: onTapFunction,
              //   icon: Image(
              //     width: 24,
              //     height: 24,
              //     image: isSelected
              //         ? const AssetImage(
              //             'assets/images/UI-UX-Icons/check-marks/empty_checked_mark.png',
              //           )
              //         : const AssetImage(
              //             'assets/images/UI-UX-Icons/check-marks/check_mark.png',
              //           ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );

Widget notificationBodyTablet({
  required void Function()? onTapFunction,
  GetNotificationModel? notificationModel,
  GetAllNotificationModel? getNotificationTabletModel,
  int? index,
  // required ImageProvider<Object> icon,
  required bool isSelected,
}) =>
    Column(
      children: [
        // 2- Making Notification Body
        // 2.1 Line Separator
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
            end: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: const Color(0XFF707070),
          ),
        ),
        // 2.2 Notification
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              // 1- Notification Icon
              const Image(
                width: 24,
                height: 24,
                image: AssetImage(
                  'assets/images/UI-UX-Icons/notification-screen/notification.png',
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              // 2- Notification Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultTextSegoe(
                      text: getNotificationTabletModel!.data![index!].title,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    defaultTextSegoe(
                      text: getNotificationTabletModel.data![index].message,
                      fontSize: 15,
                      color: const Color(
                        0XFF9A9292,
                      ),
                    ),
                  ],
                ),
              ),
              // 3- Notification Done
              // IconButton(
              //   onPressed: onTapFunction,
              //   icon: Image(
              //     width: 24,
              //     height: 24,
              //     image: isSelected
              //         ? const AssetImage(
              //             'assets/images/UI-UX-Icons/check-marks/empty_checked_mark.png',
              //           )
              //         : const AssetImage(
              //             'assets/images/UI-UX-Icons/check-marks/check_mark.png',
              //           ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );

// Patient Monitor Reads
Widget PatientMonitorReads({
  required ImageProvider<Object> image,
  required String type,
  required String value,
}) =>
    Container(
      width: 120,
      height: 60,
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
        child: Row(
          children: [
            // 1- Icon
            Image(
              image: image,
              width: 25,
              height: 25,
            ),
            const SizedBox(
              width: 30,
            ),
            // 2- Text
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 2.1 Type
                defaultTextSegoe(
                  text: type,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                // 2.1 Value
                defaultTextCairo(
                  text: value,
                ),
              ],
            ),
          ],
        ),
      ),
    );

// Last Monitor Reports
Widget LastMonitorReports({
  required String time,
}) =>
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
                  // 2.1- Report Time
                  defaultTextSegoe(
                    text: time,
                    fontSize: 15,
                  ),
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
                              value: '80',
                            ),
                            const SizedBox(
                              width: 44,
                            ),
                            PatientMonitorReads(
                              image: const AssetImage(
                                'assets/images/UI-UX-Icons/patient-screen/monitor-icons/RESP.png',
                              ),
                              type: 'RESP',
                              value: '14',
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
                              value: '99',
                            ),
                            const SizedBox(
                              width: 44,
                            ),
                            PatientMonitorReads(
                              image: const AssetImage(
                                'assets/images/UI-UX-Icons/patient-screen/monitor-icons/CO2.png',
                              ),
                              type: 'CO2',
                              value: '38',
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
                              value: '120/80',
                            ),
                            const SizedBox(
                              width: 44,
                            ),
                            PatientMonitorReads(
                              image: const AssetImage(
                                'assets/images/UI-UX-Icons/patient-screen/monitor-icons/IBP&NIBP.png',
                              ),
                              type: 'NIBP',
                              value: '120/80',
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
        ],
      ),
    );

// Report Container Body For Doctor And Nurse Report Screen
Widget ReportContainerBody({
  required void Function()? onTapFunction,
  required String text,
  String? date,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTapFunction,
            child: Container(
              width: 350,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0XFF2CBBA9),
                    Color(0XFF196A61),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 6,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    // 1- Text
                    Expanded(
                      child: defaultTextSegoe(
                        text: text,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // 1- Date
                    defaultTextSegoe(
                      text: date!,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
