// // ignore_for_file: unused_local_variable, avoid_print
//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:icu_project/shared/components/global_variables.dart';
// import '../../shared/components/components.dart';
// import '../../shared/network/local/cache_helper.dart';
// import '../admin_screens/cubit/doctor_cubit.dart';
// import '../admin_screens/cubit/doctor_states.dart';
// import '../patient_screens/patient_home/patient_home.dart';
// import '../search/search_screen.dart';
// import '../signin_screen/signin_screen.dart';
//
// class NursingDirectorScreen extends StatefulWidget {
//   const NursingDirectorScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NursingDirectorScreen> createState() => _NursingDirectorScreen();
// }
//
// class _NursingDirectorScreen extends State<NursingDirectorScreen> {
//   @override
//   void initState() {
//     super.initState();
//     UserSignUpCubit.getCubit(context).getNurseDetectorProfileData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
//       listener: (BuildContext context, state) {
//         if (state is LogoutScusessState) {
//           Fluttertoast.showToast(
//             msg: 'Logout',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.black45,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           ).then((value) => {
//             CacheHelper.removeData(key: 'token').then((value) {
//               if (value) {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SignInScreen(),
//                     ),
//                         (route) => false);
//               }
//             })
//           });
//         }
//       },
//       builder: (BuildContext context, Object? state) {
//         var getCubit = UserSignUpCubit.getCubit(context);
//         return ConditionalBuilder(
//           condition:
//           // state is PatientUserScusessState ||
//               state is NurseDetectorDataScuseesStates,
//           fallback: (context) => const Center(
//               child: CircularProgressIndicator(color: Color(0XFF196A61))),
//           builder: (context) => SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   // Making Nurse Bar
//                   Padding(
//                     padding: const EdgeInsetsDirectional.only(
//                       start: 20,
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // 1- Making Image Of Nurse
//                         Padding(
//                           padding: const EdgeInsetsDirectional.only(
//                             top: 10,
//                           ),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0XFFE0D7D7),
//                                     Color(0XFFFFFFFF),
//                                   ],
//                                   begin: Alignment.bottomLeft,
//                                   end: Alignment.topRight,
//                                 )),
//                             child: CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Colors.transparent,
//                               child: ClipOval(
//                                 child: Image(
//                                   image: getCubit.getNursingDetectorData?.data![0].gender ==
//                                       "female" ||
//                                       getCubit.getNursingDetectorData?.data?[0].gender ==
//                                           "Female"
//                                       ? const AssetImage(
//                                     'assets/images/UI-UX-Photos/nurse.png',
//                                   )
//                                       : const AssetImage(
//                                     'assets/images/UI-UX-Photos/doctor1.png',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         // 2- Making Nurse Info
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsetsDirectional.only(
//                               top: 5,
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // 1.1- Making Nurse Name Text
//                                 defaultTextSegoe(
//                                   text: getCubit.getNurseData?.data != null
//                                       ? getCubit.getNurseData?.data?.name
//                                       : "",
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 // 1.2- Making Roll
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     // 1- Image
//                                     const Image(
//                                       image: AssetImage(
//                                         'assets/images/UI-UX-Icons/icon-doctor-nurse-etc/star.png',
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     // 2- Roll
//                                     defaultTextSegoe(
//                                       text: 'Nursing Director',
//                                       fontSize: 20,
//                                       color: const Color(0xFF9A9292),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 // 1.3- Making Number Of Assigned Patients
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     // 1- Image
//                                     Container(
//                                       alignment: Alignment.center,
//                                       padding: const EdgeInsetsDirectional.only(
//                                         top: 5,
//                                       ),
//                                       child: const Image(
//                                         width: 25,
//                                         height: 25,
//                                         image: AssetImage(
//                                           'assets/images/UI-UX-Icons/num-of-asiggned-patients/num_of_assigned_patients.png',
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     // 2- Number Of Assigned Patients
//                                     defaultTextSegoe(
//                                       text:
//                                       '${UserSignUpCubit.getCubit(context).getNursingDetectorData!.result} Patients',
//                                       fontSize: 20,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // 3- Making Search Icon
//                         IconButton(
//                           icon: const Image(
//                             image: AssetImage(
//                               'assets/images/UI-UX-Icons/search/search1.png',
//                             ),
//                             opacity: AlwaysStoppedAnimation(
//                               0.7,
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const SearchScreen(),
//                               ),
//                             );
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.logout,
//                             color: const Color(0XFF2CBBA9).withOpacity(.7),
//                             size: 28,
//                           ),
//                           onPressed: () {
//                             getCubit.userLogout();
//                           },
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemBuilder: (context, index) => patientContainer(
//                         onTapFunction: () {
//                           doctorOrNurseId = UserSignUpCubit.getCubit(context)
//                               .getNursingDetectorData
//                               ?.data![index]
//                               .doctor!
//                               .map((user) => user.id!)
//                               .toList();
//                           print(UserSignUpCubit.getCubit(context)
//                               .patientUserModel
//                               ?.data![index]
//                               .id);
//                           print(UserSignUpCubit.getCubit(context)
//                               .getNursingDetectorData
//                               ?.data![index]
//                               .nurse!
//                               .map((user) => user.id!)
//                               .toList());
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PatientHome(
//                                 roll: UserSignUpCubit.getCubit(context)
//                                     .getNursingDetectorData
//                                     ?.data![index]
//                                     .status,
//                                 patientID: UserSignUpCubit.getCubit(context)
//                                     .getNursingDetectorData
//                                     ?.data![index]
//                                     .id,
//                                 doctorID: doctorOrNurseId,
//                                 name: UserSignUpCubit.getCubit(context)
//                                     .getNursingDetectorData
//                                     ?.data![index]
//                                     .name!,
//                                 disease: UserSignUpCubit.getCubit(context)
//                                     .getNursingDetectorData
//                                     ?.data![index]
//                                     .diseaseType,
//                                 age: UserSignUpCubit.getCubit(context)
//                                     .getNursingDetectorData
//                                     ?.data![index]
//                                     .age
//                                     .toString(),
//                               ),
//                             ),
//                           );
//                         },
//                         age: UserSignUpCubit.getCubit(context)
//                             .getNursingDetectorData!
//                             .data![index]
//                             .age,
//                         diseaseType: UserSignUpCubit.getCubit(context)
//                             .getNursingDetectorData!
//                             .data![index]
//                             .diseaseType,
//                         // ignore: prefer_const_constructors
//                         image: AssetImage(
//                             'assets/images/UI-UX-Photos/patient-2.png'),
//                         name: UserSignUpCubit.getCubit(context)
//                             .getNursingDetectorData!
//                             .data![index]
//                             .name!,
//                       ),
//                       itemCount: UserSignUpCubit.getCubit(context)
//                           .getNursingDetectorData!
//                           .data!
//                           .length,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// ignore_for_file: must_be_immutable, unused_local_variable, unrelated_type_equality_checks, avoid_print, unused_label

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/tablet_app/patient_notification.dart';
import 'package:icu_project/modules/tablet_app/x_ray/medical_test.dart';
import 'package:icu_project/modules/tablet_app/x_ray/x_ray.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../shared/components/components.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';

class PatientNotificationDetailsScreen extends StatefulWidget {
  int? notificationID, index;
  PatientNotificationDetailsScreen({Key? key, this.notificationID, this.index})
      : super(key: key);

  @override
  State<PatientNotificationDetailsScreen> createState() =>
      _PatientNotificationDetailsScreenState();
}

class _PatientNotificationDetailsScreenState
    extends State<PatientNotificationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    UserSignUpCubit.getCubit(context)
        .getNotificationDetails(notifcationID: widget.notificationID);
    // UserSignUpCubit.getCubit(context).getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (BuildContext context, state) {
        if (state is GetNotificationScuseesStates) {
          Fluttertoast.showToast(
            msg: 'Notification Read Scusessfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NurseDirectorNotificationScreen(),
              )));
        }
      },
      builder: (BuildContext context, Object? state) {
        var getCubit = UserSignUpCubit.getCubit(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // 1- Making App Bar
                  Row(
                    children: [
                      // 1.1- Icon
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NurseDirectorNotificationScreen()));
                        },
                        color: const Color(0XFF2CBBA9),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // 1.2- Tittle
                      defaultTextGabriola(
                        text: 'Notification Details',
                        fontSize: 35,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ConditionalBuilder(
                    condition: state is! GetNotificationDetailsLoadingStates,
                    fallback: (context) => const Padding(
                      padding: EdgeInsetsDirectional.only(top: 250),
                      child: Center(
                        child:
                            CircularProgressIndicator(color: Color(0XFF196A61)),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Container(
                              width: 800,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 6,
                                    blurStyle: BlurStyle.outer,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'assets/images/UI-UX-Photos/notification.png'),
                                          width: 80,
                                          height: 40,
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  end: 15),
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return AlertDialog(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                          title: Center(
                                                            child:
                                                                defaultTextSegoe(
                                                              text:
                                                                  "Add XRay Or Medical Test",
                                                              color: const Color(
                                                                  0XFF43494B),
                                                              fontSize: 25,
                                                            ),
                                                          ),
                                                          content: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Column(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          30,
                                                                    ),
                                                                    child:
                                                                        MaterialButton(
                                                                      onPressed:
                                                                          () {
                                                                        patientId = getCubit
                                                                            .notificationDetails!
                                                                            .patient
                                                                            ?.id!;
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => const XRayScreen(),
                                                                            ));
                                                                      },
                                                                      child: Container(
                                                                          width: 270,
                                                                          height: 80,
                                                                          decoration: BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.grey.shade400,
                                                                                blurRadius: 10,
                                                                                blurStyle: BlurStyle.outer,
                                                                              )
                                                                            ],
                                                                          ),
                                                                          child: const Center(child: Text('X-Ray',style: TextStyle(fontSize: 25),))),
                                                                    ),
                                                                  ),
                                                                  MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      patientId = getCubit
                                                                          .notificationDetails!
                                                                          .patient
                                                                          ?.id!;
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const MedicalTestScreen(),
                                                                          ));
                                                                    },
                                                                    child: Container(
                                                                        width: 270,
                                                                        height: 80,
                                                                        decoration: BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey.shade400,
                                                                              blurRadius: 10,
                                                                              blurStyle: BlurStyle.outer,
                                                                            )
                                                                          ],
                                                                        ),
                                                                        child: const Center(child: Text('Medical Tests',style: TextStyle(fontSize: 25)))),
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
                                            icon: const Icon(
                                              Icons.add_a_photo_outlined,
                                              color: Color(0XFF2CBBA9),
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Segoe UI',
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    'This Notification Comes From ',
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: getCubit
                                                            .notificationDetails!
                                                            .userSender!
                                                            .role ==
                                                        'doctor'
                                                    ? 'DR :\n'
                                                    : 'Nurse :\n',
                                                style: const TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: getCubit
                                                    .notificationDetails!
                                                    .userSender!
                                                    .name),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Segoe UI',
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    'This Notification Comes To ',
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: TextSpan(
                                                          text: getCubit
                                                              .notificationDetails!
                                                              .userReceiver![0]
                                                              .role,
                                                        ) ==
                                                        'doctor'
                                                    ? 'DR :\n'
                                                    : 'Super Nurse :\n',
                                                style: const TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                              children: getCubit
                                                  .notificationDetails!
                                                  .userReceiver!
                                                  .map(
                                                    (user) => TextSpan(
                                                      text: '${user.name} \n',
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Segoe UI',
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text: 'For Patient :\n',
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                            TextSpan(
                                                text: getCubit
                                                    .notificationDetails!
                                                    .patient!
                                                    .name),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Segoe UI',
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    'This Patient In Room :  \n',
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: getCubit
                                                    .notificationDetails!
                                                    .patient!
                                                    .roomNumber
                                                    .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Segoe UI',
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    'And Its Disease Type Is : \n',
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: getCubit
                                                    .notificationDetails!
                                                    .patient!
                                                    .diseaseType),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Segoe UI',
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    'Notification Message Is :\n',
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: getCubit
                                                    .notificationDetails!
                                                    .message),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    'Notification Details Is :\n',
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: getCubit
                                                    .notificationDetails!
                                                    .title),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    'This Notification Is Added In :\n',
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                                text: getCubit
                                                    .notificationDetails!
                                                    .created
                                                    ?.substring(0, 10)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 30),
                            child: secondaryDefaultButton(
                              buttonText: 'Read done',
                              buttonFunction: () {
                                print(widget.index!);
                                getCubit.makeNotificationReed(
                                    idNotification: widget.index!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
