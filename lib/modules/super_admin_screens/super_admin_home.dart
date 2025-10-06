import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/signin_screen/signin_screen.dart';
import 'package:icu_project/modules/super_admin_screens/pending_admins.dart';
import 'package:icu_project/modules/super_admin_screens/super_admin_about.dart';
import 'package:icu_project/shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../admin_screens/cubit/admin_cubit.dart';
import '../admin_screens/cubit/admin_states.dart';
import 'available_medicines.dart';
import 'current_admins.dart';

class SuperAdminHomeScreen extends StatefulWidget {
  const SuperAdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<SuperAdminHomeScreen> createState() => _SuperAdminHomeScreenState();
}

class _SuperAdminHomeScreenState extends State<SuperAdminHomeScreen> {
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
                  // 1- Making Image Of  Super Admin
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
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/UI-UX-Photos/super.png',
                      ),
                      radius: 50,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  // 2- Making Super Admin Name Text
                  defaultTextSegoe(
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
                        text: 'Super Admin',
                        fontSize: 20,
                        color: const Color(0xFF9A9292),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  // 4- Making Super Admin Home
                  // 4.1- About
                  usersHomeDefaultButton(
                    buttonText: 'About Me',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuperAdminAboutScreen(),
                        ),
                      );
                    }),
                  ),
                  // 4.2- Current Admins
                  usersHomeDefaultButton(
                    buttonText: 'Current Admins',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CurrentAdminScreen(),
                        ),
                      );
                    }),
                  ),
                  // 4.3- Pending Admins
                  usersHomeDefaultButton(
                    buttonText: 'Pending Admins',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PendingAdminScreen(),
                        ),
                      );
                    }),
                  ),
                  // 4.4- Medicines
                  usersHomeDefaultButton(
                    buttonText: 'Medicines',
                    buttonFunction: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MedicineScreen(),
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
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
