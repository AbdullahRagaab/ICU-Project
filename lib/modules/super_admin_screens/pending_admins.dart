// ignore_for_file: prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/super_admin_screens/current_admins.dart';
import 'package:lottie/lottie.dart';
import '../../shared/components/components.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';

class PendingAdminScreen extends StatefulWidget {
  const PendingAdminScreen({Key? key}) : super(key: key);

  @override
  State<PendingAdminScreen> createState() => _PendingAdminScreenState();
}

class _PendingAdminScreenState extends State<PendingAdminScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserSignUpCubit()..getActiveAdmins(typeEndpoint: "pending_admin"),
      child: BlocConsumer<UserSignUpCubit, UserSignUpStates>(
        listener: (context, state) {
          if (state is AcceptAdminScusessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CurrentAdminScreen()),
            );
          }
        },
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
                text: 'Pending Admins',
                fontSize: 35,
              ),
            ),
            body: UserSignUpCubit.getCubit(context).adminModel?.data?.length ==
                    0
                ? Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 130,
                            bottom: 10,
                            end: 15,
                          ),
                          child: Lottie.asset(
                              'assets/images/UI-UX-Photos/77043-search-icon.json',
                              width: 350,
                              height: 350),
                        ),
                        defaultTextSegoe(
                          text: 'Not Pending Admins Found',
                          fontSize: 30,
                          color: const Color(0XFF229183),
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  )
                : ConditionalBuilder(
                    condition: state is GetActiveAdminScusessState,
                    builder: (context) => Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 40,
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            currentAndPendingAdminBody(
                                isSelected:
                                    selectedIndex == index ? false : true,
                                adminName: UserSignUpCubit.getCubit(context)
                                    .adminModel
                                    ?.data?[index]
                                    .name,
                                suffixIcon: const AssetImage(
                                  'assets/images/UI-UX-Icons/check-marks/empty_checked_mark.png',
                                ),
                                onPressedFunction: () {
                                  setState(() {
                                    //  iconIndex != index ;
                                    selectedIndex = index;
                                  });
                                  UserSignUpCubit.getCubit(context)
                                      .postAcceptAdmin(
                                          email:
                                              UserSignUpCubit.getCubit(context)
                                                  .adminModel!
                                                  .data![index]
                                                  .email);
                                }),
                        itemCount: UserSignUpCubit.getCubit(context)
                            .adminModel!
                            .data!
                            .length,
                      ),
                    ),
                    fallback: (context) => const Center(
                        child: CircularProgressIndicator(
                            color: Color(0XFF196A61))),
                  ),
          );
        },
      ),
    );
  }
}
