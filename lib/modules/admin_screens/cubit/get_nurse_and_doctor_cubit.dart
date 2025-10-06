// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/patient/get_doctor_name_model.dart';
import 'package:icu_project/shared/network/end_points.dart';
import '../../../models/patient/get_nurse_name_model.dart';
import '../../../shared/network/remote/dio.dart';
import 'get_nurse_and_doctor_states.dart';

class GetNurseAndDoctorNameCubit extends Cubit<NurseAndDoctorNameStates> {
  GetNurseAndDoctorNameCubit() : super(InitialState());

  static GetNurseAndDoctorNameCubit getCubit(Context) => BlocProvider.of(Context);

  DoctorNameModel? doctorNameData;

  void doctorGetNameData() {
    emit(DoctorLoadingStates());

    DioHelper.get(url:GET_DOCTOR_NAME ).then(
      (value) {
        return value.fold((l) {
          doctorNameData = DoctorNameModel.fromJson(l);
          emit(DoctorScuseesStates(doctorNameData!));
        }, (r) => null);
      },
    );
    // .catchError((error) {
    //   print(error.toString());
    //   emit(DoctorErorrStates(error.toString()));
    // });
  }

  
  NurseNameModel? nurseNameData;

  void nurseGetNameData() {
    emit(NurseLoadingStates());

    DioHelper.get(url:GET_Nurse_NAME ).then(
      (value) {
        return value.fold((l) {
          nurseNameData = NurseNameModel.fromJson(l);
          emit(NurseScuseesStates(nurseNameData!));
        }, (r) => null);
      },
    );
    // .catchError((error) {
    //   print(error.toString());
    //   emit(NurseErorrStates(error.toString()));
    // });
  }
}
