// // ignore_for_file: unused_local_variable
//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../shared/components/components.dart';
// import '../admin_screens/cubit/doctor_cubit.dart';
// import '../admin_screens/cubit/doctor_states.dart';
//
// class NurseDirectorNotificationScreen extends StatefulWidget {
//   const NurseDirectorNotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   NurseDirectorNotificationScreenState createState() => NurseDirectorNotificationScreenState();
// }
//
// class NurseDirectorNotificationScreenState extends State<NurseDirectorNotificationScreen> {
//   int? indexOfItem;
//
//   @override
//   void initState() {
//     super.initState();
//     UserSignUpCubit.getCubit(context).getAllNotificationTablet();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
//       listener: (BuildContext context, state) {
//         if (state is GetNotificationTabletLoadingStates) {
//           const Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 300),
//                 child: CircularProgressIndicator(),
//               ));
//         }
//       },
//       builder: (BuildContext context, Object? state) {
//         var getCubit = UserSignUpCubit.getCubit(context);
//         return Scaffold(
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   // 1- Making App Bar
//                   Row(
//                     children: [
//                       // 1.1- Icon
//                       IconButton(
//                         onPressed: () {
//                           // Navigator.pop(context);
//                         },
//                         color: const Color(0XFF2CBBA9),
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           size: 25,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       // 1.2- Tittle
//                       defaultTextGabriola(
//                         text: 'Notification',
//                         fontSize: 35,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   // 2- Making Notification Body
//                   ConditionalBuilder(
//                     condition: state is GetNotificationTabletScuseesStates,
//                     builder: (context) => Expanded(
//                       child: ListView.builder(
//                         itemBuilder: (context, index) => notificationBodyTablet(
//                             index: index,
//                             isSelected: indexOfItem == index ? false : true,
//                             getNotificationTabletModel: getCubit.getNotificationTabletModel,
//                             onTapFunction: () async {
//                               getCubit.makeNotificationReed(
//                                   idNotification: getCubit
//                                       .getNotificationTabletModel!.data![index].id);
//                               getCubit.getAllNotification();
//                               setState(() {
//                                 //  iconIndex != index ;
//                                 indexOfItem = index;
//                               });
//                             }),
//                         itemCount: getCubit.getNotificationTabletModel!.data!.length,
//                       ),
//                     ),
//                     fallback: (context) => const Center(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 300),
//                           child:
//                           CircularProgressIndicator(color: Color(0XFF196A61)),
//                         )),
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
// ignore_for_file: unused_local_variable, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/tablet_app/patients_details.dart';
import '../../shared/components/components.dart';
import '../../shared/components/global_variables.dart';
import '../../shared/network/local/cache_helper.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';
import '../signin_screen/signin_screen.dart';

class NurseDirectorNotificationScreen extends StatefulWidget {
  const NurseDirectorNotificationScreen({Key? key}) : super(key: key);

  @override
  NurseDirectorNotificationScreenState createState() =>
      NurseDirectorNotificationScreenState();
}

class NurseDirectorNotificationScreenState
    extends State<NurseDirectorNotificationScreen> {
  int? indexOfItem;

  @override
  void initState() {
    super.initState();
    UserSignUpCubit.getCubit(context).getAllNotificationTablet();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (BuildContext context, state) {
        if (state is GetNotificationTabletLoadingStates) {
          const Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 300),
            child: CircularProgressIndicator(),
          ));
        }
         if (state is LogoutScusessState) {
          Fluttertoast.showToast(
            msg: 'Logout',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => {
                CacheHelper.removeData(key: 'token').then((value) {
                  if (value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                        (route) => false);
                  }
                })
              });
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
                      // IconButton(
                      //   onPressed: () {
                      //     // Navigator.pop(context);
                      //   },
                      //   color: const Color(0XFF2CBBA9),
                      //   icon: const Image(
                      //     image: AssetImage(
                      //         'assets/images/UI-UX-Photos/notification.png'),
                      //     width: 30,
                      //     height: 30,
                      //   ),
                      // ),
                      const SizedBox(
                        width: 20,
                      ),
                      // 1.2- Tittle
                      defaultTextGabriola(
                        text: 'Notification',
                        fontSize: 35,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: const Color(0XFF2CBBA9).withOpacity(.7),
                          size: 28,
                        ),
                        onPressed: () {
                          getCubit.userLogout();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // 2- Making Notification Body
                  ConditionalBuilder(
                    condition: state is GetNotificationTabletScuseesStates,
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            print(index);
                            myNotificationID = getCubit
                                .getNotificationTabletModel!.data![index].id;
                            print(myNotificationID);
                            print(getCubit
                                .getNotificationTabletModel!.data![index].id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientNotificationDetailsScreen(
                                          index: getCubit
                                              .getNotificationTabletModel!
                                              .data![index]
                                              .id,
                                          notificationID: getCubit
                                              .getNotificationTabletModel!
                                              .data![index]
                                              .id,
                                        )));
                            print(getCubit
                                .getNotificationTabletModel!.data![index].id);
                          },
                          child: notificationBodyTablet(
                              index: index,
                              isSelected: indexOfItem == index ? false : true,
                              getNotificationTabletModel:
                                  getCubit.getNotificationTabletModel,
                              onTapFunction: () async {
                                myNotificationID = getCubit
                                    .getNotificationTabletModel!
                                    .data![index]
                                    .id;
                                getCubit.makeNotificationReed(
                                    idNotification: getCubit
                                        .getNotificationTabletModel!
                                        .data![index]
                                        .id);
                                getCubit.getAllNotification();
                                setState(() {
                                  //  iconIndex != index ;
                                  indexOfItem = index;
                                });
                              }),
                        ),
                        itemCount:
                            getCubit.getNotificationTabletModel!.data!.length,
                      ),
                    ),
                    fallback: (context) => const Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 300),
                      child:
                          CircularProgressIndicator(color: Color(0XFF196A61)),
                    )),
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
