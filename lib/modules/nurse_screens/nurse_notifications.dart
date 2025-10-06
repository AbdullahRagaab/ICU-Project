// ignore_for_file: unused_local_variable, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/nurse_screens/nurse_notification_details.dart';
import '../../shared/components/components.dart';
import '../../shared/components/global_variables.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';

class NurseNotificationScreen extends StatefulWidget {
  const NurseNotificationScreen({Key? key}) : super(key: key);

  @override
  NurseNotificationScreenState createState() => NurseNotificationScreenState();
}

class NurseNotificationScreenState extends State<NurseNotificationScreen> {
  int? indexOfItem;

  @override
  void initState() {
    super.initState();
    UserSignUpCubit.getCubit(context).getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (BuildContext context, state) {
        if (state is GetNotificationLoadingStates) {
          const Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 300),
            child: CircularProgressIndicator(),
          ));
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
                          // Navigator.pop(context);
                        },
                        color: const Color(0XFF2CBBA9),
                        icon: const Image(
                          image: AssetImage(
                              'assets/images/UI-UX-Photos/notification.png'),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // 1.2- Tittle
                      defaultTextGabriola(
                        text: 'Notification',
                        fontSize: 35,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // 2- Making Notification Body
                  ConditionalBuilder(
                    condition: state is GetNotificationScuseesStates,
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            myNotificationID =
                                getCubit.getNotificationModel!.data![index].id;
                            print(myNotificationID);
                            print(
                                getCubit.getNotificationModel!.data![index].id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NurseNotificationDetailsScreen(
                                          notificationID: getCubit
                                              .getNotificationModel!
                                              .data![index]
                                              .id,
                                               index: getCubit.getNotificationModel!
                                            .data![index].id,
                                        )));
                            print(
                                getCubit.getNotificationModel!.data![index].id);
                          },
                          child: notificationBody(
                              index: index,
                              isSelected: indexOfItem == index ? false : true,
                              notificationModel: getCubit.getNotificationModel,
                              onTapFunction: () async {
                                myNotificationID = getCubit
                                    .getNotificationModel!.data![index].id;
                                getCubit.makeNotificationReed(
                                    idNotification: getCubit
                                        .getNotificationModel!.data![index].id);
                                getCubit.getAllNotification();
                                setState(() {
                                  //  iconIndex != index ;
                                  indexOfItem = index;
                                });
                              }),
                        ),
                        itemCount: getCubit.getNotificationModel!.data!.length,
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
