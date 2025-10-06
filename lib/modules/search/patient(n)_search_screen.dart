// ignore_for_file: must_be_immutable, non_constant_identifier_names, body_might_complete_normally_nullable, file_names, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/components/global_variables.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';
import '../admin_screens/cubit/patient_cubit.dart';
import '../patient_screens/patient_home/patient_home.dart';

class PatientSearchScreen extends StatefulWidget {
  const PatientSearchScreen({Key? key}) : super(key: key);

  @override
  State<PatientSearchScreen> createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen> {
  var searchController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var getCubit = PatientCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            // 1- Icon
            leading: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 15,
              ),
              child: IconButton(
                onPressed: () {
              //     UserSignUpCubit()
              // .getPatientUser(typeEndpoint: 'patient_user/');
                  Navigator.pop(context);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => NursePatientScreen(),
                  //   ),
                  // );
                },
                color: const Color(0XFF2CBBA9),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 30,
                    bottom: 15,
                  ),
                  child: Column(
                    children: [
                      defaultTextFeild(
                        // width: 360,
                        controller: searchController,
                        type: TextInputType.name,
                        labelText: 'search',
                        borderRaduis: 10,
                        prefix: const AssetImage(
                          'assets/images/UI-UX-Icons/search/search1.png',
                        ),
                        onChangeFunction: (String? value) {
                          // Save the current cursor position
                          final cursorPosition =
                              searchController.selection.baseOffset;

                          // Update the text of the searchController
                          searchController.value = TextEditingValue(
                            text: value!,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: cursorPosition),
                            ),
                          );
                          UserSignUpCubit.getCubit(context).SearchPatientUser(
                              typeEndpoint: 'patient_user',
                              search: searchController.text);
                        },
                        submitFunction: (String? value) {
                          searchController.text = value!;
                          UserSignUpCubit.getCubit(context).SearchPatientUser(
                              typeEndpoint: 'patient_user',
                              search: searchController.text);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => patientContainer(
                        onTapFunction: () {
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
                                roll: UserSignUpCubit.getCubit(context)
                                    .getNurseData
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
        );
      },
    );
  }
}
