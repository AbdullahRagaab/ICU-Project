// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/admin_about/edit_my_data_screen.dart';
import 'package:icu_project/modules/admin_screens/admin_home/admin_home.dart';
import 'package:icu_project/modules/admin_screens/cubit/admin_cubit.dart';
import 'package:icu_project/modules/admin_screens/cubit/admin_states.dart';
import '../../../shared/components/components.dart';

class AdminAboutScreen extends StatefulWidget {
  const AdminAboutScreen({Key? key}) : super(key: key);

  @override
  AdminAboutScreenState createState() => AdminAboutScreenState();
}

class AdminAboutScreenState extends State<AdminAboutScreen> {
  var nameController = TextEditingController();
  var rollController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void initState() {
    AdminCubit.getCubit(context).getAdminProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var getAdminCubit = AdminCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            // 1- Icon
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminHomeScreen(),
                  ),
                );
              },
              color: const Color(0XFF2CBBA9),
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
            // 2- App Bar Tittle
            title: defaultTextGabriola(
              text: 'About Me',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! AdminLoadingStates,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
            builder: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsetsDirectional.only(
                top: 60,
                start: 15,
              ),
              child: Column(
                children: [
                  // 1- Name
                  defaultAboutMeInformation(
                    controller: nameController,
                    mainText: 'Name',
                    data: getAdminCubit.getAdminData?.data?.name,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 2- Roll
                  defaultAboutMeInformation(
                    controller: rollController,
                    mainText: 'Roll',
                    data: 'Admin',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 3- Email
                  defaultAboutMeInformation(
                    controller: emailController,
                    mainText: 'Email',
                    data: getAdminCubit.getAdminData?.data?.email,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 4- Phone
                  defaultAboutMeInformation(
                    controller: phoneController,
                    mainText: 'Phone',
                    data: getAdminCubit.getAdminData?.data?.phone,
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  // 5- Edit Button
                  secondaryDefaultButton(
                    buttonFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminEditMyDataScreen(
                            name: getAdminCubit.getAdminData?.data?.name,
                            email: getAdminCubit.getAdminData?.data?.email,
                            roll: getAdminCubit.getAdminData?.data?.role,
                            phone: getAdminCubit.getAdminData?.data?.phone,
                          ),
                        ),
                      );
                    },
                    buttonText: 'Edit',
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
