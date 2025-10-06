// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, unused_local_variable, unused_element, unnecessary_this, avoid_print, deprecated_member_use, unnecessary_null_comparison, body_might_complete_normally_nullable, unnecessary_nullable_for_final_variable_declarations

import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu_project/modules/patient_screens/add_x_ray_and_medical_tests/cubit/cubit.dart';
import 'package:icu_project/modules/patient_screens/add_x_ray_and_medical_tests/cubit/states.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared/components/components.dart';
import '../nurse_reports/nurse_add_report.dart';

class XRayScreen extends StatefulWidget {
  const XRayScreen({Key? key}) : super(key: key);

  @override
  XRayScreenState createState() => XRayScreenState();
}

class XRayScreenState extends State<XRayScreen> {
  var selectedDate;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  List<File> images = [];

  // Function to open the image picker and select multiple images
  Future<void> pickImages() async {
    final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      images = selectedImages.map((image) => File(image.path)).toList();
    }
  }
  // List list = [];

  // File? image;
  // // Get Image From Gallery
  // Future imageFromGallery() async {
  //   final pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //   );

  //   setState(() {
  //     image = File(pickedFile!.path);
  //   });
  // }
  //
  // void pickedImage() {
  //   showDialog<ImageSource>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //         alignment: Alignment.center,
  //         shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //         title: Center(
  //           child: defaultTextSegoe(
  //             text: "Choose Image Source",
  //             color: const Color(0XFF43494B),
  //             fontSize: 20,
  //           ),
  //         ),
  //         actionsAlignment: MainAxisAlignment.spaceBetween,
  //         actionsPadding: const EdgeInsets.symmetric(vertical: 30),
  //         actions: [
  //           MaterialButton(
  //             child: Column(
  //               children: [
  //                 const Image(
  //                     image: AssetImage(
  //                         'assets/images/UI-UX-Photos/photo-camera.png')),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 defaultTextSegoe(
  //                   text: "Camera",
  //                   color: const Color(0XFF43494B),
  //                   fontSize: 18,
  //                 ),
  //               ],
  //             ),
  //             onPressed: () => imageFromCamera(),
  //           ),
  //           MaterialButton(
  //             child: Column(
  //               children: [
  //                 const Image(
  //                     image:
  //                         AssetImage('assets/images/UI-UX-Photos/image.png')),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 defaultTextSegoe(
  //                   text: "Gallery",
  //                   color: const Color(0XFF43494B),
  //                   fontSize: 18,
  //                 ),
  //               ],
  //             ),
  //             onPressed: () => imageFromGallery(),
  //           ),
  //         ]),
  //   );
  // }
  // // Get Image From Camera
  // Future imageFromCamera() async {
  //   final pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //   );

  //   setState(() {
  //     image = File(pickedFile!.path);
  //   });
  // }

  // void pickedImage() {
  //   showDialog<ImageSource>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //         alignment: Alignment.center,
  //         shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //         title: Center(
  //           child: defaultTextSegoe(
  //             text: "Choose Image Source",
  //             color: const Color(0XFF43494B),
  //             fontSize: 20,
  //           ),
  //         ),
  //         actionsAlignment: MainAxisAlignment.spaceBetween,
  //         actionsPadding: const EdgeInsets.symmetric(vertical: 30),
  //         actions: [
  //           FlatButton(
  //             child: Column(
  //               children: [
  //                 const Image(
  //                     image: AssetImage(
  //                         'assets/images/UI-UX-Photos/photo-camera.png')),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 defaultTextSegoe(
  //                   text: "Camera",
  //                   color: const Color(0XFF43494B),
  //                   fontSize: 18,
  //                 ),
  //               ],
  //             ),
  //             onPressed: () => imageFromCamera(),
  //           ),
  //           FlatButton(
  //             child: Column(
  //               children: [
  //                 const Image(
  //                     image:
  //                         AssetImage('assets/images/UI-UX-Photos/image.png')),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 defaultTextSegoe(
  //                   text: "Gallery",
  //                   color: const Color(0XFF43494B),
  //                   fontSize: 18,
  //                 ),
  //               ],
  //             ),
  //             onPressed: () => imageFromGallery(),
  //           ),
  //         ]),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XRayCubit, XRayStates>(
        listener: (BuildContext context, state) {
      if (state is AddXRayScusessState) {
        Fluttertoast.showToast(
          msg: XRayCubit.getCubit(context).addXray!.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0,
        ).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NurseAddReport(
                patientID: patientId,
                doctorID: doctorOrNurseId,
              ),
            )));
      }
    }, builder: (BuildContext context, Object? state) {
      var getCubit = XRayCubit.getCubit(context);
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
            text: 'X-Ray And Medical Tests',
            fontSize: 35,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 10,
                          top: 10,
                          bottom: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1- Name of X-Ray or Medical Test
                            defaultTextSegoe(
                              text: 'X-ray Name',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  top: 8,
                                ),
                                child: SizedBox(
                                    width: 355,
                                    child: TextFormField(
                                      controller: nameController,
                                      autofocus: false,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'XRay name field mustn\'t be empty';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          color: Colors.red[400],
                                          backgroundColor:
                                              const Color(0xFFf5c6c0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        labelStyle: const TextStyle(
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
                      ),
                      defaultTextSegoe(
                          text: 'Select one image or more',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 10),
                        child: Container(
                          width: 355,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // 2- Adding Results
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == images.length) {
                                      return SizedBox(
                                        // width: 250,
                                        // height: 130,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final List<XFile>? pickedImages =
                                                await ImagePicker()
                                                    .pickMultiImage();
                                            if (pickedImages != null) {
                                              setState(() {
                                                images.addAll(pickedImages.map(
                                                    (image) =>
                                                        File(image.path)));
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 35),
                                            child: Image.asset(
                                              'assets/images/UI-UX-Icons/add-xray-medical-tests/add-image.png',
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Image.file(
                                            images[index],
                                            width: 250,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ConditionalBuilder(
                    condition: state is! AddXRayLoadingState,
                    builder: (context) => Padding(
                      padding: const EdgeInsetsDirectional.only(top: 100),
                      child: secondaryDefaultButton(
                        buttonText: 'Upload',
                        buttonFunction: (() {
                          print(nameController.text);
                          print(images);
                          if (formKey.currentState!.validate()) {
                            if (images.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'Image is required',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black45,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              getCubit.AddXRay(
                                  xrayName: nameController.text,
                                  patientID: patientId!,
                                  images: images);
                            }
                          }
                        }),
                      ),
                    ),
                    fallback: (context) {
                      if (state is AddXRayErrorState) {
                        String errorMessage =
                            'An error occurred. Please try again.';
                        if (state.error is DioError) {
                          final dioError = state.error as DioError;
                          if (dioError.response?.statusCode == 400) {
                            errorMessage = 'Invalid email or password.';
                          }
                        }
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(top: 100),
                          child: secondaryDefaultButton(
                            buttonText: 'Upload',
                            buttonFunction: (() {
                              print(nameController.text);
                              print(images);

                              if (formKey.currentState!.validate()) {
                                if (images.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: 'Image is required',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } else {
                                  getCubit.AddXRay(
                                      xrayName: nameController.text,
                                      patientID: patientId!,
                                      images: images);
                                }
                              }
                            }),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsetsDirectional.only(top: 100),
                          child: Center(
                            child: CircularProgressIndicator(
                                color: Color(0XFF196A61)),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
