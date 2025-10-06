// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/patient/get_doctor_name_model.dart';
import 'package:icu_project/shared/network/local/cache_helper.dart';
import '../../../models/patient/get_all_patients_model.dart';
import '../../../models/patient/get_nurse_name_model.dart';
import '../../../models/patient/patient_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio.dart';
import 'doctor_states.dart';

class PatientCubit extends Cubit<UserSignUpStates> {
  PatientCubit() : super(InitialPatientState());

  static PatientCubit getCubit(Context) => BlocProvider.of(Context);

  PatientModel? patientModel;

  PatientDataModel? getPatientModel;

  DoctorNameModel? doctorNameModel;

  NurseNameModel? nurseNameModel;

  bool isPassword = true;

  void isPasswordShown() {
    isPassword = !isPassword;
    emit(IsPasswordState());
  }

  void patient({
    required String name,
    required String diseaseType,
    required String address,
    required int roomNumber,
    required int nationalID,
    required String gender,
    required int age,
    required String phone,
    required String status,
    required List<String> doctors,
    required List<String> nurseStuff,
  }) {
    emit(AddPatientStateLoading());
    DioHelper.post(url: ADDPATIENT, requestBody: {
      'name': name,
      'disease_type': diseaseType,
      'address': address,
      'room_number': roomNumber,
      'nat_id': nationalID,
      'gender': gender,
      'age': age,
      'phone': phone,
      'status': status,
      'doctor': doctors,
      'nurse': nurseStuff,
    }).then((value) {
      return value.fold(
        (registerResponse) {
          // Registration successful
          patientModel = PatientModel.fromJson(registerResponse);
          print(patientModel!.message);
          emit(PatientScusessState(patientModel));
        },
        (error) {
          // Registration failed
          emit(SignUpErrorState('An error occurred. Please try again.'));
        },
      );
      // return value.fold((l) {
      //   patientModel = PatientModel.fromJson(l);
      //   print(patientModel!.message);

      //   emit(PatientScusessState(patientModel));
      // }, (r) => null);
    }).catchError((error) {
      print(error.toString());
      emit(PatientErrorState(error.toString()));
    });
  }

  void getPatientData({String? search}) {
    emit(PatientLoadingStates());

    DioHelper.get(url: GET_PATIENTS).then(
      (value) {
        return value.fold((l) {
          print(l);
          print("---------");
          getPatientModel = PatientDataModel.fromJson(l);
          emit(PatientScusessStates(getPatientModel!));
        }, (r) => null);
      },
    );
    // .catchError((error) {
    //   print(error.toString());
    //   emit(PatientErrorState(error.toString()));
    // });
  }

  void searchPatient({String? search}) {
    emit(SearchPatientLoadingStates());

    DioHelper.get(url: "$GET_PATIENTS?name=$search", additionalHeaders: {
      'Authorization': 'Token ${CacheHelper.getData(key: "token")}',
    }).then(
      (value) {
        return value.fold((l) {
          print(l);
          print("---------");
          getPatientModel = PatientDataModel.fromJson(l);
          emit(SearchPatientScusessStates(getPatientModel!));
        }, (r) => null);
      },
    );
    // .catchError((error) {
    //   print(error.toString());
    //   emit(SearchPatientErrorState(error.toString()));
    // });
  }

  bool isEnabled = true;

  void updateUserData({
    required String name,
    required String id,
    required String diseaseType,
    required String roomNumber,
    required String nationalID,
    required String phone,
    required String gender,
    required String age,
    required String status,
    required String address,
    required List<String> doctors,
    required List<String> nurseStuff,
  }) {
    emit(PatientUpdateLoadingStates());

    DioHelper.put(url: 'patients/$id', requestBody: {
      'name': name,
      'disease_type': diseaseType,
      'room_number': roomNumber,
      'nat_id': nationalID,
      'id': id,
      'phone': phone,
      'gender': gender,
      'age': age,
      'status': status,
      'address': address,
      'doctor': doctors,
      'nurse': nurseStuff,
    }).then(
      (value) {
        return value.fold((l) {
          getPatientModel = PatientDataModel.fromJson(l);
          emit(PatientUpdateScusessStates(getPatientModel!));
        }, (r) => null);
      },
    );
    // .catchError((error) {
    //   print(error.toString());
    //   emit(PatientUpdateErrorStates(error.toString()));
    // });
  }

  void getDoctorName() {
    emit(GetDoctorNameLoadingStates());
    DioHelper.get(url: GET_DOCTOR_NAME).then(
      (value) {
        return value.fold((l) {
          doctorNameModel = DoctorNameModel.fromJson(l);
          emit(GetDoctorNameScusessStates(doctorNameModel!));
        }, (r) => null);
      },
    );
  }

  void getNurseName() {
    emit(GetNurseNameLoadingStates());
    DioHelper.get(url: GET_Nurse_NAME).then(
      (value) {
        return value.fold((l) {
          nurseNameModel = NurseNameModel.fromJson(l);
          emit(GetNurseNameScusessStates(nurseNameModel!));
        }, (r) => null);
      },
    );
  }
}
