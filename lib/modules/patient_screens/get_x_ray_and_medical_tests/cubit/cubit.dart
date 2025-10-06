// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/get_x_ray_and_medical_tests/cubit/states.dart';
import 'package:icu_project/shared/network/end_points.dart';
import '../../../../models/get_x_ray/get_medical_model.dart';
import '../../../../models/get_x_ray/get_x_ray_model.dart';
import '../../../../shared/network/remote/dio.dart';

class GetXRayCubit extends Cubit<GetXRayStates> {
  GetXRayCubit() : super(InitialGetXRayState());

  static GetXRayCubit getCubit(Context) => BlocProvider.of(Context);

 GetXrayImageModel? getXrayImageModel ;
  void getXrayImages({ required String patientID}) {
    emit(GetXRayLoadingState());
    DioHelper.get(url: '$ADD_XRAY_IMAGE_1$patientID$ADD_XRAY_IMAGE_2').then((value) {
      return value.fold((l) {
        getXrayImageModel = GetXrayImageModel.fromJson(l);
        emit(GetXRayScusessState(getXrayImageModel!));
      }, (r) => null);
    });
  }

  GetMedicalImageModel? getMedicalImageModel ;
  void getMedicalImages({ required String patientID}) {
    emit(GetMedicalLoadingState());
    DioHelper.get(url: '$ADD_XRAY_IMAGE_1$patientID$ADD_XRAY_IMAGE_3').then((value) {
      return value.fold((l) {
        getMedicalImageModel = GetMedicalImageModel.fromJson(l);
        emit(GetMedicalScusessState(getMedicalImageModel!));
      }, (r) => null);
    });
  }
}
