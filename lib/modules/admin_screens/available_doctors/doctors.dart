// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/admin_home/admin_home.dart';
import 'package:icu_project/modules/admin_screens/available_doctors/add_doctor.dart';
import 'package:icu_project/modules/admin_screens/available_doctors/doctor_data.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_cubit.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_states.dart';

class AvailableDoctorScreen extends StatefulWidget {
  const AvailableDoctorScreen({Key? key}) : super(key: key);

  @override
  State<AvailableDoctorScreen> createState() => _AvailableDoctorScreenState();
}

class _AvailableDoctorScreenState extends State<AvailableDoctorScreen> {
  var searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    UserSignUpCubit.getCubit(context).getDoctors(typeEndpoint: 'doctors');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = UserSignUpCubit.getCubit(context);

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
                text: 'Doctors',
                fontSize: 35,
              ),
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 35,
                      end: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    // 1- Making Search Bar And Add Doctors Icon
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
                            UserSignUpCubit.getCubit(context).searchDoctors(
                                typeEndpoint: 'doctors',
                                search: searchController.text);
                          },
                          submitFunction: (String? value) {
                            searchController.text = value!;
                            UserSignUpCubit.getCubit(context).searchDoctors(
                                typeEndpoint: 'doctors',
                                search: searchController.text);
                          },
                        ),
                        // 2- Add Doctors Icon
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
                                  builder: (context) => const AddDocter(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2- Making Doctor Profile
                  Expanded(
                    child: ConditionalBuilder(
                      condition: getCubit.doctorsModel?.data != null &&
                          state is! DoctorStateLoading,
                      builder: (context) => ListView.builder(
                        itemBuilder: (context, index) =>
                            doctorAndNurseContainer(
                          onTapFunction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDataScreen(
                                    index: index,
                                    nat_id: getCubit
                                        .doctorsModel?.data?[index].natId,
                                    specialization: getCubit.doctorsModel
                                        ?.data?[index].specialization,
                                    name: getCubit
                                        .doctorsModel?.data?[index].name,
                                    email: getCubit
                                        .doctorsModel?.data?[index].email,
                                    address: getCubit
                                        .doctorsModel?.data?[index].address,
                                    age:
                                        getCubit.doctorsModel?.data?[index].age,
                                    gender: getCubit
                                        .doctorsModel?.data?[index].gender,
                                    phone: getCubit
                                        .doctorsModel?.data?[index].phone,
                                    status: getCubit
                                        .doctorsModel?.data?[index].status,
                                    id: getCubit.doctorsModel?.data?[index].id,
                                    username: getCubit
                                        .doctorsModel?.data?[index].username,
                                  ),
                                ));
                          },
                          image: getCubit.doctorsModel?.data?[index].gender ==
                                  "female"
                              ? 'assets/images/UI-UX-Photos/nurse.png'
                              : 'assets/images/UI-UX-Photos/doctor1.png',
                          name: getCubit.doctorsModel?.data?[index].name,
                          specialist: getCubit
                              .doctorsModel?.data?[index].specialization,
                        ),
                        itemCount: getCubit.doctorsModel?.data?.length,
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
