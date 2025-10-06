// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/available_patients/patients.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_states.dart';
import 'package:icu_project/modules/admin_screens/cubit/patient_cubit.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../models/patient/get_all_patients_model.dart';
import '../../../shared/components/components.dart';
import 'edit_patient_data.dart';

class PatientDataScreen extends StatefulWidget {
  String? name, phone, address, nat_id, disease, status, gender, age, room, id;
  int? index;
  List<Doctor>? doctor;
  List<Nurse>? nurse;
  PatientDataScreen({
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
    this.index,
  }) : super(key: key);

  @override
  State<PatientDataScreen> createState() => _PatientDataScreenState();
}

class _PatientDataScreenState extends State<PatientDataScreen> {
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
      listener: (context, state) {},
      builder: (context, state) {
        var getCubit = PatientCubit.getCubit(context);

        final List<Doctor>? doctor = widget.doctor;

        final _doctors = doctor
            ?.map((doctor) => MultiSelectItem(doctor, doctor.username!))
            .toList();

        final List<Nurse>? nurse = widget.nurse;

        final _nurseStuffItems = nurse
            ?.map((nurse) => MultiSelectItem(nurse, nurse.username!))
            .toList();

        return Scaffold(
          appBar: AppBar(
            // 1- Icon
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AvailablePatientScreen(),
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
              text: 'Patient Data',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
            condition: state is! PatientLoadingStates,
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
                        controller: nameController,
                        mainText: 'Name',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].name
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 2- Roll
                      defaultAboutMeInformation(
                        controller: rollController,
                        mainText: 'Roll',
                        data: 'Patient',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 3- Phone
                      defaultAboutMeInformation(
                        controller: phoneController,
                        mainText: 'Phone',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].phone
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 4- Address
                      defaultAboutMeInformation(
                        controller: addressController,
                        mainText: 'Address',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].address
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 5- ID
                      defaultAboutMeInformation(
                        controller: idController,
                        mainText: 'ID',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].nationalId
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 6- Disease
                      defaultAboutMeInformation(
                        controller: diseaseController,
                        mainText: 'Disease',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].diseaseType
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 7- Status
                      defaultAboutMeInformation(
                        controller: statusController,
                        mainText: 'Status',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].status
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 8- Gender
                      defaultAboutMeInformation(
                        controller: genderController,
                        mainText: 'Gender',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].gender
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 9- Age
                      defaultAboutMeInformation(
                        controller: ageController,
                        mainText: 'Age',
                        data: getCubit.getPatientModel?.data?[widget.index!].age
                            .toString() as String,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 10- Room
                      defaultAboutMeInformation(
                        controller: roomController,
                        mainText: 'Room',
                        data: getCubit
                            .getPatientModel?.data?[widget.index!].roomNumber
                            .toString() as String,
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
                          items: _doctors!,
                          initialValue: doctor!,
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
                          initialValue: nurse!,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPatientDataScreen(
                                id: widget.id,
                                name: widget.name,
                                address: widget.address,
                                age: widget.age,
                                disease: widget.disease,
                                gender: widget.gender,
                                nat_id: widget.nat_id,
                                phone: widget.phone,
                                room: widget.room,
                                status: widget.status,
                                doctor: widget.doctor,
                                nurse: widget.nurse,
                              ),
                            ),
                          );
                        },
                        buttonText: "Edit",
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
