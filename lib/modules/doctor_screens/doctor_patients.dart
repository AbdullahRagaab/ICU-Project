// ignore_for_file: unused_local_variable, avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';
import '../animation/page_fade_animation.dart';
import '../patient_screens/patient_home/patient_home.dart';
import '../search/patient(d)_search_screen.dart';
import '../signin_screen/signin_screen.dart';

class DoctorPatientScreen extends StatefulWidget {
  const DoctorPatientScreen({Key? key}) : super(key: key);

  @override
  State<DoctorPatientScreen> createState() => _DoctorPatientScreenState();
}

class _DoctorPatientScreenState extends State<DoctorPatientScreen> {
  @override
  void initState() {
    super.initState();
    UserSignUpCubit.getCubit(context).getDoctorProfileData();
    UserSignUpCubit.getCubit(context)
        .getPatientUser(typeEndpoint: 'patient_user/');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (BuildContext context, state) {
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
        return ConditionalBuilder(
          condition: state is PatientUserScusessState ||
              state is DoctorDataScuseesStates,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(color: Color(0XFF196A61)),
          ),
          builder: (context) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Making Doctor Bar
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1- Making Image Of Doctor
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 10,
                          ),
                          child: Container(
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
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/UI-UX-Photos/doctor1.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        // 2- Making Doctor Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 5,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 1.1- Making Doctor Name Text
                                defaultTextSegoe(
                                  text: getCubit.getDoctorData?.data != null
                                      ? getCubit.getDoctorData?.data?.name
                                      : "",
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // 1.2- Making Roll
                                Row(
                                  mainAxisSize: MainAxisSize.min,
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
                                      text: 'Doctor',
                                      fontSize: 20,
                                      color: const Color(0xFF9A9292),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // 1.3- Making Number Of Assigned Patients
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // 1- Image
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsetsDirectional.only(
                                        top: 5,
                                      ),
                                      child: const Image(
                                        width: 25,
                                        height: 25,
                                        image: AssetImage(
                                          'assets/images/UI-UX-Icons/num-of-asiggned-patients/num_of_assigned_patients.png',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    // 2- Number Of Assigned Patients
                                    defaultTextSegoe(
                                      text: getCubit.getDoctorData?.data != null
                                          ? '${UserSignUpCubit.getCubit(context).patientUserModel!.result} Patients'
                                          : '0 Patients',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // 3- Making Search Icon
                        IconButton(
                          icon: const Image(
                            image: AssetImage(
                              'assets/images/UI-UX-Icons/search/search1.png',
                            ),
                            opacity: AlwaysStoppedAnimation(
                              0.7,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(PageFadeAnimation(
                                const DoctorPatientSearchScreen()));
                          },
                        ),
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
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Making Assigned Patients Bar
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => patientContainer(
                        onTapFunction: () {
                          patientName = UserSignUpCubit.getCubit(context)
                              .patientUserModel
                              ?.data![index]
                              .name!;
                          patientRoom = UserSignUpCubit.getCubit(context)
                              .patientUserModel
                              ?.data![index]
                              .roomNumber!;
                          doctorOrNurseId = UserSignUpCubit.getCubit(context)
                              .patientUserModel
                              ?.data![index]
                              .user!
                              .map((user) => user.id!)
                              .toList();
                          print(UserSignUpCubit.getCubit(context)
                              .patientUserModel
                              ?.data![index]
                              .id);
                          print(UserSignUpCubit.getCubit(context)
                              .patientUserModel
                              ?.data![index]
                              .user!
                              .map((user) => user.id!)
                              .toList());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientHome(
                                room: UserSignUpCubit.getCubit(context)
                                    .patientUserModel
                                    ?.data![index]
                                    .roomNumber,
                                roll: UserSignUpCubit.getCubit(context)
                                    .getDoctorData
                                    ?.data
                                    ?.role,
                                patientID: UserSignUpCubit.getCubit(context)
                                    .patientUserModel
                                    ?.data![index]
                                    .id,
                                doctorID: doctorOrNurseId,
                                name: UserSignUpCubit.getCubit(context)
                                    .patientUserModel
                                    ?.data![index]
                                    .name!,
                                disease: UserSignUpCubit.getCubit(context)
                                    .patientUserModel
                                    ?.data![index]
                                    .diseaseType,
                                age: UserSignUpCubit.getCubit(context)
                                    .patientUserModel
                                    ?.data![index]
                                    .age
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        age: UserSignUpCubit.getCubit(context)
                            .patientUserModel!
                            .data![index]
                            .age,
                        diseaseType: UserSignUpCubit.getCubit(context)
                            .patientUserModel!
                            .data![index]
                            .diseaseType,
                        // ignore: prefer_const_constructors
                        image: AssetImage(
                            'assets/images/UI-UX-Photos/patient-2.png'),
                        name: UserSignUpCubit.getCubit(context)
                            .patientUserModel!
                            .data![index]
                            .name!,
                      ),
                      itemCount: UserSignUpCubit.getCubit(context)
                          .patientUserModel!
                          .data!
                          .length,
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
