// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/admin_screens/available_doctors/doctors.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_cubit.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_states.dart';
import '../../../shared/components/components.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class AddDocter extends StatefulWidget {
  const AddDocter({Key? key}) : super(key: key);

  @override
  AddDoctorState createState() => AddDoctorState();
}

class AddDoctorState extends State<AddDocter> {
  var nameController = TextEditingController();
  var userNameController = TextEditingController();
  var telephoneController = TextEditingController();
  var idController = TextEditingController();
  var addressController = TextEditingController();
  var diseaseController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var ageController = TextEditingController();

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final List<String> statusItems = [
    'Single',
    'Married',
    'Divorced',
  ];
  final List<String> specialistItems = [
    'Heart Surgeon',
    'Rectal Surgeon',
    'Hermatologist',
  ];

  String? selectedValue;

  var statusValue;
  var specialistValue;
  var genderValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
      listener: (BuildContext context, state) {
        if (state is SignUpScusessState) {
          Fluttertoast.showToast(
              msg: "Doctor Added Scussesfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AvailableDoctorScreen(),
            ),
          );
        }
      },
      builder: (BuildContext context, Object? state) {
        var getCubit = UserSignUpCubit.getCubit(context);
        // *** STARTING OG OUR BODY ***
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
              text: 'Add New Doctor',
              fontSize: 35,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(36.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                      height: 25,
                    ),
                    defaultTextFeild(
                      controller: userNameController,
                      type: TextInputType.name,
                      labelText: 'UserName',
                      prefix: const AssetImage(
                        'assets/images/UI-UX-Icons/login,signup/name.png',
                      ),
                      submitFunction: (String? value) {
                        return value;
                      },
                      validFunction: (String? value) {
                        if (value!.isEmpty) {
                          return 'User Name mustn\'t be empty';
                        } else if (value.length < 3) {
                          return ('This user name is too short');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    defaultTextFeild(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      labelText: 'Email Address',
                      prefix: const AssetImage(
                        'assets/images/UI-UX-Icons/login,signup/email.png',
                      ),
                      submitFunction: (String? value) {
                        return value;
                      },
                      validFunction: (String? value) {
                        if (value!.isEmpty) {
                          return ('Email Address mustn\'t be empty');
                        }
                        return null;
                      },
                    ),
                    // 3.2- Password
                    const SizedBox(
                      height: 25,
                    ),
                    defaultTextFeild(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      isPassword: getCubit.isPassword,
                      labelText: 'Password',
                      prefix: const AssetImage(
                        'assets/images/UI-UX-Icons/login,signup/lock.png',
                      ),
                      suffix: getCubit.isPassword
                          ? const AssetImage(
                              'assets/images/UI-UX-Icons/login,signup/invisable.png',
                            )
                          : const AssetImage(
                              'assets/images/UI-UX-Icons/login,signup/eye.png',
                            ),
                      onTapSuffixIconFunction: () {
                        getCubit.isPasswordShown();
                      },
                      submitFunction: (String? value) {
                        return value;
                      },
                      validFunction: (String? value) {
                        if (value!.isEmpty) {
                          return ('Password mustn\'t be empty');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
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
                      height: 25,
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
                      height: 25,
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
                      height: 25,
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
                                return 'Please select status';
                              }
                            },
                            onChanged: (value) {
                              setState(() => statusValue = value);
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
                                return 'Please select gender';
                              }
                            },
                            onChanged: (value) {
                              setState(() => genderValue = value);
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Specialist
                        Container(
                          height: 50,
                          width: 155,
                          color: Colors.white,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              prefixIcon: const Image(
                                image: AssetImage(
                                  'assets/images/UI-UX-Icons/add-new-doctor-and-new-nurse/spacialist.png',
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
                              'Specialist',
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
                            items: specialistItems
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
                                return 'Please select specialist';
                              }
                            },
                            onChanged: (value) {
                              setState(() => specialistValue = value);
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
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
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),

                    ConditionalBuilder(
                      condition: state is! SignUpLoadingState,
                      builder: (context) => Container(
                          alignment: Alignment.center,
                          child: secondaryDefaultButton(
                            buttonFunction: () {
                              if (formKey.currentState!.validate()) {
                                getCubit.userRegister(
                                    role: 'doctor',
                                    email: emailController.text,
                                    name: nameController.text,
                                    userName: userNameController.text,
                                    phone: telephoneController.text,
                                    password: passwordController.text,
                                    age: ageController.text,
                                    gender: genderValue,
                                    nationalID: idController.text,
                                    specialization: specialistValue,
                                    status: statusValue,
                                    address: addressController.text);
                              }
                            },
                            buttonText: 'ADD',
                          )),
                      fallback: (context) {
                        if (state is SignUpErrorState) {
                          String errorMessage =
                              'An error occurred. Please try again.';
                          if (state.error is DioError) {
                            final dioError = state.error as DioError;
                            if (dioError.response?.statusCode == 400) {
                              errorMessage = 'Invalid email or password.';
                            }
                          }
                          return Container(
                            alignment: Alignment.center,
                            child: secondaryDefaultButton(
                              buttonFunction: () {
                                if (formKey.currentState!.validate()) {
                                  getCubit.userRegister(
                                      role: 'doctor',
                                      email: emailController.text,
                                      name: nameController.text,
                                      userName: userNameController.text,
                                      phone: telephoneController.text,
                                      password: passwordController.text,
                                      age: ageController.text,
                                      gender: genderValue,
                                      nationalID: idController.text,
                                      specialization: specialistValue,
                                      status: statusValue,
                                      address: addressController.text);
                                }
                              },
                              buttonText: 'ADD',
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: Color(0XFF196A61)),
                          );
                        }
                        // return const Center(
                        //   child: CircularProgressIndicator(
                        //       color: Color(0XFF196A61)),
                        // );
                      },
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
