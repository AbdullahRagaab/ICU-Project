// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable, unrelated_type_equality_checks

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/models/medicines_model.dart';
import 'package:icu_project/modules/notification/alarm.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/doctor_add_report.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import 'package:intl/intl.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class DoctorAddMedicine extends StatefulWidget {
  const DoctorAddMedicine({Key? key}) : super(key: key);

  @override
  DoctorAddMedicineScreenState createState() => DoctorAddMedicineScreenState();
}

class DoctorAddMedicineScreenState extends State<DoctorAddMedicine> {
  var xrayController = TextEditingController();
  var medicalTestController = TextEditingController();
  var medicineTimeController = TextEditingController();
  var medicineNameController = TextEditingController();
  var medicineDoasgeController = TextEditingController();
  var medicineQuantityController = TextEditingController();
  var medicinealarmController = TextEditingController();
  var startController = TextEditingController();
  final List<int> quantityItem = [1, 2, 3];
  final List<String> doseFrequency = [
    '1 Times',
    '2 Times',
    '3 Times',
    'Every 8h',
    'Every 24h',
  ];
  List<String> medicineName = [];
  List<String> medicineId = [];
  List<Data>? medicines = [];
  String? selectedValue;
  String? selectedName;
  String? selectedVal;
  String? id;
  int? testindex;
  DateTime? startpickedDate;
  DateTime? endpickedDate;
  final List<String> rememberTime = [
    'Yes',
    'No',
  ];
  TextEditingController startdateInput = TextEditingController();
  TextEditingController enddateInput = TextEditingController();

  @override
  void initState() {
    DoctorReportsCubit.getCubit(context).getAllMedicines();
    startdateInput.text = "";
    enddateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorReportsCubit, DoctorReports>(
        listener: (BuildContext context, state) {
      if (state is AddDoctorMedicineScusessState) {
        Fluttertoast.showToast(
          msg: DoctorReportsCubit.getCubit(context).adddoctorMedicine!.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0,
        ).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorAddReport(),
            )));
      }
    }, builder: (BuildContext context, Object? state) {
      var getCubit = DoctorReportsCubit.getCubit(context);
      medicines = getCubit.medicinesModel?.data;

      medicineName = getCubit.medicinesModel?.data
              ?.map((data) => data.name ?? '')
              .toList() ??
          [];
      medicineId = getCubit.medicinesModel?.data
              ?.map((data) => data.id ?? '')
              .toList() ??
          [];
      return Scaffold(
        appBar: AppBar(
          // 1- Icon
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DoctorAddReport()));
            },
            color: const Color(0XFF2CBBA9),
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
            ),
          ),
          // 2- App Bar Tittle
          title: defaultTextGabriola(
            text: 'Add Medicines',
            fontSize: 35,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultTextSegoe(
                    text: 'Medicine Name',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 14,
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 6,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      isExpanded: true,
                      itemPadding: const EdgeInsets.all(10),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: medicineName
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
                          return 'Please select Medicine name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        int index = medicineName.indexOf(value.toString());
                        print('index +==+=: $index');
                        if (index >= 0 && index < medicineId.length) {
                          // Retrieve the corresponding ID from the medicineId list.
                          id = medicineId[index];
                          // Do something with the selected ID, like storing it in a variable.
                          print('Selected ID: $id');
                        }
                        medicineNameController.text = value.toString();
                        testindex = index;
                      },
                      onSaved: (value) {
                        selectedName = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextSegoe(
                    text: 'Medicine Dose Frequency',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 14,
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 6,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      isExpanded: true,
                      itemPadding: const EdgeInsets.all(10),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: doseFrequency
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
                          return 'Please select Medicine Dose Frequency';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        medicineDoasgeController.text = value.toString();
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextSegoe(
                    text: 'Medicine Quantity',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 14,
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 6,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      isExpanded: true,
                      itemPadding: const EdgeInsets.all(10),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: quantityItem
                          .map((item) => DropdownMenuItem<int>(
                                value: item,
                                child: Text(
                                  '$item',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Medicine Quantity';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        medicineQuantityController.text = value.toString();
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextSegoe(
                    text: 'Medicine Time',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 14,
                  ),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 6,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        onTap: _selectTime,
                        controller: medicineTimeController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          prefixIcon: Image(
                            image: AssetImage(
                              'assets/images/UI-UX-Icons/add-medicine/clock.png',
                            ),
                            opacity: AlwaysStoppedAnimation(.7),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          labelStyle: TextStyle(
                            color: Color(0xFF6D6A6A),
                            fontFamily: 'Segoe UI',
                            fontSize: 15,
                          ),
                        ),
                        cursorColor: Colors.black,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextSegoe(
                    text: 'Days Of Dose',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 14,
                        ),
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 6,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: startdateInput,
                              readOnly: true,
                              onTap: () async {
                                startpickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100));

                                if (startpickedDate != null) {
                                  print(startpickedDate);
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(startpickedDate!);
                                  print(formattedDate);
                                  setState(() {
                                    startdateInput.text = formattedDate;
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: 'Start',
                                prefixIcon: Image(
                                  image: AssetImage(
                                    'assets/images/UI-UX-Icons/add-medicine/calendar.png',
                                  ),
                                  opacity: AlwaysStoppedAnimation(.7),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                labelStyle: TextStyle(
                                  color: Color(0xFF6D6A6A),
                                  fontFamily: 'Segoe UI',
                                  fontSize: 15,
                                ),
                              ),
                              cursorColor: Colors.black,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 14,
                        ),
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 6,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: enddateInput,
                              readOnly: true,
                              onTap: () async {
                                endpickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100));

                                if (endpickedDate != null) {
                                  print(endpickedDate);
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(endpickedDate!);
                                  print(formattedDate);
                                  setState(() {
                                    enddateInput.text = formattedDate;
                                  });
                                } else {}
                              },
                              decoration: const InputDecoration(
                                labelText: 'End',
                                prefixIcon: Image(
                                  image: AssetImage(
                                    'assets/images/UI-UX-Icons/add-medicine/calendar.png',
                                  ),
                                  opacity: AlwaysStoppedAnimation(.7),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                labelStyle: TextStyle(
                                  color: Color(0xFF6D6A6A),
                                  fontFamily: 'Segoe UI',
                                  fontSize: 15,
                                ),
                              ),
                              cursorColor: Colors.black,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextSegoe(
                    text: 'Add Reminder Time',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 14,
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 6,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        prefixIcon: const Image(
                          image: AssetImage(
                            'assets/images/UI-UX-Icons/add-medicine/alarm-clock.png',
                          ),
                          opacity: AlwaysStoppedAnimation(.7),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      isExpanded: true,
                      itemPadding: const EdgeInsets.all(5),
                      hint: const Text(
                        'Yes',
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: rememberTime
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
                          return 'Please Add Remember Time';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        medicinealarmController.text = value.toString();
                      },
                      onSaved: (value) {
                        selectedVal = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ConditionalBuilder(
                  condition: state is! AddDoctorMedicineLoadingState,
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      secondaryDefaultButton(
                          buttonFunction: () {
                            print(medicineNameController.text);
                            print(medicineDoasgeController.text);
                            print(medicineQuantityController.text);
                            print(medicineTimeController.text);
                            print(startdateInput.text);
                            print(enddateInput.text);
                            print(medicinealarmController.text);
                            print(id);
                            print(testindex);
                            if (medicinealarmController.text == 'Yes') {
                              print("***********************ALarm");
                              Alarm alarm = Alarm();
                              alarm.scheduleMedicationReminder(
                                patientName!,
                                patientRoom!.toString(),
                                medicineNameController.text,
                                medicineDoasgeController.text,
                                medicineQuantityController.text,
                                _time,
                                startpickedDate!,
                                endpickedDate!,
                              );
                            }

                            getCubit.AddDoctorsMedicine(
                              time: medicineTimeController.text,
                              quantity: medicineQuantityController.text,
                              medicinedosage: medicineDoasgeController.text,
                              medicineName: id!,
                              patientID: patientId!,
                              start: startdateInput.text,
                              end: enddateInput.text,
                            );
                          },
                          buttonText: 'Add'),
                    ],
                  ),
                  fallback: (context) {
                    if (state is AddDoctorMedicineErrorState) {
                      String errorMessage =
                          'An error occurred. Please try again.';
                      if (state.error is DioError) {
                        final dioError = state.error as DioError;
                        if (dioError.response?.statusCode == 400) {
                          errorMessage = 'Invalid email or password.';
                        }
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          secondaryDefaultButton(
                              buttonFunction: () {
                                print(medicineNameController.text);
                                print(medicineDoasgeController.text);
                                print(medicineQuantityController.text);
                                print(medicineTimeController.text);
                                print(startdateInput.text);
                                print(enddateInput.text);
                                print(medicinealarmController.text);
                                print(id);
                                print(testindex);
                                if (medicinealarmController.text == 'Yes') {
                                  print("***********************ALarm");
                                  Alarm alarm = Alarm();
                                  alarm.scheduleMedicationReminder(
                                    patientName!,
                                    patientRoom!.toString(),
                                    medicineNameController.text,
                                    medicineDoasgeController.text,
                                    medicineQuantityController.text,
                                    _time,
                                    startpickedDate!,
                                    endpickedDate!,
                                  );
                                }
                                getCubit.AddDoctorsMedicine(
                                  time: medicineTimeController.text,
                                  quantity: medicineQuantityController.text,
                                  medicinedosage: medicineDoasgeController.text,
                                  medicineName: id!,
                                  patientID: patientId!,
                                  start: startdateInput.text,
                                  end: enddateInput.text,
                                );
                              },
                              buttonText: 'Add'),
                        ],
                      );
                    } else {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Color(0XFF196A61)),
                      );
                    }
                    // return const Center(
                    //   child: CircularProgressIndicator(
                    //       color: Color(0XFF196A61)),
                    // );
                  },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     secondaryDefaultButton(
                //         buttonFunction: () {
                //           print(medicineNameController.text);
                //           print(medicineDoasgeController.text);
                //           print(medicineQuantityController.text);
                //           print(medicineTimeController.text);
                //           print(startdateInput.text);
                //           print(enddateInput.text);
                //           print(medicinealarmController.text);
                //           print(id);
                //           print(testindex);
                //           if (medicinealarmController.text == 'Yes') {
                //             print("***********************ALarm");
                //             Alarm alarm = Alarm();
                //             alarm.scheduleMedicationReminder(
                //               patientName!,
                //               patientRoom!.toString(),
                //               medicineNameController.text,
                //               medicineDoasgeController.text,
                //               medicineQuantityController.text,
                //               _time,
                //               startpickedDate!,
                //               endpickedDate!,
                //             );
                //           }

                //           getCubit.AddDoctorsMedicine(
                //             time: medicineTimeController.text,
                //             quantity: medicineQuantityController.text,
                //             medicinedosage: medicineDoasgeController.text,
                //             medicineName: id!,
                //             patientID: patientId!,
                //             start: startdateInput.text,
                //             end: enddateInput.text,
                //           );
                //         },
                //         buttonText: 'Add'),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }

  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        medicineTimeController.text = newTime.format(context).toString();
      });
    }
  }
}
