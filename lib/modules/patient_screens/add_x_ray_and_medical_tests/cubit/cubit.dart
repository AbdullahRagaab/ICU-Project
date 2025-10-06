// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/add_x_ray/add_xray_model.dart';
import 'package:icu_project/modules/patient_screens/add_x_ray_and_medical_tests/cubit/states.dart';
import 'package:icu_project/shared/network/end_points.dart';
import 'package:path/path.dart';
import '../../../../shared/network/remote/dio.dart';

class XRayCubit extends Cubit<XRayStates> {
  XRayCubit() : super(InitialXRayState());

  static XRayCubit getCubit(Context) => BlocProvider.of(Context);

  AddXray? addXray;

  void AddXRay(
      {required String xrayName,
      required String patientID,
      required List<File> images}) {
    Future<FormData> uploadImages() async {
      List<MultipartFile> multipartFiles = [];
      for (File image in images) {
        String imageName = basename(image.path);
        var multipartFile =
            await MultipartFile.fromFile(image.path, filename: imageName);
        multipartFiles.add(multipartFile);
      }
      FormData formData = FormData.fromMap({
        'name': xrayName,
        'patient': patientID,
        'images': multipartFiles,
      });
      return formData;
    }

    emit(AddXRayLoadingState());

    uploadImages().then(
      (formData) {
        DioHelper.post(
          url: '$ADD_XRAY_IMAGE_1$patientID$ADD_XRAY_IMAGE_2',
          requestBody: formData,
        ).then(
          (value) {
            return value.fold(
              (registerResponse) {
                // Registration successful
                addXray = AddXray.fromJson(registerResponse);
                emit(AddXRayScusessState(addXray!));
              },
              (error) {
                // Registration failed
                emit(AddXRayErrorState('An error occurred. Please try again.'));
              },
            );
          },
        );
      },
    ).catchError((error) {
      print(error.toString());
      emit(AddXRayErrorState(error.toString()));
    });
  }

  void AddMedicalTest(
      {required String xrayName,
      required String patientID,
      required List<File> images}) {
    Future<FormData> uploadImages() async {
      List<MultipartFile> multipartFiles = [];
      for (File image in images) {
        String imageName = basename(image.path);
        var multipartFile =
            await MultipartFile.fromFile(image.path, filename: imageName);
        multipartFiles.add(multipartFile);
      }
      FormData formData = FormData.fromMap({
        'name': xrayName,
        'patient': patientID,
        'images': multipartFiles,
      });
      return formData;
    }

    emit(AddMedicalTestLoadingState());

    uploadImages().then(
      (formData) {
        DioHelper.post(
          url: '$ADD_XRAY_IMAGE_1$patientID$ADD_XRAY_IMAGE_3',
          requestBody: formData,
        ).then(
          (value) {
            return value.fold(
              (registerResponse) {
                // Registration successful
                addXray = AddXray.fromJson(registerResponse);
                emit(AddMedicalTestScusessState(addXray!));
              },
              (error) {
                // Registration failed
                emit(AddMedicalTestErrorState(
                    'An error occurred. Please try again.'));
              },
            );
          },
        );
      },
    ).catchError((error) {
      print(error.toString());
      emit(AddMedicalTestErrorState(error.toString()));
    });
  }
}
