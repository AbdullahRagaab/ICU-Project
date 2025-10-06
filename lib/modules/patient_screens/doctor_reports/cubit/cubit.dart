// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/doctor_reports/add_medicine.dart';
import 'package:icu_project/models/doctor_reports/edit_report.dart';
import 'package:icu_project/modules/patient_screens/doctor_reports/cubit/states.dart';
import 'package:icu_project/shared/network/end_points.dart';
import '../../../../models/admin/admin_get_data_model.dart';
import '../../../../models/doctor_reports/add_report.dart';
import '../../../../models/doctor_reports/doctor_get_all_reports.dart';
import '../../../../models/medicines_model.dart';
import '../../../../shared/network/remote/dio.dart';

class DoctorReportsCubit extends Cubit<DoctorReports> {
  DoctorReportsCubit() : super(InitialDoctorReportsState());

  static DoctorReportsCubit getCubit(Context) => BlocProvider.of(Context);

  DoctorAllReports? doctotReportsModel;

  AddDoctorReport? adddoctorReport;

  UpdateDoctorReport? updateDoctorReport;

  void getAllDoctorReports({
    required String patientID,
  }) {
    emit(GetDoctorReportsLoadingState());

    DioHelper.get(url: 'report/$patientID/$GET_ALL_Doctor_REPORTS').then(
      (value) {
        return value.fold((l) {
          doctotReportsModel = DoctorAllReports.fromJson(l);
          emit(GetDoctorReportsScusessState(doctotReportsModel!));
        }, (r) => null);
      },
    );
    // .catchError((error) {
    //   print(error.toString());
    //   emit(GetDoctorReportsErrorState(error.toString()));
    // });
  }

  void AddDoctorsReport(
      {required String title,
      required String patientID,
      required List<String> nurseID}) {
    emit(AddDoctorReportLoadingState());

    DioHelper.post(url: ADD_DOCTOR_REPORT, requestBody: {
      'title': title,
      'patient': patientID,
      'nurse': nurseID,
    }).then((value) {
      return value.fold(
        (registerResponse) {
          // Registration successful
          adddoctorReport = AddDoctorReport.fromJson(registerResponse);
          emit(AddDoctorReportScusessState(adddoctorReport!));
        },
        (error) {
          // Registration failed
          emit(AddDoctorReportErrorState(
              'An error occurred. Please try again.'));
        },
      );
      // return value.fold((l) {
      //   adddoctorReport = AddDoctorReport.fromJson(l);
      //   emit(AddDoctorReportScusessState(adddoctorReport!));
      // }, (r) => null);
    }).catchError((error) {
      print(error.toString());
      emit(AddDoctorReportErrorState(error.toString()));
    });
  }

  void updateDoctorsReport({
    required String title,
    required int id,
    required String patientID,
    required List<String> nurseID,
  }) {
    emit(UpdateDoctorReportLoadingState());

    DioHelper.put(url: '$UPDATE_DOCTOR_Report$id', requestBody: {
      'title': title,
      'patient': patientID,
      'nurse': nurseID,
    }).then(
      (value) {
        return value.fold(
          (registerResponse) {
            // Registration successful
            updateDoctorReport = UpdateDoctorReport.fromJson(registerResponse);
            emit(UpdateDoctorReportScuseesState(updateDoctorReport!));
          },
          (error) {
            // Registration failed
            emit(UpdateDoctorReportErrorState(
                'An error occurred. Please try again.'));
          },
        );
        // return value.fold((l) {
        //   updateDoctorReport = UpdateDoctorReport.fromJson(l);
        //   emit(UpdateDoctorReportScuseesState(updateDoctorReport!));
        // }, (r) => null);
      },
    ).catchError((error) {
      print(error.toString());
      emit(UpdateDoctorReportErrorState(error.toString()));
    });
  }

  AdminData? getAdminData;

  void getAdminProfileData() {
    emit(SignedInLoadingStates());

    DioHelper.get(url: GET_ADMIN_DATA).then((value) {
      return value.fold((l) {
        getAdminData = AdminData.fromJson(l);
        emit(SignedInScuseesStates(getAdminData!));
      }, (r) => null);
    });
    //.catchError((error) {
    //   print(error.toString());
    //   emit(SignedInEroorStates(error.toString()));
    // });
  }

  AddDoctorMedicine? adddoctorMedicine;
  void AddDoctorsMedicine({
    required String quantity,
    required String medicinedosage,
    required String medicineName,
    required String patientID,
    required String start,
    required String end,
    required String time,
  }) {
    emit(AddDoctorMedicineLoadingState());

    DioHelper.post(url: ADD_DOCTOR_MEDICINE, requestBody: {
      'quantity': quantity,
      'dosage': medicinedosage,
      'name': medicineName,
      'patient': patientID,
      'start_date': start,
      'end_date': end,
      'time_clock': time,
    }).then((value) {
      return value.fold(
        (registerResponse) {
          // Registration successful
          adddoctorMedicine = AddDoctorMedicine.fromJson(registerResponse);
          emit(AddDoctorMedicineScusessState(adddoctorMedicine!));
        },
        (error) {
          // Registration failed
          emit(AddDoctorMedicineErrorState(
              'An error occurred. Please try again.'));
        },
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddDoctorMedicineErrorState(error.toString()));
    });
  }
  //     return value.fold((l) {
  //       adddoctorMedicine = AddDoctorMedicine.fromJson(l);
  //       emit(AddDoctorMedicineScusessState(adddoctorMedicine!));
  //     }, (r) => null);
  //   });
  // }

  MedicinesModel? medicinesModel;
  void getAllMedicines() {
    emit(GetMedicinesLoadingState());
    DioHelper.get(
      url: GET_DOCTOR_MEDICINE,
    ).then((value) {
      return value.fold((l) {
        medicinesModel = MedicinesModel.fromJson(l);
        emit(GetMedicinesScusessState(medicinesModel));
      }, (r) => null);
    });
  }
}
