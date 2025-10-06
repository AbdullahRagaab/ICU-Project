import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/cubit/admin_cubit.dart';
import 'package:icu_project/modules/admin_screens/cubit/admin_states.dart';
import 'package:icu_project/modules/signin_screen/signin_screen.dart';
import 'package:icu_project/shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../admin_about/admin_about.dart';
import '../available_doctors/doctors.dart';
import '../available_head_nursing/head_nursing.dart';
import '../available_nusing_stuff/nursing_stuff.dart';
import '../available_patients/patients.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  AdminHomeScreenState createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends State<AdminHomeScreen> {
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
        return Scaffold(
          body: ConditionalBuilder(
            condition: AdminCubit.getCubit(context).getAdminData != null,
            builder: (context) => SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1- Making Image Of Admin
                  Container(
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
                      backgroundImage: AdminCubit.getCubit(context)
                                      .getAdminData
                                      ?.data
                                      ?.gender ==
                                  "female" ||
                              AdminCubit.getCubit(context)
                                      .getAdminData
                                      ?.data
                                      ?.gender ==
                                  "Female" ||
                              AdminCubit.getCubit(context)
                                      .getAdminData
                                      ?.data
                                      ?.gender ==
                                  ""
                          ? const AssetImage(
                              'assets/images/UI-UX-Photos/admin.png',
                            )
                          : const AssetImage(
                              'assets/images/UI-UX-Photos/admin-male.png',
                            ),
                      radius: 50,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  // 2- Making Admin Name Text
                  defaultTextSegoe(
                    // AdminCubit.getCubit(context).getAdminData?.name
                    text: AdminCubit.getCubit(context).getAdminData?.data?.name,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // 3- Add Roll Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1- Image
                      const Image(
                        image: AssetImage(
                          'assets/images/UI-UX-Icons/icon-doctor-nurse-etc/star.png',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // 2- Roll
                      defaultTextSegoe(
                        text: 'Admin',
                        fontSize: 20,
                        color: const Color(0xFF9A9292),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  // 4- Making Admin Home
                  // 4.1- About
                  usersHomeDefaultButton(
                    buttonText: 'About Me',
                    buttonFunction: (() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminAboutScreen(),
                        ),
                      );
                    }),
                  ),
                  // 4.2- Doctors
                  usersHomeDefaultButton(
                    buttonText: 'Doctors',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailableDoctorScreen(),
                        ),
                      );
                    }),
                  ),
                  // 4.3- Nurse Stuff
                  usersHomeDefaultButton(
                    buttonText: 'Nurse Stuff',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AvailableNurseStuffScreen(),
                        ),
                      );
                    }),
                  ),
                  // 4.4- Patients
                  usersHomeDefaultButton(
                    buttonText: 'Patients',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailablePatientScreen(),
                        ),
                      );
                    }),
                  ),
                  // 4.5- Head Nurse
                  usersHomeDefaultButton(
                    buttonText: 'Head Nursing',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailableHeadNursingScreen(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  // 5- Logout Button
                  secondaryDefaultButton(
                    buttonFunction: () {
                      CacheHelper.removeData(key: 'token').then((value) {
                        if (value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                              (route) => false);
                        }
                      });
                    },
                    buttonText: 'Logout',
                  ),
                ],
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
          ),
        );
      },
    );
  }
}
