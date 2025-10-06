// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';

class NurseHomeScreen extends StatefulWidget {
  const NurseHomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<NurseHomeScreen> createState() => _NurseHomeScreenState();
}

class _NurseHomeScreenState extends State<NurseHomeScreen> {
  var nameController = TextEditingController();

  var usernameController = TextEditingController();

  var rollController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var genderController = TextEditingController();

  var statusController = TextEditingController();

  var idController = TextEditingController();

  var ageController = TextEditingController();

  var addressController = TextEditingController();

  var specialistController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserSignUpCubit.getCubit(context).getNurseProfileData(); 
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var getCubit = UserSignUpCubit.getCubit(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is NurseDataScuseesStates,
            builder: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsetsDirectional.only(
                top: 20,
                start: 30,
                end: 20,
              ),
              child: Column(
                children: [
                  // 1- Making Image Of Nurse
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 15,
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
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage(
                              'assets/images/UI-UX-Photos/nurse.png',
                            ),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  // 2- Making Nurse Info
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 1.1- Making Nurse Name Text
                        //  defaultTextSegoe(
                        //    text: widget.name,
                        //  ),
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
                              text: 'Nurse',
                              fontSize: 20,
                              color: const Color(0xFF9A9292),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // 1- Name
                  defaultAboutMeInformation(
                    controller: nameController,
                    mainText: 'Name',
                    data: getCubit.getNurseData!.data!.name!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: usernameController,
                    mainText: 'UserName',
                    data: getCubit.getNurseData!.data!.username!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 2- Roll
                  defaultAboutMeInformation(
                    controller: rollController,
                    mainText: 'Roll',
                    data: 'nurse',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 3- Email
                  defaultAboutMeInformation(
                    controller: emailController,
                    mainText: 'Email',
                    data: getCubit.getNurseData!.data!.email!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 4- Phone
                  defaultAboutMeInformation(
                    controller: phoneController,
                    mainText: 'Phone',
                    data: getCubit.getNurseData!.data!.phone!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: addressController,
                    mainText: 'Address',
                    data: getCubit.getNurseData!.data!.address!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: idController,
                    mainText: 'ID',
                    data: getCubit.getNurseData!.data!.natId!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: specialistController,
                    mainText: 'Specialist',
                    data: getCubit.getNurseData!.data!.specialization!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: statusController,
                    mainText: 'Status',
                    data: getCubit.getNurseData!.data!.status!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: genderController,
                    mainText: 'Gender',
                    data: getCubit.getNurseData!.data!.gender!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: ageController,
                    mainText: 'Age',
                    data: getCubit.getNurseData!.data!.age!,
                  ),
                ],
              ),
            ),
            fallback: (context) => const Center(
                child: CircularProgressIndicator(color: Color(0XFF196A61))),
          ),
        );
      },
    );
  }
}
