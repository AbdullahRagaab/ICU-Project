// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/available_doctors/doctors.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_cubit.dart';
import '../cubit/doctor_states.dart';
import 'edit_doctor_data.dart';

class DoctorDataScreen extends StatefulWidget {
  DoctorDataScreen({
    Key? key,
    this.name,
    this.username,
    this.age,
    this.gender,
    this.nat_id,
    this.phone,
    this.status,
    this.email,
    this.address,
    this.specialization,
    this.id,
    this.index,
  }) : super(key: key);
  String? name,
      username,
      email,
      phone,
      address,
      specialization,
      nat_id,
      id,
      status,
      gender,
      age;
  int? index;
  @override
  State<DoctorDataScreen> createState() => _DoctorDataScreenState();
}

class _DoctorDataScreenState extends State<DoctorDataScreen> {
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
    UserSignUpCubit().getDoctors(typeEndpoint: 'doctors');
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
                    builder: (context) => const AvailableDoctorScreen(),
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
              text: 'Doctor Data',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! DoctorDataLoadingStates,
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
                    enabled: getCubit.isEnabled,
                    controller: nameController,
                    mainText: 'Name',
                    data: getCubit.doctorsModel?.data?[widget.index!].name,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultAboutMeInformation(
                    controller: usernameController,
                    mainText: 'UserName',
                    data:getCubit.doctorsModel?.data?[widget.index!].username,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 2- Roll
                  defaultAboutMeInformation(
                    controller: rollController,
                    mainText: 'Roll',
                    data: 'doctor',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 3- Email
                  defaultAboutMeInformation(
                    controller: emailController,
                    mainText: 'Email',
                    data: getCubit.doctorsModel?.data?[widget.index!].email,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 4- Phone
                  defaultAboutMeInformation(
                    controller: phoneController,
                    mainText: 'Phone',
                    data: getCubit.doctorsModel?.data?[widget.index!].phone,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 5- Address
                  defaultAboutMeInformation(
                    controller: addressController,
                    mainText: 'Address',
                    data: getCubit.doctorsModel?.data?[widget.index!].address,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 6- ID
                  defaultAboutMeInformation(
                    controller: idController,
                    mainText: 'ID',
                    data: getCubit.doctorsModel?.data?[widget.index!].natId,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 7- Specialist
                  defaultAboutMeInformation(
                    controller: specialistController,
                    mainText: 'Specialist',
                    data: getCubit.doctorsModel?.data?[widget.index!].specialization,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 8- Status
                  defaultAboutMeInformation(
                    controller: statusController,
                    mainText: 'Status',
                    data:getCubit.doctorsModel?.data?[widget.index!].status,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 9- Gender
                  defaultAboutMeInformation(
                    controller: genderController,
                    mainText: 'Gender',
                    data: getCubit.doctorsModel?.data?[widget.index!].gender,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 7- Age
                  defaultAboutMeInformation(
                    controller: ageController,
                    mainText: 'Age',
                    data: getCubit.doctorsModel?.data?[widget.index!].age,
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
                          builder: (context) => EditDoctorDataScreen(
                            name: widget.name,
                            age: widget.age,
                            address: widget.address,
                            email: widget.email,
                            specialization: widget.specialization,
                            gender: widget.gender,
                            nat_id: widget.nat_id,
                            phone: widget.phone,
                            status: widget.status,
                            id: widget.id,
                            username: widget.username,
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
