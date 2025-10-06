// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, unused_local_variable, avoid_print, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/models/patient/get_all_patients_model.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_states.dart';
import '../cubit/patient_cubit.dart';

class EditPatientDataScreen extends StatefulWidget {
  String? name, phone, address, nat_id, disease, status, gender, age, room, id;
  List<Doctor>? doctor;
  List<Nurse>? nurse;
  EditPatientDataScreen({
    Key? key,
    this.name,
    this.address,
    this.age,
    this.disease,
    this.gender,
    this.nat_id,
    this.id,
    this.phone,
    this.room,
    this.status,
    this.doctor,
    this.nurse,
  }) : super(key: key);

  @override
  State<EditPatientDataScreen> createState() => _EditPatientDataScreenState();
}

class _EditPatientDataScreenState extends State<EditPatientDataScreen> {
  var nameController = TextEditingController();
  var rollController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var idController = TextEditingController();
  var diseaseController = TextEditingController();
  var statusController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var roomController = TextEditingController();
  var doctorController = TextEditingController();
  var nurseController = TextEditingController();

  List<Doctor> _selecteddoctors = [];

  List<Nurse> _selectedNurses = [];

  @override
  void initState() {
    super.initState();
    PatientCubit.getCubit(context).getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, UserSignUpStates>(
      listener: (context, state) {
        if (state is PatientUpdateScusessStates) {
          PatientCubit.getCubit(context).getPatientData();
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
        var getCubit = PatientCubit.getCubit(context);
        nameController.text = widget.name!;
        rollController.text = "Patient";
        phoneController.text = widget.phone!;
        addressController.text = widget.address!;
        idController.text = widget.nat_id!;
        diseaseController.text = widget.disease!;
        statusController.text = widget.status!;
        genderController.text = widget.gender!;
        ageController.text = widget.age!;
        roomController.text = widget.room!;

        final List<Doctor>? selectedDoctor = widget.doctor;

        final _doctorItems = selectedDoctor
            ?.map((doctor) => MultiSelectItem(doctor, doctor.username!))
            .toList();

        final List<Nurse>? selectedNurse = widget.nurse;

        final _nurseStuffItems = selectedNurse
            ?.map((nurse) => MultiSelectItem(nurse, nurse.username!))
            .toList();
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
              text: 'Patient Data',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! PatientLoadingStates,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
            builder: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsetsDirectional.only(
                top: 30,
                start: 16,
                end: 16,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 4, bottom: 30),
                  child: Column(
                    children: [
                      // 1- Name
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: nameController,
                        mainText: 'Name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 2- Roll
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: rollController,
                        mainText: 'Roll',
                        data: 'Patient',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 3- Phone
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: phoneController,
                        mainText: 'Phone',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 4- Address
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: addressController,
                        mainText: 'Address',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 5- ID
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: idController,
                        mainText: 'ID',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 6- Disease
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: diseaseController,
                        mainText: 'Disease',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 7- Status
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: statusController,
                        mainText: 'Status',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 8- Gender
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: genderController,
                        mainText: 'Gender',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 9- Age
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: ageController,
                        mainText: 'Age',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 10- Room
                      defaultAboutMeInformation(
                        enabled: true,
                        controller: roomController,
                        mainText: 'Room',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 11- Doctor
                      Row(
                        children: [
                          defaultTextSegoe(
                            text: 'Doctors',
                            fontSize: 20,
                            fontFamily: 'Segoe UI Bold',
                          ),
                        ],
                      ),

                      Padding(
                        padding:
                            const EdgeInsetsDirectional.only(end: 20, top: 20),
                        child: MultiSelectDialogField<Doctor>(
                          dialogHeight: MediaQuery.of(context).size.width,
                          items: _doctorItems!,
                          initialValue: selectedDoctor!,
                          title: const Text(
                            "Doctors",
                            style: TextStyle(
                              color: Color(0XFF196A61),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          selectedColor: const Color(0XFF196A61),
                          selectedItemsTextStyle: const TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 16,
                            fontFamily: 'Segoe UI',
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            color: const Color(0XFFF2F1F1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                              style: BorderStyle.none,
                            ),
                          ),
                          buttonText: const Text(
                            "Doctor",
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 16,
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          onConfirm: (results) {
                            _selecteddoctors = results;
                            print(_selecteddoctors
                                .map((d) => d.username)
                                .toList());
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // 12- Nurse
                      Row(
                        children: [
                          defaultTextSegoe(
                            text: 'Nursing Stuff',
                            fontSize: 20,
                            fontFamily: 'Segoe UI Bold',
                          ),
                        ],
                      ),

                      Padding(
                        padding:
                            const EdgeInsetsDirectional.only(end: 20, top: 20),
                        child: MultiSelectDialogField<Nurse>(
                          dialogHeight: MediaQuery.of(context).size.width,
                          items: _nurseStuffItems!,
                          initialValue: selectedNurse!,
                          title: const Text(
                            "Nursing Stuff",
                            style: TextStyle(
                              color: Color(0XFF196A61),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          selectedColor: const Color(0XFF196A61),
                          selectedItemsTextStyle: const TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 16,
                            fontFamily: 'Segoe UI',
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            color: const Color(0XFFF2F1F1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                              style: BorderStyle.none,
                            ),
                          ),
                          buttonText: const Text(
                            "Nurse",
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 16,
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          onConfirm: (results) {
                            _selectedNurses = results;
                            print(_selectedNurses
                                .map((d) => d.username)
                                .toList());
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // 13- Edit Button
                      secondaryDefaultButton(
                        buttonFunction: () {
                          getCubit.updateUserData(
                            id: widget.id!,
                            name: nameController.text,
                            diseaseType: diseaseController.text,
                            roomNumber: roomController.text,
                            nationalID: idController.text,
                            phone: phoneController.text,
                            gender: genderController.text,
                            age: ageController.text,
                            status: statusController.text,
                            address: addressController.text,
                            doctors:
                                _selecteddoctors.map((d) => d.id!).toList(),
                            nurseStuff:
                                _selectedNurses.map((d) => d.id!).toList(),
                          );
                        },
                        buttonText: "Save",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
