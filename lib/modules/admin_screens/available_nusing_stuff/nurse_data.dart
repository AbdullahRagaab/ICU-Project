// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/available_nusing_stuff/nursing_stuff.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_cubit.dart';
import '../cubit/doctor_states.dart';
import 'edit_nurse_data.dart';

class NurseDataScreen extends StatefulWidget {
  NurseDataScreen({
    Key? key,
    this.name,
    this.index,
    this.username,
    this.age,
    this.gender,
    this.nat_id,
    this.id,
    this.phone,
    this.status,
    this.email,
    this.address,
    this.specialization,
  }) : super(key: key);

  String? username,
      name,
      email,
      phone,
      address,
      specialization,
      nat_id,
      status,
      gender,
      age,
      id;
  int? index;
  @override
  State<NurseDataScreen> createState() => _NurseDataScreenState();
}

class _NurseDataScreenState extends State<NurseDataScreen> {
  var nameController = TextEditingController();

  var usernameController = TextEditingController();

  var rollController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController = TextEditingController();

  var idController = TextEditingController();

  var specialistController = TextEditingController();

  var statusController = TextEditingController();

  var genderController = TextEditingController();

  var ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserSignUpCubit().getNurses(typeEndpoint: 'nurses');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var getCubit = UserSignUpCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            // 1- Icon
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AvailableNurseStuffScreen(),
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
              text: 'Nurse Data',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! NurseDataLoadingStates,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
            builder: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsetsDirectional.only(
                top: 30,
                start: 15,
              ),
              child: Column(
                children: [
                  // 1- Name
                  defaultAboutMeInformation(
                    controller: nameController,
                    mainText: 'Name',
                    data: getCubit.nursesModel?.data?[widget.index!].name
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: usernameController,
                    mainText: 'Username',
                    data: getCubit.nursesModel?.data?[widget.index!].username
                        .toString() as String,
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
                    data: getCubit.nursesModel?.data?[widget.index!].email
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 4- Phone
                  defaultAboutMeInformation(
                    controller: phoneController,
                    mainText: 'Phone',
                    data: getCubit.nursesModel?.data?[widget.index!].phone
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 5- Address
                  defaultAboutMeInformation(
                    controller: addressController,
                    mainText: 'Address',
                    data: getCubit.nursesModel?.data?[widget.index!].address
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 6- ID
                  defaultAboutMeInformation(
                    controller: idController,
                    mainText: 'ID',
                    data: getCubit.nursesModel?.data?[widget.index!].natId
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 7- Specialist
                  defaultAboutMeInformation(
                    controller: specialistController,
                    mainText: 'Specialist',
                    data: getCubit
                        .nursesModel?.data?[widget.index!].specialization
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 8- Status
                  defaultAboutMeInformation(
                    controller: statusController,
                    mainText: 'Status',
                    data: getCubit.nursesModel?.data?[widget.index!].status
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 9- Gender
                  defaultAboutMeInformation(
                    controller: genderController,
                    mainText: 'Gender',
                    data: getCubit.nursesModel?.data?[widget.index!].gender
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 7- Age
                  defaultAboutMeInformation(
                    controller: ageController,
                    mainText: 'Age',
                    data: getCubit.nursesModel?.data?[widget.index!].age
                        .toString() as String,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 5- Edit Button
                  secondaryDefaultButton(
                    buttonFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNurseDataScreen(
                            name: widget.name,
                            username: widget.username,
                            age: widget.age,
                            address: widget.address,
                            email: widget.email,
                            specialization: widget.specialization,
                            gender: widget.gender,
                            nat_id: widget.nat_id,
                            phone: widget.phone,
                            status: widget.status,
                            id: widget.id,
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
