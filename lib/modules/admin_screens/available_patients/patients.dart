// ignore_for_file: must_be_immutable, unused_local_variable, unnecessary_null_comparison, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/admin_home/admin_home.dart';
import 'package:icu_project/modules/admin_screens/available_patients/add_patient.dart';
import 'package:icu_project/modules/admin_screens/available_patients/patient_data.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_states.dart';
import '../../../shared/components/components.dart';
import '../cubit/patient_cubit.dart';

class AvailablePatientScreen extends StatefulWidget {
  const AvailablePatientScreen({Key? key}) : super(key: key);

  @override
  AvailablePatientScreenState createState() => AvailablePatientScreenState();
}

class AvailablePatientScreenState extends State<AvailablePatientScreen> {
  var searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    PatientCubit.getCubit(context).getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, UserSignUpStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = PatientCubit.getCubit(context);

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
                text: 'Patients',
                fontSize: 35,
              ),
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 35,
                      end: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    // 1- Making Search Bar And Add Patients Icon
                    child: Row(
                      children: [
                        // 1- Search Bar Text Field
                        defaultTextFeild(
                          focusNode: focusNode,
                          width: 290,
                          controller: searchController,
                          type: TextInputType.name,
                          labelText: 'search',
                          borderRaduis: 10,
                          prefix: const AssetImage(
                            'assets/images/UI-UX-Icons/search/search1.png',
                          ),
                          onEditingComplete: () {
                            focusNode.unfocus();
                          },
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
                            PatientCubit.getCubit(context)
                                .searchPatient(search: searchController.text);
                          },
                          submitFunction: (String? value) {
                            searchController.text = value!;
                            PatientCubit.getCubit(context)
                                .searchPatient(search: searchController.text);
                          },
                        ),
                        // 2- Add Patients Icon
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                            start: 25,
                          ),
                          child: IconButton(
                            icon: const Image(
                              image: AssetImage(
                                'assets/images/UI-UX-Icons/add-users/add_user.png',
                              ),
                              width: 25,
                              height: 25,
                              opacity: AlwaysStoppedAnimation(
                                0.7,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Add_patient(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2- Making Patient Profile
                  Expanded(
                    child: ConditionalBuilder(
                      condition: getCubit.getPatientModel?.data != null && state is! PatientLoadingStates,
                      builder: (context) => ListView.builder(
                        itemBuilder: (context, index) => patientContainer(
                          onTapFunction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientDataScreen(
                                    index: index,
                                    id: getCubit
                                        .getPatientModel?.data?[index].id
                                        .toString() as String,
                                    name: getCubit
                                        .getPatientModel?.data?[index].name
                                        .toString() as String,
                                    address: getCubit
                                        .getPatientModel?.data?[index].address
                                        .toString() as String,
                                    age: getCubit
                                        .getPatientModel?.data?[index].age
                                        .toString() as String,
                                    disease: getCubit.getPatientModel
                                        ?.data?[index].diseaseType
                                        .toString() as String,
                                    gender: getCubit
                                        .getPatientModel?.data?[index].gender
                                        .toString() as String,
                                    nat_id: getCubit.getPatientModel
                                        ?.data?[index].nationalId
                                        .toString() as String,
                                    phone: getCubit
                                        .getPatientModel?.data?[index].phone
                                        .toString() as String,
                                    room: getCubit.getPatientModel?.data?[index]
                                        .roomNumber
                                        .toString() as String,
                                    status: getCubit
                                        .getPatientModel?.data?[index].status
                                        .toString() as String,
                                    doctor: PatientCubit.getCubit(context)
                                        .getPatientModel
                                        ?.data?[index]
                                        .doctor,
                                    nurse: PatientCubit.getCubit(context)
                                        .getPatientModel
                                        ?.data?[index]
                                        .nurse,
                                  ),
                                ));
                          },
                          image: getCubit.getPatientModel?.data?[index]
                                          .gender ==
                                      "Male" ||
                                  getCubit.getPatientModel?.data?[index]
                                          .gender ==
                                      "male"
                              ? const AssetImage(
                                  'assets/images/UI-UX-Photos/patient-2.png',
                                )
                              : const AssetImage(
                                  'assets/images/UI-UX-Photos/patient-1.png'),
                          name: getCubit.getPatientModel?.data?[index].name,
                          diseaseType: getCubit
                              .getPatientModel?.data![index].diseaseType,
                          age: getCubit.getPatientModel?.data?[index].age,
                        ),
                        itemCount: getCubit.getPatientModel?.data?.length,
                      ),
                      fallback: (context) => const Center(
                        child:
                            CircularProgressIndicator(color: Color(0XFF196A61)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
