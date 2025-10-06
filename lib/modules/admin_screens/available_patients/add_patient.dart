// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable, avoid_print, unused_field, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/models/patient/get_doctor_name_model.dart'
    as doctor;
import 'package:icu_project/models/patient/get_nurse_name_model.dart';
import 'package:icu_project/modules/admin_screens/available_patients/patients.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_states.dart';
import '../cubit/patient_cubit.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Add_patient extends StatefulWidget {
  const Add_patient({Key? key}) : super(key: key);

  @override
  State<Add_patient> createState() => _Add_patientState();
}

class _Add_patientState extends State<Add_patient> {
  var nameController = TextEditingController();

  var telephoneController = TextEditingController();

  var idController = TextEditingController();

  var addressController = TextEditingController();

  var diseaseController = TextEditingController();

  var ageController = TextEditingController();

  var roomController = TextEditingController();

  var statusValue;

  var genderValue;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  final List<String> statusItems = [
    'Single',
    'Married',
    'Divorced',
  ];

  List<doctor.Data> _selectedDoctor = [];

  List<Data> _selectedNurses = [];

  String? selectedValue;

  // @override
  // void initState() {
  //   super.initState();
  //   PatientCubit.getCubit(context).getDoctorName();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, UserSignUpStates>(
      listener: (BuildContext context, Object? state) {
        if (state is PatientScusessState) {
          Fluttertoast.showToast(
              msg: "Patient Added Scussesfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AvailablePatientScreen(),
            ),
          );
        } else if (state is PatientErrorState) {
          Fluttertoast.showToast(
              msg: "Something Wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (BuildContext context, state) {
        var getCubit = PatientCubit.getCubit(context);
        final List<doctor.Data>? doctors =
            PatientCubit.getCubit(context).doctorNameModel?.data;

        final _doctorItems = doctors
            ?.map((doctor) => MultiSelectItem(doctor, doctor.username!))
            .toList();

        final List<Data>? nurse =
            PatientCubit.getCubit(context).nurseNameModel?.data;

        final _nurseStuffItems = nurse
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
              text: 'Add New Patient',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            condition: PatientCubit.getCubit(context).doctorNameModel != null,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(36.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      defaultTextFeild(
                        controller: nameController,
                        type: TextInputType.name,
                        labelText: 'Name',
                        prefix: const AssetImage(
                          'assets/images/UI-UX-Icons/login,signup/name.png',
                        ),
                        submitFunction: (String? value) {
                          return value;
                        },
                        validFunction: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name mustn\'t be empty';
                          } else if (value.length < 3) {
                            return ('This name is too short');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextFeild(
                        controller: telephoneController,
                        type: TextInputType.number,
                        labelText: 'Telephone Number',
                        prefix: const AssetImage(
                          'assets/images/UI-UX-Icons/login,signup/telephone_number.png',
                        ),
                        submitFunction: (String? value) {
                          return value;
                        },
                        validFunction: (String? value) {
                          if (value!.isEmpty) {
                            return 'Telephone Number mustn\'t be empty';
                          } else if (value.length < 11) {
                            return ('This is non valid number');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextFeild(
                        controller: addressController,
                        type: TextInputType.name,
                        labelText: 'Address',
                        prefix: const AssetImage(
                          'assets/images/UI-UX-Icons/add-new-patient/address.png',
                        ),
                        submitFunction: (String? value) {
                          return value;
                        },
                        validFunction: (String? value) {
                          if (value!.isEmpty) {
                            return 'Address mustn\'t be empty';
                          } else if (value.length < 3) {
                            return ('This name is too short');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextFeild(
                        controller: idController,
                        type: TextInputType.number,
                        labelText: 'ID',
                        prefix: const AssetImage(
                          'assets/images/UI-UX-Icons/add-new-patient/id.png',
                        ),
                        submitFunction: (String? value) {
                          return value;
                        },
                        validFunction: (String? value) {
                          if (value!.isEmpty) {
                            return 'ID mustn\'t be empty';
                          } else if (value.length < 11) {
                            return ('This is non valid number');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextFeild(
                        controller: diseaseController,
                        type: TextInputType.name,
                        labelText: 'Disease Type',
                        prefix: const AssetImage(
                          'assets/images/UI-UX-Icons/add-new-patient/disease_type.png',
                        ),
                        submitFunction: (String? value) {
                          return value;
                        },
                        validFunction: (String? value) {
                          if (value!.isEmpty) {
                            return 'Disease Type mustn\'t be empty';
                          } else if (value.length < 3) {
                            return ('This name is too short');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Status
                          Container(
                            height: 50,
                            width: 155,
                            color: Colors.white,
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                prefixIcon: const Image(
                                  image: AssetImage(
                                    'assets/images/UI-UX-Icons/add-new-patient/status.png',
                                  ),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              isExpanded: true,
                              itemPadding: const EdgeInsets.all(0),
                              hint: const Text(
                                'Status',
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              items: statusItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your status';
                                }
                              },
                              onChanged: (value) {
                                setState(() => statusValue = value);
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          // Gender
                          Container(
                            height: 50,
                            width: 155,
                            color: Colors.white,
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                prefixIcon: const Image(
                                  image: AssetImage(
                                    'assets/images/UI-UX-Icons/add-new-patient/gender.png',
                                  ),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              isExpanded: true,
                              itemPadding: const EdgeInsets.all(0),
                              hint: const Text(
                                'Gender',
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              items: genderItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your gender';
                                }
                              },
                              onChanged: (value) {
                                setState(() => genderValue = value);
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Age
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                width: 155,
                                height: 50,
                                color: Colors.white,
                                child: NumberInputWithIncrementDecrement(
                                  controller: ageController,
                                  numberFieldDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  widgetContainerDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(0)),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  min: 1,
                                  max: 100,
                                  initialValue: 20,
                                  incIconSize: 20,
                                  decIconSize: 20,
                                  incIconColor: Colors.black45,
                                  decIconColor: Colors.black45,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 10,
                                ),
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/UI-UX-Icons/add-new-doctor-and-new-nurse/age.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          // Room
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                width: 155,
                                height: 50,
                                color: Colors.white,
                                child: NumberInputWithIncrementDecrement(
                                  controller: roomController,
                                  numberFieldDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  widgetContainerDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(0)),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  min: 1,
                                  max: 50,
                                  initialValue: 1,
                                  incIconSize: 20,
                                  decIconSize: 20,
                                  incIconColor: Colors.black45,
                                  decIconColor: Colors.black45,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 10,
                                ),
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/UI-UX-Icons/add-new-patient/room.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            child: MultiSelectDialogField<doctor.Data>(
                              dialogHeight: MediaQuery.of(context).size.width,
                              items: _doctorItems!,
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

                              // selectedColor: Colors.blue,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFF707070),
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
                                _selectedDoctor = results;
                                print(_selectedDoctor
                                    .map((d) => d.username)
                                    .toList());
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            child: MultiSelectDialogField<Data>(
                              dialogHeight: MediaQuery.of(context).size.width,
                              items: _nurseStuffItems!,
                              title: const Text(
                                "Nurse Stuff",
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
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFF707070),
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
                        ],
                      ),
                      ConditionalBuilder(
                        condition: state is! AddPatientStateLoading,
                        builder: (context) => Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: secondaryDefaultButton(
                              buttonFunction: () {
                                getCubit.patient(
                                  name: nameController.text,
                                  diseaseType: diseaseController.text,
                                  address: addressController.text,
                                  roomNumber: int.parse(roomController.text),
                                  nationalID: int.parse(idController.text),
                                  gender: genderValue,
                                  age: int.parse(ageController.text),
                                  phone: telephoneController.text,
                                  status: statusValue,
                                  doctors: _selectedDoctor
                                      .map((d) => d.id!)
                                      .toList(),
                                  nurseStuff: _selectedNurses
                                      .map((d) => d.id!)
                                      .toList(),
                                );
                              },
                              buttonText: 'ADD',
                            ),
                          ),
                        ),
                        fallback: (context) {
                          if (state is PatientErrorState) {
                            String errorMessage =
                                'An error occurred. Please try again.';
                            if (state.error is DioError) {
                              final dioError = state.error as DioError;
                              if (dioError.response?.statusCode == 400) {
                                errorMessage = 'Invalid email or password.';
                              }
                            }
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: secondaryDefaultButton(
                                  buttonFunction: () {
                                    getCubit.patient(
                                      name: nameController.text,
                                      diseaseType: diseaseController.text,
                                      address: addressController.text,
                                      roomNumber:
                                          int.parse(roomController.text),
                                      nationalID: int.parse(idController.text),
                                      gender: genderValue,
                                      age: int.parse(ageController.text),
                                      phone: telephoneController.text,
                                      status: statusValue,
                                      doctors: _selectedDoctor
                                          .map((d) => d.id!)
                                          .toList(),
                                      nurseStuff: _selectedNurses
                                          .map((d) => d.id!)
                                          .toList(),
                                    );
                                  },
                                  buttonText: 'ADD',
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0XFF196A61)),
                            );
                          }
                        },
                      ),
                      // Center(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 40),
                      //     child: secondaryDefaultButton(
                      //       buttonFunction: () {
                      //         getCubit.patient(
                      //           name: nameController.text,
                      //           diseaseType: diseaseController.text,
                      //           address: addressController.text,
                      //           roomNumber: int.parse(roomController.text),
                      //           nationalID: int.parse(idController.text),
                      //           gender: genderValue,
                      //           age: int.parse(ageController.text),
                      //           phone: telephoneController.text,
                      //           status: statusValue,
                      //           doctors:
                      //               _selectedDoctor.map((d) => d.id!).toList(),
                      //           nurseStuff:
                      //               _selectedNurses.map((d) => d.id!).toList(),
                      //         );
                      //       },
                      //       buttonText: 'ADD',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
          ),
        );
      },
    );
  }
}
