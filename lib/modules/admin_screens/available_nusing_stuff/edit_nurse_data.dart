// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_cubit.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_states.dart';

class EditNurseDataScreen extends StatefulWidget {
  String? username ,name, email,phone,addedBy,specialization, nat_id, status, gender, age , address ,id;
  EditNurseDataScreen({
    Key? key,
    this.name,
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

  @override
  State<EditNurseDataScreen> createState() => _EditNurseDataScreenState();
}

class _EditNurseDataScreenState extends State<EditNurseDataScreen> {
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
    UserSignUpCubit.getCubit(context).getNurses(typeEndpoint: 'nurses');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (context, state) {
        if (state is UpDateScusessState) {
          UserSignUpCubit.getCubit(context).getNurses(typeEndpoint: 'nurses');
          Fluttertoast.showToast(
            msg: "Data Updated Sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => Navigator.pop(context));
        }
      },
      builder: (context, state) {
        var getCubit = UserSignUpCubit.getCubit(context);
        nameController.text = widget.name!;
        usernameController.text = widget.username!;
        rollController.text = "nurse";
        phoneController.text = widget.phone!;
        idController.text = widget.nat_id!;
        statusController.text = widget.status!;
        genderController.text = widget.gender!;
        ageController.text = widget.age!;
        addressController.text = widget.address!;
        emailController.text = widget.email!;
        specialistController.text =widget.specialization!;
        return Scaffold(
          appBar: AppBar(
            // 1- Icon
            leading: IconButton(
              onPressed: () {

                Navigator.pop(context);

              },
              color: const Color(0XFF2CBBA9),
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
            // 2- App Bar Tittle
            title: defaultTextGabriola(
              text: 'Edit Nurse Data',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! UpDateStateLoading,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 1- Name
                    defaultAboutMeInformation(
                      controller: nameController,
                      mainText: 'Name',
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultAboutMeInformation(
                      controller: usernameController,
                      mainText: 'Username',
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 2- Roll
                    defaultAboutMeInformation(
                      controller: rollController,
                      mainText: 'Roll',
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 3- Email
                    defaultAboutMeInformation(
                      controller: emailController,
                      mainText: 'Email',
                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 4- Phone
                    defaultAboutMeInformation(
                      controller: phoneController,
                      mainText: 'Phone',
                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 5- Address
                    defaultAboutMeInformation(
                      controller: addressController,
                      mainText: 'Address',
                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 6- ID
                    defaultAboutMeInformation(
                      controller: idController,
                      mainText: 'ID',

                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 7- Specialist
                    defaultAboutMeInformation(
                      controller: specialistController,
                      mainText: 'Specialist',
                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 8- Status
                    defaultAboutMeInformation(
                      controller: statusController,
                      mainText: 'Status',
                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 9- Gender
                    defaultAboutMeInformation(
                      controller: genderController,
                      mainText: 'Gender',
                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 7- Age
                    defaultAboutMeInformation(
                      controller: ageController,
                      mainText: 'Age',
                      enabled: true,

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 5- Edit Button
                    secondaryDefaultButton(
                      buttonFunction: () {
                        getCubit.updateProfile(
                          specialization: specialistController.text,
                          role: rollController.text,
                          email: emailController.text,
                          name: nameController.text,
                          username: usernameController.text,
                          natId: idController.text,
                          phone: phoneController.text,
                          gender: genderController.text,
                          age: ageController.text,
                          address: addressController.text,
                          status: statusController.text,
                          id: widget.id!,
                          
                        );
                      },
                      buttonText: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}