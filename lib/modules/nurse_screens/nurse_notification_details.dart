// ignore_for_file: must_be_immutable, unused_local_variable, unrelated_type_equality_checks, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../shared/components/components.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';
import 'nurse_notifications.dart';

class NurseNotificationDetailsScreen extends StatefulWidget {
  int? notificationID, index;
  NurseNotificationDetailsScreen({Key? key, this.notificationID, this.index})
      : super(key: key);

  @override
  State<NurseNotificationDetailsScreen> createState() =>
      _NurseNotificationDetailsScreenState();
}

class _NurseNotificationDetailsScreenState
    extends State<NurseNotificationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    UserSignUpCubit.getCubit(context)
        .getNotificationDetails(notifcationID: widget.notificationID);
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
          ).then((value) => Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const NurseNotificationScreen(),
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
                          Navigator.pop(context);
                        },
                        color: const Color(0XFF2CBBA9),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
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
                              width: 400,
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
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/UI-UX-Photos/notification.png'),
                                      width: 40,
                                      height: 40,
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
                                                    : 'Nurse :\n',
                                                style: const TextStyle(
                                                    color: Colors.black45)),
                                            TextSpan(
                                              children: getCubit
                                                  .notificationDetails!
                                                  .userReceiver!
                                                  .map(
                                                    (user) => TextSpan(
                                                      text: '${user.name} ',
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
                                            fontSize: 16,
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
